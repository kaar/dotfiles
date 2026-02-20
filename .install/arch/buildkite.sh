#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

REPOS="${REPOS:-$HOME/repos}"
REPO_DIR="$REPOS/buildkite/cli"

if ! [ -d "$REPO_DIR" ]; then
  git clone git@github.com:buildkite/cli.git "$REPO_DIR"
fi

cd "$REPO_DIR"
git fetch origin main > /dev/null 2>&1
OLD_HEAD=$(git rev-parse HEAD)
git merge --ff-only origin/main > /dev/null 2>&1
NEW_HEAD=$(git rev-parse HEAD)
if [ "$OLD_HEAD" == "$NEW_HEAD" ] && [ -f "$REPO_DIR/bk" ]; then
  echo "No changes, running bk version $(./bk version)"
  exit 0
fi

go build -o bk .

mkdir -p "$HOME/.local/bin"
cat >"$HOME/.local/bin/bk" <<EOF
#!/usr/bin/env bash
set -euo pipefail
exec "$REPO_DIR/bk" "\$@"
EOF
chmod +x "$HOME/.local/bin/bk"

mkdir -p "$HOME/.config/bash_completion.d"
"$REPO_DIR/bk" completion bash > "$HOME/.config/bash_completion.d/bk"
