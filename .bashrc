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

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# git promot
source ~/.scripts/git-prompt.sh

# Load bash completion PC. 
source ~/.scripts/.git-completion.bash
source ~/.scripts/tmux.completion.bash


# Load bash completion Mac
#if [ -f $(brew --prefix)/etc/bash_completion ]; then
#  . $(brew --prefix)/etc/bash_completion
#fi

# Workaround for Docker for Windows in Git Bash.
docker()
{
    (export MSYS_NO_PATHCONV=1; "docker.exe" "$@")
}

open_chrome()
{
    /c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe $* & > /dev/null
}

open_visual_studio()
{
    /c/Program\ Files\ \(x86\)/Microsoft\ Visual\ Studio/2017/Professional/Common7/IDE/devenv.exe $* & > /dev/null
}

# https://www.atlassian.com/git/tutorials/dotfiles 
# Create an alias config which will be used instead of the regular git to interact with configuration repository.
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias explorer='~/.scripts/open_explorer.sh'
#alias code='/c/Program\ Files/Microsoft\ VS\ Code/Code.exe'
alias code='code.cmd'
alias solve='git diff --name-only --diff-filter=U | xargs code -n'
alias choco='/c/ProgramData/chocolatey/bin/choco'
alias github='~/.scripts/open_github.sh'
alias github-pr='~/.scripts/github_pr.sh'
alias github-new='~/.scripts/github_new.sh'
alias main='cd ~/Dev/main'
alias chrome='open_chrome'
alias tc='open_chrome http://teamcity.stockholm.cint.com:8080/ &'
alias vs="open_visual_studio"
alias cs='~/.scripts/code_search.sh'
alias tip="echo 'If applied, this commit will'"