source ~/.config/bash/git-prompt.sh

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

#PS1='${PWD#"${PWD%/*/*}/"} \$ '
PROMPT_COMMAND='__git_ps1 "\[\e[01;34m\]\W\[\e[m\]" "\[\] "'
