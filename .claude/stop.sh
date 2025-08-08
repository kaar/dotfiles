#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# Example:
# {
#   "session_id": "061e6421-dccd-4ebb-97fa-1daa947288c3",
#   "transcript_path": "/home/kaar/.claude/projects/-home-kaar--claude/061e6421-dccd-4ebb-97fa-1daa947288c3.jsonl",
#   "cwd": "/home/kaar/.claude",
#   "hook_event_name": "Stop",
#   "stop_hook_active": false
# }

input=$(cat)
hook_event_name() { echo "$input" | jq -r '.hook_event_name'; }
transcript_path() { echo "$input" | jq -r '.transcript_path'; }
session_id() { echo "$input" | jq -r '.session_id'; }
cwd() { echo "$input" | jq -r '.cwd'; }

APP_NAME=Claude
ICON=$HOME/.claude/claude.png
EXPIRE_TIME=2000
URGENCY=normal

CWD=$(cwd)
PROJECT="${CWD##*/}"
MESSAGE="Completed"

notify-send \
  --app-name="$APP_NAME" \
  --urgency="$URGENCY" \
  --icon="$ICON" \
  --expire-time=$EXPIRE_TIME \
  "$PROJECT" \
  "$MESSAGE"
