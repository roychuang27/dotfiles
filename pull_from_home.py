import filecmp
import shutil
import sys
from pathlib import Path

DIR = Path(__file__).resolve().parent
HOME = Path.home()
WATCH_FILE = DIR / "watching_files.txt"
DRY_RUN = "--dry-run" in sys.argv


def watch_paths() -> list[str]:
    """Return the relative paths to sync, skipping blank and '#' comment lines."""
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


def sync_file(src: Path, dst: Path) -> bool:
    """Copy a single file from $HOME into the repo if the two differ."""
    if not src.is_file():
        return False
    if dst.is_file() and filecmp.cmp(src, dst, shallow=False):
        return False

    if DRY_RUN:
        print(f"  WOULD COPY  {src}")
    else:
        dst.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(src, dst)
        print(f"  FILE        {src}")
    return True


def sync_dir(src: Path, dst: Path) -> bool:
    """Recursively sync a watched directory (including hidden entries)."""
    if not src.is_dir():
        return False

    dst.mkdir(parents=True, exist_ok=True)
    copied = False
    for entry in src.iterdir():
        if entry.is_dir():
            if sync_dir(entry, dst / entry.name):
                copied = True
        else:
            if sync_file(entry, dst / entry.name):
                copied = True
    return copied


def main() -> None:
    any_copied = False
    for rel in watch_paths():
        src, dst = HOME / rel, DIR / rel
        if not src.exists():
            print(f"  SKIP   {src}  (not found)")
            continue
        if src.is_dir():
            if sync_dir(src, dst):
                any_copied = True
        else:
            if sync_file(src, dst):
                any_copied = True

    if not any_copied:
        print("Nothing to sync -- all files already match.")


if __name__ == "__main__":
    main()
