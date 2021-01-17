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

# Aliases
source ~/.bash_aliases

# Prompt
source ~/.git-prompt.sh
GIT_PS1_SHOWCOLORHINTS=1
PS1='\[\033[01;34m\]\w\[\033[00m\] \$ '
PROMPT_COMMAND='__git_ps1 "\[\033[01;34m\]\w\[\033[00m\]" " \033]0;${PWD##*/}\a"'

# PATH config
export PATH="/mnt/c/Program Files (x86)/Microsoft Visual Studio/2019/Professional/Common7/IDE/:$PATH"
export GOPATH="$HOME/Go" # or any directory to put your Go code
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"
export PATH="$PATH:~/.bin/"

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Free up flow control keys like Ctrl+Q, Ctrl+S for more usefull bindings
stty -ixon

# dircolors
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# enable programmable completion features
source /usr/share/bash-completion/bash_completion

# Load tmux completion
source ~/.completion/tmux

# FZF config
# /usr/share/doc/fzf/README.Debian
source ~/.config/fzf/key-bindings.bash
source ~/.config/fzf/completion.bash
# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fdfind --type f'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"


# cheat.sh
source ~/.config/cht.sh/completion.bash

# Load wsl-1 specific config
# WSL 1 specific settings.
if grep -qE "(Microsoft|WSL)" /proc/version &>/dev/null; then
	source ~/.config/bash/wsl.bash
fi
