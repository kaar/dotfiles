#!/bin/sh

export SCRIPTS="${HOME}/.scripts"
export BIN="$HOME/.local/bin"
export NOTES="${HOME}/notes"
export NEW_TEMPLATES="$HOME/repos/kaar/new/templates"
export XDG_CONFIG_HOME="${HOME}/.config"
# Source code repositories
export REPOS="${HOME}/repos"
# Where cd should look for completion
export CDPATH=.:~:~/Dev

# GO
export GOPATH="$HOME/Go" # or any directory to put your Go code
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"

# PATH
## Visual Studio
export PATH="/mnt/c/Program Files (x86)/Microsoft Visual Studio/2019/Professional/Common7/IDE/:$PATH"

## Rider
rider="/mnt/c/Program Files/JetBrains/JetBrains Rider 2021.1.1/bin/"
[ -d "${rider}" ] && export PATH="${rider}:$PATH"

export PATH="${SCRIPTS}:$PATH"

# TEMP
export TMP="${HOME}/.tmp"
export TEMP="${HOME}/.tmp"
mkdir -p "${TMP}"
mkdir -p "${TMP}/vim"
