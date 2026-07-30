#!/usr/bin/env python3
"""Sync dotfiles from ~/ into this repo.

Usage:  python sync.py [--dry-run]

Paths are read from watching_files.txt — one relative path per line.
"""

import filecmp
import os
import shutil
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parent
HOME = Path.home()


def read_watching_paths() -> list[str]:
    paths = []
    with open(REPO / "watching_files.txt") as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith("#"):
                paths.append(line)
    return paths


def sync_file(src: Path, dst: Path, dry_run: bool) -> bool:
    if not src.exists():
        return False

    needs_copy = not dst.exists() or not filecmp.cmp(src, dst, shallow=False)
    if not needs_copy:
        return False

    if dry_run:
        print(f"  WOULD COPY  {src}")
    else:
        dst.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(src, dst)
        print(f"  FILE        {src}")
    return True


def sync_dir(src: Path, dst: Path, dry_run: bool) -> bool:
    if not src.exists():
        return False

    copied = False
    dst.mkdir(parents=True, exist_ok=True)

    for entry in src.iterdir():
        rel = entry.relative_to(src)
        dst_entry = dst / rel

        if entry.is_dir():
            if sync_dir(entry, dst_entry, dry_run):
                copied = True
        else:
            if sync_file(entry, dst_entry, dry_run):
                copied = True

    return copied


def sync(src: Path, dst: Path, dry_run: bool) -> bool:
    if not src.exists():
        print(f"  SKIP   {src}  (not found)")
        return False

    if src.is_dir():
        return sync_dir(src, dst, dry_run)
    else:
        return sync_file(src, dst, dry_run)


def main() -> None:
    dry_run = "--dry-run" in sys.argv
    os.chdir(REPO)

    any_copied = False
    for rel in read_watching_paths():
        src = HOME / rel
        dst = REPO / rel
        try:
            if sync(src, dst, dry_run):
                any_copied = True
        except Exception as e:
            print(f"  FAIL   {rel}: {e}", file=sys.stderr)

    if not any_copied:
        print("Nothing to sync — all files already match." if not dry_run else "")


if __name__ == "__main__":
    main()
