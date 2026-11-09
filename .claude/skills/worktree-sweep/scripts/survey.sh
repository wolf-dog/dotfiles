#!/usr/bin/env bash
#
# Read-only survey step of the worktree-sweep skill.
#
# For every git repo directly under ROOT, list its worktrees (other than the
# main checkout) and judge whether each one can be deleted.
#
# Usage: bash survey.sh [ROOT]
#   ROOT defaults to $WORKTREE_SWEEP_ROOT, then to the parent directory of the
#   current repo's main checkout. A repo is handled once even if several of
#   its worktrees sit under ROOT. The worktree you are running in is skipped.
#
# The only write is `git fetch --prune origin` per repo. git status runs with
# --no-optional-locks so it does not refresh the index.
#
# Output: TSV on stdout with the header
#   verdict repo branch dirty ignored ahead unique pr orca path
#   dirty    uncommitted files (git status, untracked included)
#   ignored  ignored files, not counting CLAUDE.md / .claude (restored links)
#   ahead    commits not in the base branch
#   unique   commits whose patch is not in the base (git cherry). git cherry
#            compares commit by commit, so if it finds any, the branch's
#            combined diff is also compared with each base commit since the
#            merge-base; a match (a squash merge) makes it 0
#   pr       "<number>:<STATE>" from `gh pr list --head <branch> --state all`,
#            or "-"
#   orca     "yes" if the path is under ~/orca/workspaces/, else "no"
#
# Base branch: origin/HEAD, else origin/main.
#
# Verdict (first match wins):
#   KEEP(prunable: run git worktree prune)  the worktree directory is gone
#   KEEP(no base branch)                    neither origin/HEAD nor origin/main
#   KEEP(uncommitted)                       dirty > 0
#   KEEP(unmerged commits)                  unique > 0
#   KEEP(PR open)                           the PR state is OPEN
#   CONFIRM(ignored files)                  ignored > 0
#   DELETE                                  otherwise
#
# Runs on macOS bash 3.2: no arrays, no associative arrays.

set -u

die() {
  echo "survey.sh: $*" >&2
  exit 1
}

