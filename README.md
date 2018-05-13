# SwitchCI Docker
_An updated development environment for the Nintendo Switch_

## Goals
- Provide an automated way to setup a switch dev environment
- Provide an easy way to compile switch homebrew locally
- Provide a solution for continuous integration
- Provide the latest libraries by compiling from source

## Building image
```
docker build -t switchci .
```

## Running image
```
docker run -it switchci /bin/bash
```

## Build project in current directory
```
docker run -it -v "$(pwd)":/app switchci make
```

## switchmake command

Linux:
```
echo alias switchmake=\'docker run -it -v '"$(pwd)"':/app switchci make\' >> ~/.bashrc
source ~/.bashrc
```

Mac:
```
echo alias switchmake=\'docker run -it -v '"$(pwd)"':/app switchci make\' >> ~/.bash_profile
source ~/.bash_profile
```

Usage:
```
cd <switch homebrew project>
switchmake clean
switchmake
```