#!/bin/sh
## gh, https://github.com/cli/cli

# Get latest release
latest_release=$(curl -sL https://api.github.com/repos/cli/cli/releases/latest \
  | jq -r .tag_name \
  | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/')

# Download latest
package_name="gh_${latest_release}_linux_amd64.deb"
curl -Ls --output /tmp/${package_name} https://github.com/cli/cli/releases/download/v${latest_release}/${package_name}

# Install downloaded latest
sudo dpkg -i /tmp/${package_name}

# Remove downloaded package
rm -rf /tmp/${package_name}



