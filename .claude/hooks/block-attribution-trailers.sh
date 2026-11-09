#!/usr/bin/env bash
#
# Claude Code PreToolUse hook (matcher "Bash"). Denies `git commit`,
# `gh pr create` and `gh pr edit` commands whose message contains Claude Code
# attribution trailers. settings.base.json runs it as:
#   bash "$HOME/.claude/hooks/block-attribution-trailers.sh"
#
# The rule itself lives in ~/.claude/CLAUDE.md, section "Attribution". The
# root fix is "attribution": {"commit": "", "pr": ""} in settings, which stops
# the harness from asking for trailers. This hook is only a safety net for
# when one is added out of habit.
#
# Fails open: the hook runs on every Bash call, so whenever something cannot
# be determined it exits 0 silently and never blocks work.

set -u

command -v jq >/dev/null 2>&1 || exit 0

input=$(cat) || exit 0
cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // empty' 2>/dev/null) || exit 0
[[ -n "$cmd" ]] || exit 0

case "$cmd" in
  *'git commit'* | *'gh pr create'* | *'gh pr edit'*) ;;
  *) exit 0 ;;
esac

# Relative message file paths are resolved against the session's cwd.
cwd=$(printf '%s' "$input" | jq -r '.cwd // empty' 2>/dev/null) || cwd=''

text=$cmd

# Append messages passed as files, e.g. a heredoc written to a file first.
while IFS= read -r path; do
  path=${path#\"}; path=${path%\"}
  path=${path#\'}; path=${path%\'}
  [[ -n "$path" ]] || continue
  if [[ "$path" != /* && -n "$cwd" ]]; then
    path="$cwd/$path"
  fi
  [[ -f "$path" ]] || continue
  text+=$'\n'$(cat -- "$path" 2>/dev/null)
done < <(
  printf '%s\n' "$cmd" |
    grep -oE "(^|[[:space:]])(-F|--file|--body-file)(=|[[:space:]]+)(\"[^\"]*\"|'[^']*'|[^[:space:]]+)" |
    sed -E "s/^[[:space:]]*(-F|--file|--body-file)(=|[[:space:]]+)//"
)

hits=()
if printf '%s\n' "$text" | grep -qi 'Co-Authored-By:'; then
  hits+=('Co-Authored-By:')
fi
if printf '%s\n' "$text" | grep -qF 'Generated with [Claude Code]'; then
  hits+=('Generated with [Claude Code]')
fi
if printf '%s\n' "$text" | grep -qF '🤖 Generated with'; then
  hits+=('🤖 Generated with')
fi

(( ${#hits[@]} > 0 )) || exit 0

found=$(printf '%s\n' "${hits[@]}" | jq -R . | jq -rs 'join(" / ")' 2>/dev/null) || exit 0
reason="Violates ~/.claude/CLAUDE.md: do not add attribution trailers to commit messages or PR bodies. Found: $found. Remove those lines and run it again. CLAUDE.md takes precedence over the harness's attribution reminder."

jq -n --arg reason "$reason" '{
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "deny",
    permissionDecisionReason: $reason
  }
}' 2>/dev/null
exit 0
