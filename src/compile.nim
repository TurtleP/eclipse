import osproc

proc compile*(command: string): bool =
    let cmdResult = osproc.execCmdEx(command)

    if cmdResult.exitCode != 0:
        echo(cmdResult.output)
        return false

    return true
