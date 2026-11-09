#!/usr/bin/env bash
#
# Restore untracked links and local config in a new git worktree.
#
# A worktree created by EnterWorktree is a fresh checkout, so untracked links
# and local config that live in the main checkout (e.g. a symlinked CLAUDE.md
# or files under .claude/) are missing. This script recreates them in the
# worktree as symlinks with absolute targets:
#
#   Step 1: every entry directly under the main checkout (dotfiles included)
#           that is a symlink and is not tracked by git is linked to the same
#           name in the worktree.
#   Step 2: if <main>/.claude is a real directory, every entry directly under
#           it (dotfiles included, "worktrees" excluded) that is not tracked
#           by git is linked to <worktree>/.claude/<name>.
#
# Existing destinations are never overwritten.
#
# Input: stdin JSON with "cwd" set to the new worktree root. It runs as a
# PostToolUse hook (matcher "EnterWorktree") from settings.base.json, and can
# also be called directly with {"cwd": "<worktree path>"}. The main checkout
# is $CLAUDE_PROJECT_DIR if set, otherwise derived from
# `git rev-parse --git-common-dir`.
#
# Output: if anything was created, one line of JSON:
#   {"systemMessage": "Restored links in worktree: <list> (<cwd>)"}
# Otherwise nothing.
#
# It never fails EnterWorktree: it always exits 0 and does not use set -e.
# It avoids arrays so that it runs on macOS bash 3.2.

command -v jq >/dev/null 2>&1 || exit 0

input=$(cat)
cwd=$(printf '%s' "$input" | jq -r '.cwd // empty' 2>/dev/null)
[ -n "$cwd" ] && [ -d "$cwd" ] || exit 0

# Only act in a linked worktree, where .git is a file, not a directory.
[ -f "$cwd/.git" ] || exit 0

if [ -n "${CLAUDE_PROJECT_DIR:-}" ] && [ -d "$CLAUDE_PROJECT_DIR" ]; then
  main=$CLAUDE_PROJECT_DIR
else
  common=$(git -C "$cwd" rev-parse --git-common-dir 2>/dev/null) || exit 0
  [ -n "$common" ] || exit 0
  case "$common" in
    /*) ;;
    *) common="$cwd/$common" ;;
  esac
  main=$(dirname "$common")
fi

cwd=$(cd "$cwd" 2>/dev/null && pwd -P) || exit 0
main=$(cd "$main" 2>/dev/null && pwd -P) || exit 0
[ "$cwd" != "$main" ] || exit 0

created=''

is_tracked() {
  git -C "$main" ls-files --error-unmatch -- "$1" >/dev/null 2>&1
}

# link <source entry> <destination path> <display name>
link() {
  if [ -e "$2" ] || [ -L "$2" ]; then
    return 0
  fi
  target=$(readlink -f "$1" 2>/dev/null) || return 0
  [ -n "$target" ] && [ -e "$target" ] || return 0
  if ln -s "$target" "$2" 2>/dev/null; then
    if [ -n "$created" ]; then
      created="$created, $3"
    else
      created=$3
    fi
  fi
}

# Step 1: untracked symlinks directly under the main checkout.
for src in "$main"/* "$main"/.[!.]* "$main"/..?*; do
  [ -L "$src" ] || continue
  name=$(basename "$src")
  is_tracked "$name" && continue
  link "$src" "$cwd/$name" "$name"
done

# Step 2: untracked entries directly under <main>/.claude.
if [ -d "$main/.claude" ] && [ ! -L "$main/.claude" ]; then
  if [ ! -e "$cwd/.claude" ] && [ ! -L "$cwd/.claude" ]; then
    mkdir "$cwd/.claude" 2>/dev/null
  fi
  if [ -d "$cwd/.claude" ] && [ ! -L "$cwd/.claude" ]; then
    for src in "$main/.claude"/* "$main/.claude"/.[!.]* "$main/.claude"/..?*; do
      [ -e "$src" ] || [ -L "$src" ] || continue
      name=$(basename "$src")
      [ "$name" = worktrees ] && continue
      is_tracked ".claude/$name" && continue
      link "$src" "$cwd/.claude/$name" ".claude/$name"
    done
  fi
fi

if [ -n "$created" ]; then
  jq -cn --arg msg "Restored links in worktree: $created ($cwd)" \
    '{systemMessage: $msg}' 2>/dev/null
fi

exit 0
