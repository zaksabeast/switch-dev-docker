# SwitchCI Docker
_An updated development environment for the Nintendo Switch_

## Goals
- Provide an automated way to setup a switch dev environment
- Provide an easy way to compile switch homebrew locally
- Provide a solution for continuous integration
- Provide the latest libraries by compiling from source

## Pulling image
```
docker pull zaksabeast/switchci
```

## Running image
```
docker run -it zaksabeast/switchci /bin/bash
```

## Build project in current directory
```
docker run -it -v "$(pwd)":/app zaksabeast/switchci make
```

## Building image
```
docker build -t switchci .
```

## switchmake command

Linux:
```
echo alias switchmake=\'docker run -it -v '"$(pwd)"':/app zaksabeast/switchci make\' >> ~/.bashrc
source ~/.bashrc
```

Mac:
```
echo alias switchmake=\'docker run -it -v '"$(pwd)"':/app zaksabeast/switchci make\' >> ~/.bash_profile
source ~/.bash_profile
```

Usage:
```
cd <switch homebrew project>
switchmake clean
switchmake
```