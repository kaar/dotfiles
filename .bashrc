# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide. This software is distributed without any warranty.
# You should have received a copy of the CC0 Public Domain Dedication along
# with this software.
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

# /etc/bash.bashrc: executed by bash(1) for interactive shells.

# Install dotfiles onto a new system
#
# Setup alias in current terminal
# alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
# Clone
# git clone --bare git@github.com:kaar/dotfiles.git $HOME/.cfg
#
# Checkout
# config checkout
# config config --local status.showUntrackedFiles no
#
# Usage
# config status
# config add .vimrc
# config commit -m "Add vimrc"
# config add .bashrc
# config commit -m "Add bashrc"
# config push

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# https://www.atlassian.com/git/tutorials/dotfiles
# Create an alias config which will be used instead of the regular git to interact with configuration repository.
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# ----------------------- environment variables ----------------------
export EDITOR=lvim
export VISUAL=lvim
export EDITOR_PREFIX=lvim

export PACKAGE_INSTALL="${HOME}/.install"
export SCRIPTS="${HOME}/.scripts"
export NOTES="${HOME}/notes"
export XDG_CONFIG_HOME="${HOME}/.config"
export REPOS="${HOME}/repos"
export BROWSER=firefox

# fzf
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_TMUX=1

# go
export GOPATH=~/.local/share/go
export GOBIN=~/.local/bin/go/
export GOPROXY=direct
export CGO_ENABLED=0
export PATH="$GOBIN:$PATH"

# dotnet
export DOTNET_TOOLS="$HOME/.dotnet/tools"

# python
# makes pipenv install packages in the project directory
export PIPENV_VENV_IN_PROJECT=1

# ------------------------------ cdpath ------------------------------

export CDPATH=.:~/Dev/:


# ------------------------------- path -------------------------------

export PATH="$SCRIPTS:$PATH"
export PATH="$DOTNET_TOOLS:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# ------------------------------- pager ------------------------------
if test -x /usr/bin/lesspipe; then
  export LESSOPEN="| /usr/bin/lesspipe %s";
  export LESSCLOSE="/usr/bin/lesspipe %s %s";
fi

# "bat" as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# poetry
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring

# ----------------------------- dircolors ----------------------------
eval "$(dircolors -b $XDG_CONFIG_HOME/dircolors/gruvbox)"

# ------------------------------ aliases -----------------------------
alias ls='exa'
alias ll='exa --long --git --group-directories-first --no-filesize --no-time --no-permissions --no-user'
# alias ll='ls --long --group-directories-first --header --git'
alias la='ls --all --group-directories-first -1'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias scripts='cd $SCRIPTS'
alias install='cd $PACKAGE_INSTALL'

# safety features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias reload='source ~/.bashrc ;'
alias install-packages='~/.install/default.sh'

alias '?'=duck
#alias '?'=google

# Kubectl
alias k=kubectl
complete -F __start_kubectl k

alias d='docker'
alias g='git'
alias gist='gh gist'

alias n='nvim'
alias v='vim'
alias l='lvim'
alias diff='difft'

# Gists
alias ideas='gh gist edit ${GIST_IDEAS}'

# Browser
alias browse='firefox -new-tab'

# AWS
alias aws-session='aws sso login'

# tailscale
alias ts='tailscale'

# other
alias aws-cloudwatch='open ${AWS_URL_CLOUDWATCH}'
alias aws-console='open ${AWS_URL_CONSOLE}'
alias aws-iam='open ${AWS_URL_IAM}'

# python
alias set-python-path='export PYTHONPATH="$PYTHONPATH:$PWD/src:$PWD/test"'

# secrets
alias source-secrets='source ~/.config/secrets.env'

# gpt
alias g='gpt -m'

# Load all scripts in shell.d
for file in ~/.config/shell.d/*.sh ; do
  [ -f "$file" ] && source $file
done

# Bash Completion
if [ -f /etc/bash_completion ]; then
   source /etc/bash_completion
fi

# Local bash completion
for bcfile in ~/.config/bash_completion.d/* ; do
  [ -f "$bcfile" ] && source $bcfile
done

# aws
complete -C 'aws_completer' aws

# nvm
# https://github.com/nvm-sh/nvm
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"


# ------------------------------ bind ---------------------------------
bind -x '"\C-j":sessions'

# ------------------------------ prompt -------------------------------
source $HOME/.config/git/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

RED="\[\033[0;31m\]"
YELLOW="\[\033[1;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[1;34m\]"
PURPLE="\[\033[0;35m\]"
LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
WHITE="\[\033[1;37m\]"
LIGHT_GRAY="\[\033[0;37m\]"
COLOR_NONE="\[\e[0m\]"

if test -z "$VIRTUAL_ENV" ; then
    PYTHON_VIRTUALENV=""
else
    PYTHON_VIRTUALENV="${YELLOW}[`basename \"$VIRTUAL_ENV\"`]${COLOR_NONE} "
fi

PROMPT_COMMAND='__git_ps1 "${PYTHON_VIRTUALENV}${BLUE}\W${COLOR_NONE}" "${COLOR_NONE} "'
PS1='__git_ps1 "${PYTHON_VIRTUALENV}${BLUE}\W${COLOR_NONE}" "${COLOR_NONE} "'

# ------------------------------ settings -----------------------------

set -o vi               # replace readline with vi mode
HISTCONTROL=ignoreboth  # No duplicated lines
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize   # check the window size and update LINES,COLUMNS
shopt -s histappend     # don't override history
shopt -s autocd         # change to named directory
shopt -s cdspell        # autocorrects cd misspellings
shopt -s autocd         # change to named directory
shopt -s cmdhist        # save multi-line commands in history as single line
shopt -s dotglob
shopt -s expand_aliases # expand aliases

# Free up flow control keys like Ctrl+Q, Ctrl+S for more usefull bindings
stty -ixon

# direnv
eval "$(direnv hook bash)"
. "$HOME/.cargo/env"
