#!/bin/bash

# https://docs.anthropic.com/en/docs/claude-code/statusline
# Json input structure:
#
# {
#   "hook_event_name": "Status",
#   "session_id": "abc123...",
#   "transcript_path": "/path/to/transcript.json",
#   "cwd": "/current/working/directory",
#   "model": {
#     "id": "claude-opus-4-1",
#     "display_name": "Opus"
#   },
#   "workspace": {
#     "current_dir": "/current/working/directory",
#     "project_dir": "/original/project/directory"
#   }
# }

input=$(cat)

get_model_name() { echo "$input" | jq -r '.model.display_name'; }
get_current_dir() { echo "$input" | jq -r '.workspace.current_dir'; }
get_project_dir() { echo "$input" | jq -r '.workspace.project_dir'; }
get_version() { echo "$input" | jq -r '.version'; }
git_branch() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        git branch --show-current 2>/dev/null
    else
        echo ""
    fi
}

DIR=$(get_current_dir)
GIT_BRANCH=$(git_branch)

if [ -n "$GIT_BRANCH" ]; then
    GIT_BRANCH=" |  $GIT_BRANCH"
else
    GIT_BRANCH=""
fi

echo " ${DIR##*/}$GIT_BRANCH"
