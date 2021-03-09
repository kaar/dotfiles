#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

BIN=~/.bin
mkdir -p $BIN

## cheat.sh, https://github.com/chubin/cheat.sh
curl --silent https://cht.sh/:cht.sh > $BIN/cht.sh
chmod +x $BIN/cht.sh
curl --silent https://cheat.sh/:bash_completion > ~/.config/cht.sh/completion.bash
