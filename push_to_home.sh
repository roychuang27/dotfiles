#!/bin/sh

dry_run=false
case "${1:-}" in --dry-run) dry_run=true ;; esac

REPO="$(cd "$(dirname "$0")" && pwd)"
WATCH_FILE="$REPO/watching_files.txt"
[ -f "$WATCH_FILE" ] || { echo "Error: $WATCH_FILE not found" >&2; exit 1; }

_deploy_file() {
  _df_src="$1" _df_dst="$2"
  [ -f "$_df_src" ] || return

  if [ -f "$_df_dst" ] && ! cmp -s "$_df_src" "$_df_dst"; then
    echo "  CONFLICT  $_df_dst"
    printf '    [b]ackup & override, [s]kip? ' >&2
    read -r answer < /dev/tty
    case "$answer" in b|B) ;; *)
      echo "    Skipped."
      return
    esac
    ts=$(date +%Y%m%d_%H%M%S)
    rel="${_df_dst#"$HOME"/}"
    bak="$REPO/.backup/$rel.$ts"
    if [ "$dry_run" = true ]; then
      echo "    WOULD BACKUP $_df_dst -> $bak"
    else
      mkdir -p "$(dirname "$bak")"
      mv "$_df_dst" "$bak"
      echo "    BACKUP  $_df_dst -> $bak"
    fi
  fi

  [ -f "$_df_dst" ] && cmp -s "$_df_src" "$_df_dst" && return

  if [ "$dry_run" = true ]; then
    echo "  WOULD COPY  $_df_src -> $_df_dst"
  else
    mkdir -p "$(dirname "$_df_dst")"
    cp -p "$_df_src" "$_df_dst"
    echo "  COPY    $_df_src -> $_df_dst"
  fi
}

_deploy_dir() {
  _dd_src="$1" _dd_dst="$2"
  [ -d "$_dd_src" ] || return
  for _dd_entry in "$_dd_src"/*; do
    [ -e "$_dd_entry" ] || continue
    _dd_name="${_dd_entry##*/}"
    if [ -d "$_dd_entry" ]; then
      _deploy_dir "$_dd_entry" "$_dd_dst/$_dd_name"
    else
      _deploy_file "$_dd_entry" "$_dd_dst/$_dd_name"
    fi
  done
  for _dd_entry in "$_dd_src"/.*; do
    _dd_name="${_dd_entry##*/}"
    case "$_dd_name" in .|..) continue ;; esac
    [ -e "$_dd_entry" ] || continue
    if [ -d "$_dd_entry" ]; then
      _deploy_dir "$_dd_entry" "$_dd_dst/$_dd_name"
    else
      _deploy_file "$_dd_entry" "$_dd_dst/$_dd_name"
    fi
  done
}

while IFS= read -r line; do
  rel=$(printf '%s' "$line" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e 's,/*$,,')
  case "$rel" in ''|'#'*) continue ;; esac

  src="$REPO/$rel" dst="$HOME/$rel"
  if [ -d "$src" ]; then _deploy_dir "$src" "$dst"
  else _deploy_file "$src" "$dst"
  fi
done < "$WATCH_FILE"
