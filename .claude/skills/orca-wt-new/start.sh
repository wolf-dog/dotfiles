#!/usr/bin/env bash
#
# Script of the orca-wt-new skill. Run from the main checkout of a repo:
# create an Orca worktree on branch <prefix><name>, restore the untracked
# links in it, then (second half) start claude in it with a prompt.
#
# Usage: start.sh [options] <name> [prompt]
#   --prefix <p>          branch prefix (default "feature/")
#   --base-branch <ref>   base branch/ref for the new worktree
#   --prompt-file <path>  read the prompt from a file (not with [prompt])
#   --no-claude           only create the worktree; do not start claude
#   --no-nvim             start claude without the nvim wrapper
# Options may come before or after the positionals.
#
# Output: one line of JSON on stdout:
#   {status, note, worktreeId, path, branch, terminal, links}
#   status: created (--no-claude), started, not-started or failed.
#   not-started and failed exit 1 and keep the temp files; the worktree is
#   never deleted.
# Errors before the worktree exists go to stderr with exit status 1.
#
# WSL: the Orca CLI may be orca.exe, and paths in Orca's JSON may be Windows
# UNC paths (\\wsl.localhost\...). They are converted with wslpath; Orca's
# repo selector only accepts the path in Orca's own form.
#
# Runs on macOS bash 3.2: no arrays.

set -euo pipefail

die() {
  echo "start.sh: $*" >&2
  exit 1
}

usage() {
  echo "Usage: start.sh [--prefix <p>] [--base-branch <ref>] [--prompt-file <path>] [--no-claude] [--no-nvim] <name> [prompt]" >&2
  exit 1
}

# --- arguments ---------------------------------------------------------------

prefix='feature/'
base_branch=''
prompt_file=''
no_claude=false
no_nvim=false
name=''
prompt=''
have_prompt=false
npos=0

need_value() {
  [ "$2" -ge 2 ] || die "$1 needs a value"
}

while [ $# -gt 0 ]; do
  case "$1" in
    --prefix) need_value "$1" $#; prefix=$2; shift 2 ;;
    --prefix=*) prefix=${1#*=}; shift ;;
    --base-branch) need_value "$1" $#; base_branch=$2; shift 2 ;;
    --base-branch=*) base_branch=${1#*=}; shift ;;
    --prompt-file) need_value "$1" $#; prompt_file=$2; shift 2 ;;
    --prompt-file=*) prompt_file=${1#*=}; shift ;;
    --no-claude) no_claude=true; shift ;;
    --no-nvim) no_nvim=true; shift ;;
    -h | --help) usage ;;
    --)
      shift
      while [ $# -gt 0 ]; do
        npos=$((npos + 1))
        case $npos in
          1) name=$1 ;;
          2) prompt=$1; have_prompt=true ;;
          *) die "too many arguments: $1" ;;
        esac
        shift
      done
      ;;
    -*) die "unknown option: $1" ;;
    *)
      npos=$((npos + 1))
      case $npos in
        1) name=$1 ;;
        2) prompt=$1; have_prompt=true ;;
        *) die "too many arguments: $1" ;;
      esac
      shift
      ;;
  esac
done

[ -n "$name" ] || usage
if $have_prompt && [ -n "$prompt_file" ]; then
  die "give either a prompt or --prompt-file, not both"
fi
if [ -n "$prompt_file" ]; then
  [ -f "$prompt_file" ] && [ -r "$prompt_file" ] || die "prompt file not readable: $prompt_file"
  prompt=$(cat "$prompt_file")
fi

branch="$prefix$name"

# --- checks ------------------------------------------------------------------

if command -v orca >/dev/null 2>&1; then
  orca=orca
elif command -v orca.exe >/dev/null 2>&1; then
  orca=orca.exe
else
  die "orca CLI not found (orca or orca.exe)"
fi
command -v jq >/dev/null 2>&1 || die "jq not found"

if ! $no_claude; then
  if $no_nvim; then
    claude_cmd="$HOME/.local/bin/claude"
    [ -x "$claude_cmd" ] || die "$claude_cmd not found"
  else
    command -v nvim >/dev/null 2>&1 || die "nvim not found (use --no-nvim)"
    claude_cmd="$HOME/.local/bin/claude-nvim"
    [ -x "$claude_cmd" ] || die "$claude_cmd not found (run .claude/install.sh, or use --no-nvim)"
  fi
fi

