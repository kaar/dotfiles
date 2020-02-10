#! /bin/bash
remote_url=$(git config remote.origin.url)
if [[ $remote_url != *"github"* ]]; then
  echo "Not a github url"
  exit;
fi

azure_pipelines_url=$(sed -e 's/git@github.com:/https:\/\/dev.azure.com\//' -e 's/\.git//' <<< $remote_url)

# Open url in chrome
chrome.exe "${azure_pipelines_url}/_build"
