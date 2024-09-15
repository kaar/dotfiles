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
# Replacd with script ~/.scripts/config

# ----------------------- environment variables ----------------------
export EDITOR=nvim
export VISUAL=nvim
export EDITOR_PREFIX=nvim

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
# /home/tibber/repos/kaar/gpt-cli
# export PYTHONPATH="$HOME/repos/kaar/gpt-cli"

# poetry
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring
export POETRY_VIRTUALENVS_IN_PROJECT=true

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


# Use $EDITOR (nvim/lvim) as manpager
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
alias l='lvim'

# Gists
alias ideas='gh gist edit ${GIST_IDEAS}'

# Browser
alias browse='firefox -new-tab'

# tailscale
alias ts='tailscale'

# other
alias aws-cloudwatch='open ${AWS_URL_CLOUDWATCH}'
alias aws-console='open ${AWS_URL_CONSOLE}'
alias aws-iam='open ${AWS_URL_IAM}'

# python
alias set-python-path='export PYTHONPATH="$PYTHONPATH:$PWD/src:$PWD/test"'

# secrets
alias source-secrets='. ~/.config/secrets.env'

# gpt
alias chat='gpt-chat'

# Load all scripts in shell.d
for file in ~/.config/shell.d/*.sh ; do
  [ -f "$file" ] && source $file
done

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
# Disable the "XON/XOFF" flow control to free up Ctrl-S and Ctrl-Q
stty -ixon

# This binding does not work unless the .bashrc is re-sources
# Not sure why that is so I'm disabling it for now.
# bind '"\C-f":"file-search-preview\n"'

# ------------------------------ prompt -------------------------------

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
# https://github.com/git/git/raw/master/contrib/completion/git-prompt.sh
source "$HOME/.config/git/git-prompt.sh"

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

# HISTORY
# Save .bash_history in $HIST_REPO under a path that mirrors the current
# directory structure, excluding the home directory
# https://datawookie.dev/blog/2023/04/configuring-bash-history/
# https://github.com/kaar/bash-backup
export HIST_REPO="$HOME/repos/kaar/bash-backup/bash_history"
export HISTFILE="$HIST_REPO/${PWD/$HOME/}/.bash_history"
mkdir -p "$(dirname "$HISTFILE")"
# Append commands to history file immediately
# Enables access to history in new terminal from active session
export PROMPT_COMMAND="$PROMPT_COMMAND; history -a"
clean_history() {
  # Clean up $HISTFILE
  echo "TODO: backup and maybe clean up history"
  # sort -u -o "$HISTFILE" "$HISTFILE"
  # Remove empty ls commands like `ls -l` and `ls -al`
  sed -i '/^ls\s*$/d' "$HISTFILE"
  # Remove empty cd commands like `cd` and `cd ~`
  sed -i '/^cd\s*$/d' "$HISTFILE"
}
# Clean up history when exiting shell
trap clean_history EXIT

HISTCONTROL=ignoreboth  # No duplicated lines and lines starting with space
HISTSIZE=10000
HISTFILESIZE=20000

shopt -s checkwinsize   # check the window size and update LINES,COLUMNS
shopt -s histappend     # don't override history
shopt -s autocd         # change to named directory
shopt -s cdspell        # autocorrects cd misspellings
shopt -s autocd         # change to named directory
shopt -s cmdhist        # save multi-line commands in history as single line
shopt -s dotglob
shopt -s expand_aliases # expand aliases


# direnv
# eval "$(direnv hook bash)"
if [ -f /.cargo/env ]; then
   source "$HOME/.cargo/env"
fi
