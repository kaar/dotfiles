#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# https://docs.anthropic.com/en/docs/claude-code/hooks#notification
# - “Claude needs your permission to use Bash”
# - “Claude is waiting for your input”
# Input:
#
# Test: `cat notification.json | ./notification.sh`
#
# {
#   "session_id": "261de10c-990d-4624-a24a-871badbe54ac",
#   "transcript_path": "/home/kaar/.claude/projects/-home-kaar-repos-kaar-dotfiles/261de10c-990d-4624-a24a-871badbe54ac.jsonl",
#   "cwd": "/home/kaar/repos/kaar/dotfiles",
#   "hook_event_name": "Notification",
#   "message": "Claude needs your permission to use Bash"
# }

input=$(cat)
hook_event_name() { echo "$input" | jq -r '.hook_event_name'; }
transcript_path() { echo "$input" | jq -r '.transcript_path'; }
session_id() { echo "$input" | jq -r '.session_id'; }
cwd() { echo "$input" | jq -r '.cwd'; }
message() { echo "$input" | jq -r '.message'; }

APP_NAME=Claude
ICON=$HOME/.claude/claude.png
EXPIRE_TIME=5000
URGENCY=normal

CWD=$(cwd)
PROJECT="${CWD##*/}"
MESSAGE=$(message)


notify-send \
  --app-name="$APP_NAME" \
  --urgency="$URGENCY" \
  --icon="$ICON" \
  --expire-time=$EXPIRE_TIME \
  "$PROJECT" \
  "$MESSAGE"
