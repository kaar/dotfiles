alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias explorer='explorer.exe'
alias choco='/c/ProgramData/chocolatey/bin/choco'

# safety features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias pipeline='~/.scripts/open_azure_pipelines.sh'
alias pl='~/.scripts/open_azure_pipelines.sh'
alias main='cd ~/Dev/main'

alias vs="open_visual_studio"
alias cs='code_search'
alias tip="echo 'If applied, this commit will'"
alias title='set_windows_terminal_title'

alias v='vim_edit_output'
alias reload='source ~/.bashrc ;'
alias ts='tmux-split-cmd'
alias install-packages='~/.install/default.sh'

alias '?'=google

# Kubectl
alias k=kubectl
complete -F __start_kubectl k

# Notes
alias sync-notes='git --git-dir="${HOME}/notes/.git" --work-tree=${HOME}/notes sync'

# Vim

alias fd='fdfind'

# TODO
alias todo='gh gist edit c85070135d504c644d6c60ac025c4bcd'
alias cint-todo='gh gist edit ef259eead3d865e32c659d4c40ba3789'

# GitHub
alias github-pr='github_create_pull_request'
alias github='github-open'

# Browser
alias chrome='/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe'
alias firefox='/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe'
alias browse='firefox -new-tab'

# Generic
alias guid='uuid'

# https://github.com/chubin/cheat.sh#programming-languages-cheat-sheets
# mkdir -p ~/bin/
# curl https://cht.sh/:cht.sh > ~/bin/cht.sh
# chmod +x ~/bin/cht.sh
alias cheat='~/bin/cht.sh'

# Github CLI
# https://github.com/cli/cli
# https://cli.github.com/manual
# Set editor to VSCode
# gh config set editor code --wait
alias gist='gh gist'
alias gl='gh gist list'
alias gc='gh gist create'
alias ge='gist_edit'
alias gv='gist_view'

# Opens interactive list of gists for edit
# Requires iselect (apt install iselect) and github cli
function gist_edit()
{
    selected_gist="$(gh gist list | iselect -a)"
    gist_hash="$(echo $selected_gist | cut -d' ' -f1)"
    gh gist edit $gist_hash
}

# Opens interactive list of gists to view
function gist_view()
{
    selected_gist="$(gh gist list | iselect -a)"
    gist_hash="$(echo $selected_gist | cut -d' ' -f1)"
    gh gist view $gist_hash
}


# Splits command into a new pane that closes
function tmux-split-cmd() { tmux split-window -h -t $TMUX_PANE "$*" ; }

# Pipes output into vim
function vim_edit_output() { "$@" | vim - ; }

# Set windows title in windows terminal
function set_windows_terminal_title()
{
    # If no arguments provided
    if [ $# -eq 0 ]; then
        # use current dir as title
        echo -ne "\033]0;${PWD##*/}\a" ;
    else
        # Set Title by parameter
        echo -ne "\033]0;$@\a" ;
    fi
}

function github_create_pull_request()
{
    remote_url=$(git config remote.origin.url)
    if [[ $remote_url != *"github"* ]]; then
        echo "Not a github url"
        exit;
    fi

    github_url=$(sed -e 's/git@github.com:/https:\/\/github.com\//' -e 's/\.git//' <<< $remote_url)
    # Open url in browser
    branch=$(git rev-parse --abbrev-ref HEAD)
    github_pr_url="$github_url/compare/master...$branch"
    echo $github_pr_url
    browse $github_pr_url
}

function open_visual_studio()
{
    if has_arguments $@ ; then
        devenv.exe $@ &
    else
        devenv.exe $(find . -name '*.sln') &
    fi
    # devenv.exe $@ &
}

function code_search()
{
    grep $1 $(find ${2:-src/} -iname "*.cs")
}

function has_arguments()
{
    if [ $# -eq 0 ]; then
        return 1
    else
        return 0
    fi
}
