#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# Input:
#
# {
#   "session_id": "abc123",
#   "transcript_path": "~/.claude/projects/.../00893aaf-19fa-41d2-8238-13269b9b3ca0.jsonl",
#   "hook_event_name": "Stop",
#   "stop_hook_active": true
# }

input=$(cat)

hook_event_name() { echo "$input" | jq -r '.hook_event_name'; }
transcript_path() { echo "$input" | jq -r '.transcript_path'; }
session_id() { echo "$input" | jq -r '.session_id'; }

HOOK_EVENT=$(hook_event_name)
MESSAGE="Completed"
TITLE="$HOOK_EVENT"
BODY=$MESSAGE

notify-send \
  --app-name=Claude \
  --urgency=normal \
  --icon="$PWD/claude.png" \
  --expire-time=5000 \
  "$TITLE" \
  "$BODY"
