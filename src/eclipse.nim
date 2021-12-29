import os
import strutils, strformat
import rdstdin
import sequtils

import strings
import configure
import data
import compile

import cligen

const AppVersion = AppFile.fromNimble("version")

proc init() =
    ## Initialize a new configuration file

    if not os.fileExists(configure.ConfigFilePath):
        writeFile(configure.ConfigFilePath, data.DefaultConfigFile)
        return

    var answer: string
    discard readLineFromStdin(strings.ConfigExists, line = answer)

    if answer.toLower() == "y":
        try:
            writeFile(configure.ConfigFilePath, data.DefaultConfigFile)
        except Exception as e:
            echo(strings.ConfigOverwriteFailed.format(e.msg))

proc clean() =
    ## Clean the build directory

    configure.load()

    if os.dirExists(config.build):
        os.removeDir(config.build)

proc build() =
    ## Build the source directory

    configure.load()

    let compiler = config.compiler
    if findExe($compiler).isEmptyOrWhitespace():
        raise Exception.newException(strings.AppNotFound.format(compiler))

    if config.clean:
        clean()

    os.createDir(config.build)
    let output = fmt("{os.getCurrentDir()}/{config.build}")
    var command: string

    if compiler == CompilerType.YUE:
        command = fmt("yue -s -t {output} {config.source}")
    elif compiler == CompilerType.MOON:
        command = fmt("moonc -t  {output} {config.source}")

    if not compile.compile(command):
        return

    for item in os.walkDirRec(config.source, relative = true):
        let shouldSkip = config.exclusions.anyIt(configure.hasExclusion(item, it))

        if os.isHidden(item) or shouldSkip:
            continue

        let (dir, _, _) = os.splitFile(item)
        let destination = fmt("{config.build}/{dir}")

        os.createDir(destination)

        try:
            os.copyFileToDir(item, destination)
        except OSError as e:
            echo(e.msg)

proc version() =
    ## Show program version and exit

    echo(AppVersion)

when isMainModule:
    dispatchMulti([init], [build], [clean], [version])
