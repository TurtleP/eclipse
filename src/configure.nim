import os
import strutils
import sequtils
import strformat

import parsetoml
import regex

import data

type
    CompilerType* = enum
        YUE = "yue"
        MOON = "moonc"

type
    ConfigFile = object
        build*: string
        source*: string
        clean*: bool
        exclusions*: seq[string]
        compiler*: CompilerType

var config*: ConfigFile
let ConfigFilePath* = os.normalizedPath(os.getCurrentDir() & "/eclipse.toml")

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

    let defaultExclude = @[".*.yue", ".*.moon", "build"]

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

    case compiler:
        of "yue":
            config.compiler = CompilerType.YUE
        of "moonc":
            config.compiler = CompilerType.MOON
