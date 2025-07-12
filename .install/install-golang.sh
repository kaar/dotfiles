#!/usr/bin/env bash

# Go, https://github.com/golang/go
GOVERSION=1.24.4

echo "Install Golang $GOVERSION"
rm -rf /usr/local/go \
  && curl -fL "https://golang.org/dl/go${GOVERSION}.linux-amd64.tar.gz" \
  | sudo tar -C /usr/local -xzf -
echo "Create symbolic link /usr/local/go/bin/go -> /usr/bin/go"
sudo ln -fs /usr/local/go/bin/go /usr/bin/go