# Convert a path from Orca's JSON to a local path (Windows UNC under WSL).
to_local_path() {
  case "$1" in
    '\\'* | [A-Za-z]:'\'*)
      if command -v wslpath >/dev/null 2>&1; then
        wslpath -u "$1"
        return
      fi
      ;;
  esac
  printf '%s\n' "$1"
}

status_json=$("$orca" status --json 2>/dev/null) || die "Orca is not reachable ('$orca status --json' failed); start the Orca app"
printf '%s' "$status_json" | jq -e '.ok == true and .result.runtime.reachable == true' >/dev/null 2>&1 ||
  die "Orca runtime is not reachable; start the Orca app"

top=$(git rev-parse --show-toplevel 2>/dev/null) || die "not in a git repo"
main=$(cd "$top" && pwd -P)
[ -d "$main/.git" ] || die "run this from the main checkout, not from a worktree ($main)"

# Find the repo in Orca's list; keep its path in Orca's form for the selector.
repos_json=$("$orca" repo list --json 2>/dev/null) || die "'$orca repo list --json' failed"
repo_path=''
while IFS= read -r p; do
  [ -n "$p" ] || continue
  lp=$(to_local_path "$p")
  lp=$(cd "$lp" 2>/dev/null && pwd -P) || continue
  if [ "$lp" = "$main" ]; then
    repo_path=$p
    break
  fi
done < <(printf '%s' "$repos_json" | jq -r '.result.repos[]?.path // empty')

if [ -z "$repo_path" ]; then
  orca_main=$main
  if [ "$orca" = orca.exe ] && command -v wslpath >/dev/null 2>&1; then
    orca_main=$(wslpath -w "$main")
  fi
  die "this repo is not registered in Orca. Register it with: $orca repo add --path '$orca_main'"
fi

git -C "$main" check-ref-format --branch "$branch" >/dev/null 2>&1 || die "invalid branch name: $branch"
if git -C "$main" show-ref --verify --quiet "refs/heads/$branch"; then
  die "branch already exists: $branch"
fi

# --- create ------------------------------------------------------------------

if [ -n "$base_branch" ]; then
  create_json=$("$orca" worktree create --repo "path:$repo_path" --name "$name" \
    --branch "$branch" --no-parent --base-branch "$base_branch" --json 2>&1) ||
    die "orca worktree create failed: $create_json"
else
  create_json=$("$orca" worktree create --repo "path:$repo_path" --name "$name" \
    --branch "$branch" --no-parent --json 2>&1) ||
    die "orca worktree create failed: $create_json"
fi
printf '%s' "$create_json" | jq -e '.ok == true' >/dev/null 2>&1 ||
  die "orca worktree create failed: $(printf '%s' "$create_json" | jq -r '.error.message // .' 2>/dev/null)"

wt_id=$(printf '%s' "$create_json" | jq -r '.result.worktree.id // empty')
wt_orca_path=$(printf '%s' "$create_json" | jq -r '.result.worktree.path // empty')
terminal=$(printf '%s' "$create_json" | jq -r '.result.startupTerminal.handle // empty')
note=$(printf '%s' "$create_json" | jq -r '.result.warning // empty')
[ -n "$wt_id" ] && [ -n "$wt_orca_path" ] || die "unexpected orca worktree create result: $create_json"

wt_path=$(to_local_path "$wt_orca_path")
[ -d "$wt_path" ] || die "worktree created but its path is not a directory here: $wt_path"
wt_path=$(cd "$wt_path" && pwd -P)

add_note() {
  if [ -n "$note" ]; then
    note="$note; $1"
  else
    note=$1
  fi
}

# Orca may add a suffix to the branch name; rename it back.
actual=$(git -C "$wt_path" branch --show-current 2>/dev/null || true)
if [ -n "$actual" ] && [ "$actual" != "$branch" ]; then
  git -C "$wt_path" branch -m "$actual" "$branch" ||
    die "worktree created at $wt_path, but renaming branch $actual to $branch failed"
  add_note "renamed branch $actual to $branch"
fi

# Restore the untracked links (CLAUDE.md, .claude/*) from the main checkout.
links=''
hook="$HOME/.claude/hooks/restore-worktree-links.sh"
if [ -f "$hook" ]; then
  links_json=$(jq -cn --arg cwd "$wt_path" '{cwd: $cwd}' |
    CLAUDE_PROJECT_DIR="$main" bash "$hook" 2>/dev/null || true)
  links=$(printf '%s' "$links_json" | jq -r '.systemMessage // empty' 2>/dev/null || true)
else
  add_note "link restore hook not found: $hook"
fi

