#!/usr/bin/env python3
"""Deploy dotfiles from this repo into ~/.

Usage:  python sync.py [--dry-run]

Automatically syncs every file in the repo (except EXCLUDE entries),
prompting on conflicts per file.
"""

import filecmp
import os
import shutil
import sys
from datetime import datetime
from pathlib import Path

REPO = Path(__file__).resolve().parent
HOME = Path.home()

EXCLUDE = {
    ".git",
    ".gitignore",
    "pull_from_home.py",
    "push_to_home.py",
    ".clangd",
    ".clang-format",
    "Microsoft.PowerShell_profile.ps1",
}


def backup_path(p: Path) -> Path:
    ts = datetime.now().strftime("%Y%m%d_%H%M%S")
    return p.with_name(f"{p.name}.bak.{ts}")


def files_differ(src: Path, dst: Path) -> bool:
    return dst.exists() and not filecmp.cmp(src, dst, shallow=False)


def is_excluded(rel: Path) -> bool:
    for part in rel.parts:
        if str(part) in EXCLUDE or str(rel) in EXCLUDE:
            return True
    return False


def collect_files() -> list[Path]:
    files = []
    for entry in REPO.rglob("*"):
        if not entry.is_file():
            continue
        rel = entry.relative_to(REPO)
        if not is_excluded(rel):
            files.append(rel)
    return files


def deploy_file(src: Path, dst: Path, dry_run: bool) -> None:
    if dst.exists() and files_differ(src, dst):
        print(f"  CONFLICT  {dst}")
        answer = input("    [b]ackup & override, [s]kip? ").strip().lower()
        if answer != "b":
            print(f"    Skipped.")
            return
        bak = backup_path(dst)
        if dry_run:
            print(f"    WOULD BACKUP {dst} -> {bak}")
        else:
            shutil.move(dst, bak)
            print(f"    BACKUP  {dst} -> {bak}")

    if dst.exists() and not files_differ(src, dst):
        return

    if dry_run:
        print(f"  WOULD COPY  {src} -> {dst}")
        return

    dst.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(src, dst)
    print(f"  COPY    {src} -> {dst}")


def main() -> None:
    dry_run = "--dry-run" in sys.argv
    os.chdir(REPO)

    files = collect_files()
    if not files:
        print("Nothing to deploy.")
        return

    for rel in files:
        src = REPO / rel
        dst = HOME / rel
        try:
            deploy_file(src, dst, dry_run)
        except Exception as e:
            print(f"  FAIL   {rel}: {e}", file=sys.stderr)


if __name__ == "__main__":
    main()
