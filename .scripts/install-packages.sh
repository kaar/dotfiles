# Install all packates in ~/.packages
sudo apt update
sudo apt upgrade
sudo apt install $(awk -f ~/.awk/skip_hash.awk ~/.packages)

# Manual install
BIN=~/.bin
mkdir -p $BIN

## cheat.sh, https://github.com/chubin/cheat.sh
curl --silent https://cht.sh/:cht.sh > $BIN/cht.sh
chmod +x $BIN/cht.sh
curl --silent https://cheat.sh/:bash_completion > ~/.config/cht.sh/completion.bash
