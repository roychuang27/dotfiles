#!/bin/sh

dry_run=false
case "${1:-}" in --dry-run) dry_run=true ;; esac

REPO="$(cd "$(dirname "$0")" && pwd)"
WATCH_FILE="$REPO/watching_files.txt"
[ -f "$WATCH_FILE" ] || { echo "Error: $WATCH_FILE not found" >&2; exit 1; }

any_copied=false

_sync_file() {
  _sf_src="$1" _sf_dst="$2"
  [ -f "$_sf_src" ] || return 1
  [ -f "$_sf_dst" ] && cmp -s "$_sf_src" "$_sf_dst" && return 1
  if [ "$dry_run" = true ]; then
    echo "  WOULD COPY  $_sf_src"
  else
    mkdir -p "$(dirname "$_sf_dst")"
    cp -p "$_sf_src" "$_sf_dst"
    echo "  FILE        $_sf_src"
  fi
  any_copied=true
}

_sync_dir() {
  _sd_src="$1" _sd_dst="$2"
  [ -d "$_sd_src" ] || return 1
  mkdir -p "$_sd_dst"
  for _sd_entry in "$_sd_src"/*; do
    [ -e "$_sd_entry" ] || continue
    _sd_name="${_sd_entry##*/}"
    if [ -d "$_sd_entry" ]; then
      _sync_dir "$_sd_entry" "$_sd_dst/$_sd_name"
    else
      _sync_file "$_sd_entry" "$_sd_dst/$_sd_name"
    fi
  done
  for _sd_entry in "$_sd_src"/.*; do
    _sd_name="${_sd_entry##*/}"
    case "$_sd_name" in .|..) continue ;; esac
    [ -e "$_sd_entry" ] || continue
    if [ -d "$_sd_entry" ]; then
      _sync_dir "$_sd_entry" "$_sd_dst/$_sd_name"
    else
      _sync_file "$_sd_entry" "$_sd_dst/$_sd_name"
    fi
  done
}

while IFS= read -r line; do
  rel=$(printf '%s' "$line" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e 's,/*$,,')
  case "$rel" in ''|'#'*) continue ;; esac

  src="$HOME/$rel" dst="$REPO/$rel"
  if [ ! -e "$src" ]; then
    echo "  SKIP   $src  (not found)"
    continue
  fi
  if [ -d "$src" ]; then _sync_dir "$src" "$dst"
  else _sync_file "$src" "$dst"
  fi
done < "$WATCH_FILE"

[ "$any_copied" = true ] || echo "Nothing to sync -- all files already match."
