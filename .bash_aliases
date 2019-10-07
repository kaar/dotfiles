# Add directory colors when running bash outside of gitbash
export LS_OPTIONS='--color=auto'
eval "$(dircolors -b)"
alias ls='ls $LS_OPTIONS'

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
alias git=hub
