#!/bin/bash

header() {
	echo -e "\033[0;33m$1\033[0m"
}
# Make version into a comparable integer
version() {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }';
}

install() {
	header "Installing $1"
	~/.install/"install-${1}.sh"
}

mkdir -p $HOME/.local/bin

sudo apt update

packages="
dnsutils
wget
curl
jq
man
tig
ripgrep
universal-ctags
silversearcher-ag
fd-find
bash-completion
"

# Install all packages
#sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
#sudo apt-add-repository https://cli.github.com/packages
#sudo apt update
#sudo apt upgrade
#sudo apt install ${packages}
sudo apt install ${packages}

install gh
install ripgrep
#install bat
install tmux
install cheat
install fzf
#install git-prompt
#install golang
#install kubectl

