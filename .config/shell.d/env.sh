#!/bin/sh

## Location for installation scripts
export INSTALL="${HOME}/.install"
export SCRIPTS="${HOME}/.scripts"
export BIN="$HOME/.local/bin"
export NOTES="${HOME}/notes"
export NEW_TEMPLATES="$HOME/repos/kaar/new/templates"
export XDG_CONFIG_HOME="${HOME}/.config"
# Source code repositories
export REPOS="${HOME}/repos"
# Where cd should look for completion
export CDPATH="."

# Browser
export BROWSER=firefox

# GO
export GOPATH="$HOME/Go" # or any directory to put your Go code
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"

# PATH
export PATH="${SCRIPTS}:$PATH"

# FZF
# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# NVM
export NVM_DIR="$HOME/.config/nvm"

### "bat" as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
