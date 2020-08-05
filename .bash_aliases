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
alias github-pr='~/.scripts/github_pr.sh'
alias github-new='~/.scripts/github_new.sh'
alias pipeline='~/.scripts/open_azure_pipelines.sh'
alias pl='~/.scripts/open_azure_pipelines.sh'
alias main='cd ~/Dev/main'
alias chrome='/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe'
alias tc='open_chrome http://teamcity.stockholm.cint.com:8080/ &'
alias vs="open_visual_studio"
alias cs='~/.scripts/code_search.sh'
alias tip="echo 'If applied, this commit will'"
alias todo='vim ~/notes/todo.md'

# Set windows title in windows terminal
function title()
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

