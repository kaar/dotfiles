#!/usr/bin/env bash

## Go, https://github.com/golang/go
GOVERSION=1.15.7

# Make version into a comparable integer
version() {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }';
}

if ! type go >/dev/null 2>&1 || go version | grep -Po "(\d+\.)+\d+" -lt $GOVERSION
then
	echo "Install Golang $GOVERSION"
	curl -fL "https://golang.org/dl/go${GOVERSION}.linux-amd64.tar.gz" \
		| sudo tar -C /usr/local -xzf -
	echo "Create symbolic link /usr/local/go/bin/go -> /usr/bin/go"
	sudo ln -fs /usr/local/go/bin/go /usr/bin/go
else
	echo "Already latest version $GOVERSION"
fi
