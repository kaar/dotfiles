alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias explorer='explorer.exe'
alias d='docker'
alias tmp='vim $(mktemp)'
alias g='git'

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

# Gists
alias todo='gh gist edit ${GIST_TODO}'
alias tibber-todo='gh gist edit ${GIST_TODO_TIBBER}'
alias ideas='gh gist edit ${GIST_IDEAS}'

# GitHub
alias github-pr='github_create_pull_request'
alias github='github-open'

# Browser
alias browse='firefox -new-tab'

# Generic
alias guid='uuid'

# AWS
alias aws-session='source ${SCRIPTS}/aws/get-session-token.sh $(${SCRIPTS}/op/get-totp "Amazon")'

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
