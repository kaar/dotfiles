# Load colors
function header() {
	echo -e "\033[0;33m$1\033[0m"
}

# Install all packates in ~/.packages
sudo apt update
sudo apt upgrade
sudo apt install $(awk -f ~/.awk/skip_hash.awk ~/.packages)

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
	git clone https://github.com/tmux-plugins/tpm "$TMUX_PLUGINS"
fi
