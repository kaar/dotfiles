alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias explorer='explorer.exe'
alias docker='docker.exe'
alias choco='/c/ProgramData/chocolatey/bin/choco'
alias github='~/.scripts/open_github.sh'
alias github-new='~/.scripts/github_new.sh'
alias pipeline='~/.scripts/open_azure_pipelines.sh'
alias pl='~/.scripts/open_azure_pipelines.sh'
alias main='cd ~/Dev/main'
alias chrome='/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe'
alias tc='open_chrome http://teamcity.stockholm.cint.com:8080/ &'
alias vs="open_visual_studio"
alias cs='code_search'
alias tip="echo 'If applied, this commit will'"
alias todo='vim ~/notes/todo.md'
alias title='set_windows_terminal_title'
alias github-pr='github_create_pull_request'
alias reload='source ~/.bashrc'


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
    # Open url in chrome
    branch=$(git rev-parse --abbrev-ref HEAD)
    github_pr_url="$github_url/compare/master...$branch"
    echo $github_pr_url
    chrome.exe $github_pr_url
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