#! /bin/bash
remote_url=$(git config remote.origin.url)
if [[ $remote_url != *"github"* ]]; then
  echo "Not a github url"
  exit;
fi

github_url=$(sed -e 's/git@github.com:/https:\/\/github.com\//' -e 's/\.git//' <<< $remote_url)
# Open url in chrome
branch=$(git rev-parse --abbrev-ref HEAD)
github_pr_url="$github_url/compare/master...$branch"
echo $github_pr_url
chrome.exe $github_pr_url
