#!/usr/bin/env bash

# Go, https://github.com/golang/go
GOVERSION=1.24.5

echo "Install Golang $GOVERSION"
GOPATH=${HOME}/go
rm -rf "$GOPATH" && mkdir -p "$GOPATH" \
  && curl -fL "https://golang.org/dl/go${GOVERSION}.linux-amd64.tar.gz" \
  | tar -C "$GOPATH" -xzf -

ln -sf "$GOPATH/go/bin/go" "$HOME/.local/bin/go"
