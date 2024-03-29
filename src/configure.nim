import os
import strutils
import sequtils
import strformat

import parsetoml
import regex

import data

type
    CompilerType* = enum
        COMPILER_TYPE_YUE = "yue"
        COMPILER_TYPE_MOON = "moonc"
        COMPILER_TYPE_UNKNOWN

type
    ConfigFile = object
        build*: string
        source*: string
        clean*: bool
        exclusions*: seq[string]
        compiler*: CompilerType

var config*: ConfigFile

let CurrentDirectory* = os.normalizedPath(os.getCurrentDir())
let ConfigFilePath* = os.normalizedPath(fmt("{CurrentDirectory}/eclipse.toml"))

proc debug*() =
    echo("[ConfigFile]")

    for name, value in fieldPairs(config):
        echo(name, " -> ", value)

proc hasExclusion*(path: string, x: string): bool =
    var m: RegexMatch
    let pattern = re(fmt("{x}"))

    let found = regex.find(path, pattern, m)
    return found


proc load*() =
    var toml: TomlValueRef

    try:
        toml = parseFile(ConfigFilePath)
    except Exception:
        toml = parseString(data.DefaultConfigFile)

    let section = toml["options"]

    let defaultExclude = @[".*.yue", ".*.moon", "build", "eclipse.toml", ".*.git"]

    config.build = section["build"].getStr()

    var source = section["source"].getStr()
    if source.isEmptyOrWhitespace():
        source = os.getCurrentDir()

    config.source = os.relativePath(source, os.absolutePath(source))
    config.clean = section["clean"].getBool()

    for item in section["exclude"].getElems():
        config.exclusions.add(item.getStr())

    config.exclusions = config.exclusions.concat(defaultExclude)
    let compiler = section["compiler"].getStr()

    try:
        config.compiler = parseEnum[CompilerType](compiler)
    except Exception:
        config.compiler = CompilerType.COMPILER_TYPE_UNKNOWN