result() {
  jq -cn --arg status "$1" --arg note "$note" --arg id "$wt_id" --arg path "$wt_path" \
    --arg branch "$branch" --arg terminal "$terminal" --arg links "$links" \
    '{status: $status, note: $note, worktreeId: $id, path: $path, branch: $branch,
      terminal: (if $terminal == "" then null else $terminal end), links: $links}'
}

if $no_claude; then
  result created
  exit 0
fi

# --- second half: start claude -------------------------------------------------
#
# claude starts only now, after the links were restored, so that it reads
# CLAUDE.md (and .claude/*) through the restored links. That is also why
# `orca worktree create --agent claude` is not used: it would start claude
# before the links exist, and without the claude-nvim wrapper.

prompt_tmp=''
launcher=''

# Report a failure: keep the temp files, never delete the worktree.
fail() {
  if [ -n "$launcher" ]; then
    add_note "temp files kept: $launcher${prompt_tmp:+ $prompt_tmp}"
  fi
  result "$1"
  exit 1
}

# 1. Terminal: the startup terminal, else the worktree's first one, else a new one.
if [ -z "$terminal" ]; then
  terminal=$("$orca" terminal list --worktree "id:$wt_id" --json 2>/dev/null |
    jq -r '.result.terminals[0].handle // empty' 2>/dev/null || true)
fi
if [ -z "$terminal" ]; then
  terminal=$("$orca" terminal create --worktree "id:$wt_id" --title "$name" --json 2>/dev/null |
    jq -r '.result.terminal.handle // .result.handle // empty' 2>/dev/null || true)
fi
if [ -z "$terminal" ]; then
  add_note "no terminal handle for the worktree"
  fail failed
fi

# 2. Launcher. The prompt is passed as a claude argument, not typed into the
# TUI, where a multi-line prompt would be sent at the first newline. Running
# `bash <launcher>` keeps the quoting intact through the terminal's login
# shell (e.g. fish). Under WSL the terminal runs on the Linux side, so these
# are Linux paths.
tmpdir=${TMPDIR:-/tmp}
launcher=$(mktemp "${tmpdir%/}/orca-wt-new-launcher.XXXXXX") || {
  add_note "could not create a launcher file in $tmpdir"
  fail failed
}
{
  printf 'cd %q || exit 1\n' "$wt_path"
  if [ -n "$prompt" ]; then
    prompt_tmp=$(mktemp "${tmpdir%/}/orca-wt-new-prompt.XXXXXX") || exit 1
    printf '%s' "$prompt" > "$prompt_tmp"
    printf 'exec %q "$(cat %q)"\n' "$claude_cmd" "$prompt_tmp"
  else
    printf 'exec %q\n' "$claude_cmd"
  fi
} > "$launcher" || {
  add_note "could not write the launcher $launcher"
  fail failed
}

if [ -n "$prompt" ]; then
  prompt_note='prompt passed'
else
  prompt_note='no prompt'
fi

if ! "$orca" terminal send --terminal "$terminal" --text "bash $launcher" --enter --json >/dev/null 2>&1; then
  add_note "orca terminal send failed"
  fail failed
fi

# 3. Wait for the TUI to settle: 60 s, then once more 120 s.
idle=false
for ms in 60000 120000; do
  if "$orca" terminal wait --terminal "$terminal" --for tui-idle --timeout-ms "$ms" --json 2>/dev/null |
    jq -e '.ok == true' >/dev/null 2>&1; then
    idle=true
    break
  fi
done
if ! $idle; then
  add_note "timed out waiting for claude to start ($prompt_note)"
  fail not-started
fi

# 4. tui-idle is also reached when claude exits at once, so confirm that the
# terminal is running claude.
is_claude=false
for _ in 1 2 3 4 5; do
  if "$orca" terminal show --terminal "$terminal" --json 2>/dev/null |
    jq -e '.result.terminal.agentIdentity == "claude"' >/dev/null 2>&1; then
    is_claude=true
    break
  fi
  sleep 2
done
if ! $is_claude; then
  tail_lines=$("$orca" terminal read --terminal "$terminal" --limit 20 --json 2>/dev/null |
    jq -r '[.result.terminal.tail[]? | select(length > 0)] | .[-5:] | join(" | ")' 2>/dev/null || true)
  add_note "claude is not running in the terminal ($prompt_note); last lines: ${tail_lines:-(none)}"
  fail not-started
fi

# 5. Started: the prompt was already read into claude's arguments.
rm -f "$launcher" ${prompt_tmp:+"$prompt_tmp"}
add_note "$prompt_note"
result started
exit 0
