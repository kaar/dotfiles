export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
Blue="\[\033[0;34m\]"
Reset="\[\033[0m\]"
PROMPT_COMMAND='__git_ps1 "${Blue}\w${Reset}" "\n\$ "'
