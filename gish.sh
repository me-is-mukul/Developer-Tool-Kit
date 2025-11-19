#!/bin/bash
set -euo pipefail

read -rp "Please enter a message for the commit (leave empty for 'Auto commit'): " msg

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "⚠ Not a git repository in $(pwd)."
fi

if [ -z "${msg:-}" ]; then
    $msg="Auto commit"
fi

git add .
if git commit -m "$msg"; then
    echo "echo ✅ Commit successful: \"$msg\""
else
  echo "❌ Commit failed."
  exit 1
fi

if git push; then
    echo "✅ Push successful."
  else
    echo "❌ Push failed. Try: git push --set-upstream origin $current_branch"
    exit 1
fi

