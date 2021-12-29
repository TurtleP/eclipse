const NimbleFile = "../eclipse.nimble"
const AppFile* = staticRead(strings.NimbleFile)

const AppNotFound* = """
The application '$1' could not be found. Please check
your PATH environment variable and try again.

Alerntatively, it may not be installed. Please install it."""

const ConfigExists* = """
Config file already exists in this directory. Overwrite? [y/N]:"""

const ConfigOverwriteFailed* = """
Config file was not overwritten due to an error: $1"""
