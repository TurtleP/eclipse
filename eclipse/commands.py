import shutil
import subprocess
from pathlib import Path

from .files import conf_moon, main_moon

_cwd = Path()
_build = Path() / "build"
_exclude = ["build", ".vscode", ".moon",
            ".py", ".git"]


def should_exclude(item=Path):
    for exclusion in _exclude:
        if item.suffix == exclusion:
            return True
        elif exclusion in str(item):
            return True
        elif item.is_dir():
            return True

    return False


def clean():
    if _build.exists():
        shutil.rmtree(_build)

    print("Cleaned build tree successfully.")


def init():
    try:
        with open(f"{_cwd}/main.moon", "w") as entry:
            entry.write(main_moon)

        with open(f"{_cwd}/conf.moon", "w") as conf:
            conf.write(conf_moon)

        print("Initialized new MoonScript LÖVE project successfully.")
    except Exception as e:
        print(f"Failed to initialize project: {e}")

def build():
    _build.mkdir(exist_ok=True)
    _files = list()

    for item in _cwd.rglob("*"):
        if should_exclude(item):
            continue

        _files.append(item)

    if len(_files) == 0:
        return print("No MoonScript files found! Aborting.")

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
