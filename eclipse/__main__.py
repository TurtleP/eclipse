from argparse import ArgumentParser

from . import commands
from eclipse import __version__, __description__


def main():
    argparse = ArgumentParser("eclipse", description=__description__)

    argparse.add_argument("--clean", "-c", action="store_true")
    argparse.add_argument("--init", "-i", action="store_true")
    argparse.add_argument("--version", "-v", action="store_true")

    parsed = argparse.parse_args()

    if parsed.version:
        return

    if parsed.clean:
        return commands.clean()
    elif parsed.init:
        return commands.init()

    return commands.build()


if __name__ == "__main__":
    main()
