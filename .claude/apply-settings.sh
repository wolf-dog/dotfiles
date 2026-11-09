#!/usr/bin/env bash
#
# Deep-merge settings.base.json (machine-independent, next to this script)
# into ~/.claude/settings.json (machine-local). Keys that are not in the base
# (hooks added by other tools, theme, etc.) are never touched.
#
# Usage:
#   apply-settings.sh          merge the base into the target, backing up the
#                              original to <target>.bak when it changes
#   apply-settings.sh --check  do not write; exit 0 if the base is already
#                              applied, otherwise print a diff and exit 1
#
# Target: $CLAUDE_SETTINGS if set, otherwise $HOME/.claude/settings.json.
#
# Merge rules:
#   - Both objects: merge recursively key by key, in the base's key order.
#   - Scalars or mismatched types: the base value wins.
#   - Both arrays at hooks.<EventName>: merge hook groups. A base group whose
#     matcher matches an existing group has its hooks appended to that group,
#     deduplicated by command (the existing hook is kept). A base group with
#     no matching matcher is appended as a whole.
#   - Any other arrays: union. Keep the current order and append only the
#     missing elements.

set -euo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)
base="$script_dir/settings.base.json"
target="${CLAUDE_SETTINGS:-$HOME/.claude/settings.json}"

check=false
case "${1:-}" in
  '') ;;
  --check) check=true ;;
  *)
    echo "Usage: $(basename "$0") [--check]" >&2
    exit 2
    ;;
esac

if [[ ! -f "$base" ]]; then
  echo "Error: base settings not found: $base" >&2
  exit 1
fi

if [[ ! -e "$target" ]]; then
  mkdir -p "$(dirname "$target")"
  echo '{}' > "$target"
fi

# shellcheck disable=SC2016
merge_program='
  def dedupe_by_command:
    reduce .[] as $h ([];
      if any(.[]; .command == $h.command) then . else . + [$h] end);

  def merge_hook_groups($cur; $base):
    reduce $base[] as $g ($cur;
      (first(range(length) as $i | select(.[$i].matcher == $g.matcher) | $i)
        // null) as $i
      | if $i == null then . + [$g]
        else .[$i].hooks = (((.[$i].hooks // []) + ($g.hooks // []))
                            | dedupe_by_command)
        end);

  def union($cur; $base):
    reduce $base[] as $e ($cur;
      if any(.[]; . == $e) then . else . + [$e] end);

  def merge($path; $cur; $base):
    if ($cur | type) == "object" and ($base | type) == "object" then
      reduce ($base | keys_unsorted[]) as $k ($cur;
        .[$k] = merge($path + [$k]; $cur[$k]; $base[$k]))
    elif ($cur | type) == "array" and ($base | type) == "array" then
      if ($path | length) == 2 and $path[0] == "hooks" then
        merge_hook_groups($cur; $base)
      else
        union($cur; $base)
      end
    else
      $base
    end;

  merge([]; .[0]; .[1])
'

merged=$(jq -s "$merge_program" "$target" "$base")

current_sorted=$(jq -S . "$target")
merged_sorted=$(jq -S . <<<"$merged")

if [[ "$current_sorted" == "$merged_sorted" ]]; then
  if $check; then
    echo "OK: base is already applied to $target"
  else
    echo "No change: $target"
  fi
  exit 0
fi

if $check; then
  diff -u --label "$target (current)" --label "$target (merged)" \
    <(printf '%s\n' "$current_sorted") <(printf '%s\n' "$merged_sorted") || true
  exit 1
fi

cp -p "$target" "$target.bak"

# Copy the original first so the temp file keeps its permissions.
tmp=$(mktemp "$target.XXXXXX")
trap 'rm -f "$tmp"' EXIT
cp -p "$target" "$tmp"
printf '%s\n' "$merged" > "$tmp"
mv "$tmp" "$target"
trap - EXIT

echo "Updated: $target (backup: $target.bak)"
