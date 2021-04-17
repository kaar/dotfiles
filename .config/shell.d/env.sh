#!/bin/sh

export SCRIPTS="${HOME}/.scripts"
export PATH="${SCRIPTS}:$PATH"

export NOTES="${HOME}/notes"
export XDG_CONFIG_HOME="${HOME}/.config"

# Rider
rider="/mnt/c/Program Files/JetBrains/JetBrains Rider 2021.1.1/bin/"
[ -d "${rider}" ] && export PATH="${rider}:$PATH"
