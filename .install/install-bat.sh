#!/bin/bash

version() {
	echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }';
}

## bat, https://github.com/sharkdp/bat
# Download *.deb file from github releases. apt source version was broken
download_link=$(curl -s https://api.github.com/repos/sharkdp/bat/releases/latest | grep -oP "https://.*bat_.*_amd64.deb")
current_version=$(bat --version | grep -Po "(\d+\.)+\d+")
latest_version=$(echo "$download_link" | grep -Po "(\d+\.)+\d+" | head -1)
#echo "Download link:" $download_link
#echo "Current Version:" $current_version
#echo "Latest Version:" $latest_version

if [ $(version $latest_version) -gt $(version $current_version) ]
then
wget -O "bat.deb" -q $download_link \
	&& sudo dpkg -i "bat.deb" \
	&& rm "bat.deb"
else
	echo "Already latest version $current_version"
fi

