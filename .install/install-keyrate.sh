#!/bin/sh
## Keyrate, https://github.com/EricTetz/keyrate
## Increase keyboard repeat above OS limit
## Usage
## keyrate <delay> <repeat>
## keyrate 200 15   - good setting
## keyrate          - reset

BIN=$HOME/.local/bin
mkdir -p $BIN

if [ -z "$(which keyrate)" ]; then
  curl -sfL "https://github.com/EricTetz/keyrate/releases/download/v1.0/keyrate.exe" \
    -o $BIN/keyrate
  chmod +x $BIN/keyrate
else
  echo "keyrate is already installed"
fi
