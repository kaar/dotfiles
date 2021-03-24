#!/usr/bin/env bash
## IX, http://ix.io/

if [ -z "$(which ix)" ]; then
  curl ix.io/client > ~/.local/bin/ix
  chmod +x ~/.local/bin/ix
  echo "IX installed."
else
  echo "IX already installed."
fi
