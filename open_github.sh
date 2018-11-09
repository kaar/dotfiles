#! /bin/bash
remote_url=$(git config remote.origin.url)
if [[ $remote_url != *"github"* ]]; then
  echo "Not a github url"
  exit;
fi

github_url=$(sed -e 's/git@github.com:/https:\/\/github.com\//' -e 's/\.git//' <<< $remote_url)
# Open url in chrome
/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe $github_url
