#!/usr/bin/env bash
# sync-upstream.sh — bring main up to date with upstream, then rebase nim on top.
#
# Usage: devbox run sync-upstream
#
# What it does:
#   1. Fetch latest commits from upstream (robocode-dev/tank-royale)
#   2. Merge them into local main and push to origin
#   3. Rebase the nim branch on top of the updated main
#   4. Push nim to origin (force-with-lease, safe rebase push)
#
# After running this, you are back on the nim branch, ready to develop.

set -euo pipefail

UPSTREAM_REMOTE="upstream"
ORIGIN_REMOTE="origin"
MAIN_BRANCH="main"
NIM_BRANCH="nim"

current_branch=$(git symbolic-ref --short HEAD)

echo "==> Fetching $UPSTREAM_REMOTE..."
git fetch "$UPSTREAM_REMOTE"

new_commits=$(git rev-list --count "$MAIN_BRANCH".."$UPSTREAM_REMOTE/$MAIN_BRANCH")

if [[ "$new_commits" -eq 0 ]]; then
  echo "    Nothing new from upstream — $MAIN_BRANCH is already up to date."
else
  echo "    $new_commits new commit(s) from upstream. Merging into $MAIN_BRANCH..."
  git checkout "$MAIN_BRANCH"
  git merge --ff-only "$UPSTREAM_REMOTE/$MAIN_BRANCH"
  git push "$ORIGIN_REMOTE" "$MAIN_BRANCH"
  echo "    $MAIN_BRANCH pushed to $ORIGIN_REMOTE."
fi

echo "==> Rebasing $NIM_BRANCH onto $MAIN_BRANCH..."
git checkout "$NIM_BRANCH"
git rebase "$MAIN_BRANCH"
git push "$ORIGIN_REMOTE" "$NIM_BRANCH" --force-with-lease
echo "    $NIM_BRANCH pushed to $ORIGIN_REMOTE."

echo ""
echo "Done. You are on branch: $(git symbolic-ref --short HEAD)"
echo "Upstream commits absorbed: $new_commits"
