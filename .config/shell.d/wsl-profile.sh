#!/bin/sh

if [ -z "$(which keyrate)" ]; then
  keyrate 250 15
else
  echo "Could not find keyrate"
fi