# Absolute, symlink-resolved git common dir of the repo at $1.
common_dir_of() {
  local dir=$1 common
  common=$(git -C "$dir" rev-parse --git-common-dir 2>/dev/null) || return 1
  case "$common" in
    /*) ;;
    *) common="$dir/$common" ;;
  esac
  (cd "$common" 2>/dev/null && pwd -P)
}

here=$(pwd -P)

root=${1:-${WORKTREE_SWEEP_ROOT:-}}
if [ -z "$root" ]; then
  common=$(common_dir_of .) || die "not in a git repo; pass ROOT or set WORKTREE_SWEEP_ROOT"
  root=$(dirname "$(dirname "$common")")
fi
[ -d "$root" ] || die "ROOT is not a directory: $root"
root=$(cd "$root" && pwd -P)

have_gh=false
command -v gh >/dev/null 2>&1 && have_gh=true

orca_prefix="$HOME/orca/workspaces/"

# Count entries of `git status --porcelain --ignored` that are ignored ("!!"),
# skipping the top-level CLAUDE.md and .claude restored by
# restore-worktree-links.sh.
count_ignored() {
  git -C "$1" --no-optional-locks status --porcelain --ignored 2>/dev/null |
    awk 'substr($0, 1, 3) == "!! " {
           p = substr($0, 4)
           if (p == "CLAUDE.md" || p == ".claude" || p == ".claude/" || index(p, ".claude/") == 1) next
           n++
         }
         END { print n + 0 }'
}

# Succeeds if the combined diff of HEAD since its merge-base with <base>
# matches the patch of a single commit on <base> after that merge-base, i.e.
# the branch was squash-merged.
is_squash_merged() {
  local path=$1 base=$2 mb id
  mb=$(git -C "$path" merge-base "$base" HEAD 2>/dev/null) || return 1
  id=$(git -C "$path" diff "$mb" HEAD 2>/dev/null | git patch-id --stable 2>/dev/null | cut -d' ' -f1)
  [ -n "$id" ] || return 1
  git -C "$path" log -p --no-merges "$mb..$base" 2>/dev/null |
    git patch-id --stable 2>/dev/null | cut -d' ' -f1 | grep -qx "$id"
}

pr_of() {
  local main=$1 branch=$2 pr
  if ! $have_gh || [ "$branch" = "(detached)" ]; then
    echo -
    return
  fi
  pr=$(cd "$main" && gh pr list --head "$branch" --state all --limit 1 \
         --json number,state --jq '.[0] | select(.) | "\(.number):\(.state)"' 2>/dev/null)
  echo "${pr:--}"
}

# survey_worktree <repo> <main> <base> <path> <branch> <prunable>
survey_worktree() {
  local repo=$1 main=$2 base=$3 path=$4 branch=$5 prunable=$6
  local orca=no dirty ignored ahead unique pr verdict resolved

  # Skip the worktree we are running in (or any directory inside it).
  if [ -d "$path" ]; then
    resolved=$(cd "$path" 2>/dev/null && pwd -P) || resolved=$path
    case "$here/" in
      "$resolved/"*) return ;;
    esac
  fi

  case "$path/" in
    "$orca_prefix"*) orca=yes ;;
  esac

  if [ -n "$prunable" ] || [ ! -d "$path" ]; then
    printf '%s\t%s\t%s\t-\t-\t-\t-\t-\t%s\t%s\n' \
      'KEEP(prunable: run git worktree prune)' "$repo" "$branch" "$orca" "$path"
    return
  fi

  dirty=$(git -C "$path" --no-optional-locks status --porcelain 2>/dev/null | wc -l | tr -d ' ')
  ignored=$(count_ignored "$path")

  if [ -n "$base" ]; then
    ahead=$(git -C "$path" rev-list --count "$base..HEAD" 2>/dev/null) || ahead='?'
    unique=$(git -C "$path" cherry "$base" HEAD 2>/dev/null | grep -c '^+')
    if [ "$unique" -gt 0 ] && is_squash_merged "$path" "$base"; then
      unique=0
    fi
  else
    ahead='?'
    unique='?'
  fi

  pr=$(pr_of "$main" "$branch")

  if [ -z "$base" ] || [ "$ahead" = '?' ]; then
    verdict='KEEP(no base branch)'
  elif [ "$dirty" -gt 0 ]; then
    verdict='KEEP(uncommitted)'
  elif [ "$unique" -gt 0 ]; then
    verdict='KEEP(unmerged commits)'
  else
    case "$pr" in
      *:OPEN) verdict='KEEP(PR open)' ;;
      *)
        if [ "$ignored" -gt 0 ]; then
          verdict='CONFIRM(ignored files)'
        else
          verdict=DELETE
        fi
        ;;
    esac
  fi

  printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
    "$verdict" "$repo" "$branch" "$dirty" "$ignored" "$ahead" "$unique" "$pr" "$orca" "$path"
}

survey_repo() {
  local main=$1 repo base head line path branch prunable first

  repo=$(basename "$main")

  if git -C "$main" remote get-url origin >/dev/null 2>&1; then
    git -C "$main" fetch --prune --quiet origin >&2 2>/dev/null ||
      echo "survey.sh: fetch failed for $repo; using cached refs" >&2
  fi

  base=''
  head=$(git -C "$main" symbolic-ref -q --short refs/remotes/origin/HEAD 2>/dev/null)
  if [ -n "$head" ] && git -C "$main" rev-parse -q --verify "$head^{commit}" >/dev/null 2>&1; then
    base=$head
  elif git -C "$main" rev-parse -q --verify 'refs/remotes/origin/main^{commit}' >/dev/null 2>&1; then
    base=origin/main
  fi

  # Parse `git worktree list --porcelain`. The first block is the main checkout.
  first=true path='' branch='' prunable=''
  while IFS= read -r line || [ -n "$path" ]; do
    case "$line" in
      'worktree '*)
        path=${line#worktree }
        branch='(detached)'
        prunable=''
        ;;
      'branch refs/heads/'*) branch=${line#branch refs/heads/} ;;
      'branch '*) branch=${line#branch } ;;
      prunable*) prunable=yes ;;
      '')
        if [ -n "$path" ]; then
          if $first; then
            first=false
          else
            survey_worktree "$repo" "$main" "$base" "$path" "$branch" "$prunable"
          fi
        fi
        path=''
        ;;
    esac
  done < <(git -C "$main" worktree list --porcelain 2>/dev/null)
}

printf 'verdict\trepo\tbranch\tdirty\tignored\tahead\tunique\tpr\torca\tpath\n'

seen='|'
for dir in "$root"/*; do
  [ -d "$dir" ] || continue
  dir=$(cd "$dir" && pwd -P) || continue

  # Only the top level of a repo, not a plain subdirectory of one.
  top=$(git -C "$dir" rev-parse --show-toplevel 2>/dev/null) || continue
  top=$(cd "$top" && pwd -P) || continue
  [ "$top" = "$dir" ] || continue

  common=$(common_dir_of "$dir") || continue
  case "$seen" in
    *"|$common|"*) continue ;;
  esac
  seen="$seen$common|"

  # Non-bare repos only: the main checkout is the parent of the common dir.
  [ "$(basename "$common")" = .git ] || continue
  survey_repo "$(dirname "$common")"
done

exit 0
