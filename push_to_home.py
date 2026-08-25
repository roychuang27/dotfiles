import filecmp
import shutil
import sys
from datetime import datetime
from pathlib import Path

DIR = Path(__file__).resolve().parent
HOME = Path.home()
WATCH_FILE = DIR / "watching_files.txt"
BACKUP_DIR = DIR / ".backup"
DRY_RUN = "--dry-run" in sys.argv


def watch_paths() -> list[str]:
    """Return the relative paths to deploy, skipping blank and '#' comment lines."""
    if not WATCH_FILE.is_file():
        print(f"Error: {WATCH_FILE} not found", file=sys.stderr)
        sys.exit(1)

    paths = []
    for line in WATCH_FILE.read_text().splitlines():
        rel = line.strip().rstrip("/")
        if not rel or rel.startswith("#"):
            continue
        paths.append(rel)
    return paths


def deploy_file(src: Path, dst: Path) -> None:
    """Copy one file from the repo into $HOME, prompting on conflicts."""
    if not src.is_file():
        return

    if dst.is_file() and not filecmp.cmp(src, dst, shallow=False):
        print(f"  CONFLICT  {dst}")
        try:
            answer = input("    [b]ackup & override, [s]kip? ").strip().lower()
        except (EOFError, KeyboardInterrupt):
            answer = ""
        if answer != "b":
            print("    Skipped.")
            return

        rel = str(dst.relative_to(HOME))
        ts = datetime.now().strftime("%Y%m%d_%H%M%S")
        bak = BACKUP_DIR / f"{rel}.{ts}"
        if DRY_RUN:
            print(f"    WOULD BACKUP {dst} -> {bak}")
        else:
            bak.parent.mkdir(parents=True, exist_ok=True)
            shutil.move(str(dst), str(bak))
            print(f"    BACKUP  {dst} -> {bak}")

    if dst.is_file() and filecmp.cmp(src, dst, shallow=False):
        return

    if DRY_RUN:
        print(f"  WOULD COPY  {src} -> {dst}")
        return

    dst.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(src, dst)
    print(f"  COPY    {src} -> {dst}")


def deploy_dir(src: Path, dst: Path) -> None:
    """Recursively deploy a watched directory (including hidden entries)."""
    if not src.is_dir():
        return

    dst.mkdir(parents=True, exist_ok=True)
    for entry in src.iterdir():
        if entry.is_dir():
            deploy_dir(entry, dst / entry.name)
        else:
            deploy_file(entry, dst / entry.name)


def main() -> None:
    for rel in watch_paths():
        src, dst = DIR / rel, HOME / rel
        if src.is_dir():
            deploy_dir(src, dst)
        else:
            deploy_file(src, dst)


if __name__ == "__main__":
    main()
