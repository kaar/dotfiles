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
export EDITOR=vim
export VISUAL=vim
export EDITOR_PREFIX=vim

export INSTALL="${HOME}/.install"
export SCRIPTS="${HOME}/.scripts"
export NOTES="${HOME}/notes"
export XDG_CONFIG_HOME="${HOME}/.config"
export REPOS="${HOME}/repos"
export BROWSER=firefox
export NVM_DIR="$HOME/.config/nvm"

# fzf
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# go
export GOPATH=~/.local/share/go
export GOBIN=/usr/bin/go
export GOPROXY=direct
export CGO_ENABLED=0

# dotnet
export DOTNET_TOOLS="$HOME/.dotnet/tools"

# ------------------------------ cdpath ------------------------------

export CDPATH=.:\
~/repos/:\
~

# ------------------------------- path -------------------------------

export PATH="$SCRIPTS:$PATH"
export PATH="$DOTNET_TOOLS:$PATH"
export PATH="$GOPATH:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# ------------------------------- pager ------------------------------
if test -x /usr/bin/lesspipe; then
  export LESSOPEN="| /usr/bin/lesspipe %s";
  export LESSCLOSE="/usr/bin/lesspipe %s %s";
fi

# "bat" as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# ----------------------------- dircolors ----------------------------

if command -v dircolors &>/dev/null; then
  if test -r ~/.dircolors; then
    eval "$(dircolors -b ~/.dircolors.gruvbox)"
  else
    eval "$(dircolors -b)"
  fi
fi

# ------------------------------ aliases -----------------------------
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias scripts='cd $SCRIPTS'
alias install='cd $INSTALL'

# safety features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias reload='source ~/.bashrc ;'
alias install-packages='~/.install/default.sh'

alias '?'=duck
#alias '?'=google

# Vim
alias vim='nvim'
alias vi='vim'
alias v='vim'

# Kubectl
alias k=kubectl
complete -F __start_kubectl k

alias d='docker'
alias g='git'
alias gist='gh gist'

# Gists
alias todo='gh gist edit ${GIST_TODO}'
alias tibber-todo='gh gist edit ${GIST_TODO_TIBBER}'
alias ideas='gh gist edit ${GIST_IDEAS}'

# GitHub
alias github-pr='github-create-pr'
alias github='github-open'

# Browser
alias browse='firefox -new-tab'

# AWS
alias aws-session='source ${SCRIPTS}/aws/get-session-token.sh $(${SCRIPTS}/op/get-totp "Amazon")'

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
if [ -f "/usr/share/nvm/init-nvm.sh" ]; then
  source "/usr/share/nvm/init-nvm.sh"
fi

# ------------------------------ prompt -------------------------------
source ~/.config/git/git-prompt.sh

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

#PS1='${PWD#"${PWD%/*/*}/"} \$ '
PROMPT_COMMAND='__git_ps1 "\[\e[01;34m\]\W\[\e[m\]" "\[\] "'

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
