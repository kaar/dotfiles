## Ticker (terminal stock watcher), https://github.com/achannarasappa/ticker
header "Ticker"
curl -Ls https://api.github.com/repos/achannarasappa/ticker/releases/latest \
       | grep -wo "https.*linux-amd64*.tar.gz" \
       | xargs curl -sfL \
       | tar -C ~/.bin/ -xzf -
