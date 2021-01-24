
header() {
	echo -e "\033[0;33m$1\033[0m"
}
# Make version into a comparable integer
version() {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }';
}
packages="
# Usage
# sudo apt-get install $(awk -f ~/.awk/skip_hash.awk ~/.packages)
# ./.scripts/install-packages.sh

# General
tig

# Tools
neovim
ripgrep
universal-ctags
silversearcher-ag

# https://github.com/sharkdp/fd
fd-find

# https://github.com/stedolan/jq
jq

# GitHub CLI, https://github.com/cli/cli
gh
"

# Install all packages
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository https://cli.github.com/packages
#sudo apt update
sudo apt upgrade
sudo apt install $(echo "${packages}" | awk -f ~/.awk/skip_hash.awk)

# Manual install
BIN=~/.bin
mkdir -p $BIN

## cheat.sh, https://github.com/chubin/cheat.sh
header "Cheat.sh"
curl --silent https://cht.sh/:cht.sh > $BIN/cht.sh
chmod +x $BIN/cht.sh
curl --silent https://cheat.sh/:bash_completion > ~/.config/cht.sh/completion.bash

## Tmux Plugin Manager, https://github.com/tmux-plugins/tpm
header "Tmux Plugin Manager"
TMUX_PLUGINS=~/.tmux/plugins/tpm
mkdir -p $TMUX_PLUGINS
if [[ -d "$TMUX_PLUGINS/.git" ]]
then
	git -C $TMUX_PLUGINS pull
else
	git clone https://github.com/tmux-plugins/tpm "$TMUX_PLUGINS" --depth=1
fi

## FZF, https://github.com/junegunn/fzf
header "FZF"
FZF_PATH=${BIN}/fzf
REPO="https://github.com/junegunn/fzf.git"
if [[ ! -d $FZF_PATH ]]
then
	echo "Clone ${REPO}"
	git clone --depth 1 $REPO $FZF_PATH
fi
# Only downloads the latest binary from GitHub
# ~/.bin/fzf is needed for loading into vim
~/.bin/fzf/install --bin
echo "Create symbolic link ${FZF_PATH}/fzf -> /usr/bin/fzf"
sudo ln -sf ~/.bin/fzf/bin/fzf /usr/bin/fzf

## bat, https://github.com/sharkdp/bat
# Download *.deb file from github releases. apt source version was broken
header "Bat"
curl -s https://api.github.com/repos/sharkdp/bat/releases/latest \
	| grep "browser_download_url.*bat_.*_amd64.deb" \
	| cut -d '"' -f 4 \
	| wget -O "bat.deb" -qi - \
	&& sudo dpkg -i "bat.deb" \
	&& rm "bat.deb"

## Download git-prompt.sh
header "git-prompt.sh"
curl --silent https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > ~/.config/bash/git-prompt.sh

## Go, https://github.com/golang/go
header "Go"
GOVERSION=1.15.7
INSTALLED_GOVERSION=$(go version | grep -Po "(\d+\.)+\d+")
GO_DOWNLOAD_LINK="https://golang.org/dl/go${GOVERSION}.linux-amd64.tar.gz"
if [ $(version $GOVERSION) -gt $(version $INSTALLED_GOVERSION) ]
then
	echo "Install Golang $GOVERSION"
	curl -fL "${GO_DOWNLOAD_LINK}" | sudo tar -C /usr/local -xzf -
	echo "Create symbolic link /usr/local/go/bin/go -> /usr/bin/go"
	sudo ln -fs /usr/local/go/bin/go /usr/bin/go
else
	echo "Already latest version $GOVERSION"
fi
