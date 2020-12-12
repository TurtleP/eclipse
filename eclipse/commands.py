import shutil
import subprocess
from pathlib import Path

_cwd = Path()
_build = Path() / "build"
_exclude = ["build", ".moon"]
_ignore = _cwd / ".eclipseignore"

PATH = Path(__file__).parent


def should_exclude(item=Path):
    for exclusion in _exclude:
        if item.suffix == exclusion:
            return True
        elif str(exclusion) in str(item):
            return True

    return False


def clean():
    if _build.exists():
        shutil.rmtree(_build)

    print("Cleaned build tree successfully.")


def init():
    try:
        _files = PATH / "data"
        for item in _files.rglob("*"):
            shutil.copy2(item, _cwd)

        print("Initialized new MoonScript LÖVE project successfully.")
    except Exception as e:
        print(f"Failed to initialize project: {e}")

def check_ignore():
    if _ignore.exists():
        with open(_ignore, "r") as file:
            for line in file.readline():
                _exclude.append(_cwd / line)

def build():
    _build.mkdir(exist_ok=True)
    _files = list()

    check_ignore()

    for item in _cwd.rglob("*"):
        if should_exclude(item):
            continue

        _files.append(item)

    try:
        for item in _files:
            (_build / item).parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(item, _build / item)
    except Exception as e:
        print(e)

    try:
        subprocess.run("moonc -t build .")
    except subprocess.CalledProcessError as e:
        print(e)
