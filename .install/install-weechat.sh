#!/bin/bash
## WeeChat (irc client), https://weechat.org/download


## Download and build from source
#gpg --keyserver hkps://keys.openpgp.org --recv-keys A9AB5AB778FA5C3522FD0378F82F4B16DEC408F8
#gpg --fingerprint A9AB5AB778FA5C3522FD0378F82F4B16DEC408F8
#gpg --edit-key A9AB5AB778FA5C3522FD0378F82F4B16DEC408F8
## 
#
#curl -sfL https://weechat.org/files/src/weechat-3.0.1.tar.xz https://weechat.org/files/src/weechat-3.0.1.tar.xz.asc
#
#gpg --verify weechat-3.0.1.tar.xz.asc weechat-3.0.1.tar.xz

echo "deb https://weechat.org/ubuntu groovy main" | sudo tee /etc/apt/sources.list.d/weechat.list
echo "deb-src https://weechat.org/ubuntu groovy main" | sudo tee -a /etc/apt/sources.list.d/weechat.list

sudo apt-get update
sudo apt-get install weechat-curses weechat-plugins weechat-python weechat-perl

