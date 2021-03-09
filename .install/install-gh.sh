#!/bin/sh
## gh, https://github.com/cli/cli

# Get latest release
latest_release=$(curl -sL https://api.github.com/repos/cli/cli/releases/latest \
  | jq -r .tag_name \
  | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/')

# Download latest
curl -LOs https://github.com/cli/cli/releases/download/v${latest_release}/gh_${latest_release}_linux_amd64.deb

# Install downloaded latest
sudo dpkg -i gh_${latest_release}_linux_amd64.deb 



