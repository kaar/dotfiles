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

# dircolors
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

## Settings

# vi mode
set -o vi

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize # check the window size and update LINES,COLUMNS
shopt -s histappend   # don't override history
shopt -s autocd       # change to named directory
shopt -s cdspell      # autocorrects cd misspellings

# ignore case for TAB completion
bind "set completion-ignore-case on"

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Free up flow control keys like Ctrl+Q, Ctrl+S for more usefull bindings
stty -ixon
