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
*) return ;;
esac

# dotfiles config, see: ./README.md
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# TODO: If I set foot as TERM it messes up the colors when I ssh into machines.
# Can not use less and all the colors are non existing.
export TERM=xterm-256color
# if test -x /usr/bin/foot ; then
#   export TERM=foot
# else
#   # Fallback to xterm-256color if foot is not installed
#   export TERM=xterm-256color
# fi

# XDG
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"

export EDITOR=nvim
export VISUAL=nvim
export EDITOR_PREFIX=nvim

export PACKAGE_INSTALL="${HOME}/.install"
export SCRIPTS="${HOME}/.scripts"
export NOTES="${HOME}/notes"
export REPOS="${HOME}/repos"
export BROWSER=firefox

# fzf
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_TMUX=1

# dotnet
# This is my own hack as I can't understand how to install dotnet correctly.
# Rider and IDEs like that looks for dotnet in $HOME/.dotnet
# So I add it to the path and be done with it.
# Stupid Microsoft, have to make everything so complicated.
if test -d "$HOME/.dotnet"; then
  export DOTNET_TOOLS="$HOME/.dotnet/tools"
  export DOTNET_ROOT="$HOME/.dotnet"
  export PATH="$DOTNET_PATH:$PATH"
  export PATH="$DOTNET_TOOLS:$PATH"
fi

# ------------------------------- path -------------------------------

export PATH="$SCRIPTS:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# ------------------------------- pager ------------------------------
# I don't have lesspipe installed. Not sure what I needed this for...
if test -x /usr/bin/lesspipe; then
  export LESSOPEN="| /usr/bin/lesspipe %s"
  export LESSCLOSE="/usr/bin/lesspipe %s %s"
fi

# Use $EDITOR (nvim) as manpager
export MANPAGER="$EDITOR +Man!"

# "bat" as manpager
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# Using bash as a man pager stopped working as some escapes
# did not render correctly.
# Went back to using LESS_TERMCAP for now.

# Have less display colours
# from: https://wiki.archlinux.org/index.php/Color_output_in_console#man
# export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
# export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
# export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
# export LESS_TERMCAP_us=$'\e[01;37m'    # begin underline
# export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
# export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
# export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
# export GROFF_NO_SGR=1                  # for konsole and gnome-terminal
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# export LESS="--RAW-CONTROL-CHARS"
# export MANPAGER="lvim -c 'set ft=man' -"


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
alias g='ag'
alias gist='gh gist'

alias n='nvim'
alias v='vim'

# tailscale
alias ts='tailscale'

# Load all scripts in shell.d
for file in ~/.config/shell.d/*.sh; do
  [ -f "$file" ] && source $file
done

# Local bash completion
for bcfile in ~/.config/bash_completion.d/*; do
  [ -f "$bcfile" ] && source $bcfile
done

# system bash completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi

# aws
complete -C 'aws_completer' aws

# nvm
# https://github.com/nvm-sh/nvm
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"


# ------------------------------ bind ---------------------------------
# Disable the "XON/XOFF" flow control to free up Ctrl-S and Ctrl-Q
stty -ixon

# This binding does not work unless the .bashrc is re-sources
# Not sure why that is so I'm disabling it for now.
# bind '"\C-f":"file-search-preview\n"'

# ------------------------------ colors & prompt ------------------------------

BLACK='\[\e[30m\]'
RED='\[\e[31m\]'
GREEN='\[\e[32m\]'
YELLOW='\[\e[33m\]'
BLUE='\[\e[34m\]'
PURPLE='\[\e[35m\]' # magenta
CYAN='\[\e[36m\]'
WHITE='\[\e[37m\]'

GRAY='\[\e[90m\]'
LIGHT_RED='\[\e[91m\]'
LIGHT_GREEN='\[\e[92m\]'
LIGHT_YELLOW='\[\e[93m\]'
LIGHT_BLUE='\[\e[94m\]'
LIGHT_PURPLE='\[\e[95m\]'
LIGHT_CYAN='\[\e[96m\]'
LIGHT_WHITE='\[\e[97m\]'

RESET='\[\e[0m\]'

PS1="${YELLOW}\w${RESET}\n${GREEN}\$ ${RESET}"

# ------------------------------ settings -----------------------------
# replace readline with vi mode
set -o vi

# Avoid duplicates and commands starting with space
HISTCONTROL=ignoredups:erasedups:ignorespace
# A negative value make the history unlimited
HISTSIZE=-1
HISTFILESIZE=-1
HISTTIMEFORMAT='%F %T '
# Ignore trivial/unimportant commands
HISTIGNORE="ls:ls -l:ls -la:cd:cd -:pwd:clear:history:exit"
# Save after every command
# PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# This is not very good as it messes up the history between terminals.
#
# Save history on terminal close
# PROMPT_COMMAND='history -a'
# This does not work as it break my terminal for some reason. Don't have time for this...

# === shopt ===

shopt -s checkwinsize   # check the window size and update LINES,COLUMNS
shopt -s histappend     # don't override history
shopt -s cdspell        # autocorrects cd misspellings
shopt -s autocd         # change to named directory
shopt -s cmdhist        # save multi-line commands in history as single line
shopt -s dotglob        # include dotfiles in pathname expansion
shopt -s expand_aliases # expand aliases

# Cargo
[[ -f $HOME/.cargo/env ]] && source "$HOME/.cargo/env"

# zoxide
# https://github.com/ajeetdsouza/zoxide
if test -x /usr/bin/zoxide; then
  eval "$(zoxide init bash)"
  alias cd='z'
fi

# npm
export NPM_PREFIX="$HOME/.npm-global"
export PATH="$NPM_PREFIX/bin:$PATH"

# Golang
GO_PATH="$HOME/go"
export GOPATH="$GO_PATH"
export PATH="$GOPATH/bin:$PATH"

# wayland notifications
# https://github.com/kaar/mako
# $REPOS/kaar/mako/build/mako
# ./.config/systemd/user/mako.service
# notify-send "Title" "Message"
if test -x "$REPOS/kaar/mako/build/mako"; then
  export PATH="$REPOS/kaar/mako/build:$PATH"
fi

# After installing claude globally I ran `claude migrate-installer`
# That moved the binary to ~/.claude/local/claude, which requires this alias.

# TODO: Add completion
# https://platform.claude.com/docs/en/about-claude/models/overview#model-names
export ANTHROPIC_MODEL="claude-opus-4-5-20251101"

# Podman
alias p=podman

# pnpm
export PNPM_HOME="/home/kaar/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
