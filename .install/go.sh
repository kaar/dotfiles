#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset

# Make version into a comparable integer
version() {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }';
}


## Go, https://github.com/golang/go
GOVERSION=1.15.7
INSTALLED_GOVERSION=$(go version | grep -Po "(\d+\.)+\d+")
GO_DOWNLOAD_LINK="https://golang.org/dl/go${GOVERSION}.linux-amd64.tar.gz"
if [ $(version $GOVERSION) -gt $(version $INSTALLED_GOVERSION) ]
then
	echo "Install Golang $GOVERSION"
	curl -fL "${GO_DOWNLOAD_LINK}" | sudo tar -C /usr/local -xzf -
	echo "Create symbolic link /usr/local/go/bin/go -> /usr/bin/go"
	sudo ln -fs /usr/local/go/bin/go /usr/bin/go
else
	echo "Already latest version $GOVERSION"
fi
