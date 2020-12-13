# Installation

## GitHub
To get the latest version from Github:
- Linux
  - `sudo pip(3) install -U git+git://github.com/TurtleP/eclipse.git`
- Windows
  - `pip install -U git+git://github.com/TurtleP/eclipse.git`

## Local
1. Clone the repository:
  - `git clone https://github.com/TurtleP/eclipse`
2. Run pip install
  - Linux
    - `sudo pip(3) install -U ./eclipse`
  - Windows
    - `pip install -U ./eclipse`
    
# Usage

Primarily useful for [Visual Studio Code](https://code.visualstudio.com/) Tasks, it can also be used standalone via terminal.<br>
If you would like to see the Tasks I have configured, you may find them [here in this gist](https://gist.github.com/TurtleP/7f60c16266bfdff0a6cc215180d6ef1a)
<br><br>
There is also an optional file you can have, `.eclipseignore`. It does the same thing as `.gitignore` with the same syntax. This will *igonre* specified files or directories from being "built"/copied.

## Options
```
❯ eclipse -h
usage: eclipse [-h] [--clean] [--init] [--version]

MoonScript & LÖVE Helper

optional arguments:
  -h, --help     show this help message and exit
  --clean, -c    Cleans the build directory
  --init, -i     Initialize a new LÖVE project, using MoonScript
  --version, -v  Show version information
```
