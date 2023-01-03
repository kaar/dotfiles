#!/bin/bash
if [ -f ~/.bashrc ]; then
  source $HOME/.bashrc
fi

[[ -f $HOME/.cargo/env ]] && . "$HOME/.cargo/env"
