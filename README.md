# Installation

## GitHub
Go check the releases page

## Local
1. Clone the repository:
  - `git clone https://github.com/TurtleP/eclipse`
2. Run `nimble install`
# Usage

Primarily useful for [Visual Studio Code](https://code.visualstudio.com/) Tasks, it can also be used standalone via terminal.<br>
If you would like to see the Tasks I have configured, you may find them [here in this gist](https://gist.github.com/TurtleP/7f60c16266bfdff0a6cc215180d6ef1a)
<br><br>
There is also an optional file you can have, `eclipse.toml`. It allows configuration for the source and build directories, whether to clean the build directory before compilation, and a list of ignore patterns. By default the patterns are: ".\*.yue", ".\*.moon", and "build".

## Options
```
Usage:
  eclipse {SUBCMD}  [sub-command options & parameters]
where {SUBCMD} is one of:
  help     print comprehensive or per-cmd help
  init     Initialize a new configuration file
  build    Build the source directory
  clean    Clean the build directory
  version  Show program version and exit

eclipse {-h|--help} or with no args at all prints this message.
eclipse --help-syntax gives general cligen syntax help.
Run "eclipse {help SUBCMD|SUBCMD --help}" to see help for just SUBCMD.
Run "eclipse help" to get *comprehensive* help.
```
