---
name: worktree-sweep
description: Use to take stock of the worktrees of every repo under a parent dir (both Claude's and Orca's) and delete the unneeded ones with their branches. Triggers include "worktreeを掃除して", "不要なworktreeを消して", "clean up worktrees".
---

# Worktree sweep

## 1. Survey (read-only)

```bash
bash ~/.claude/skills/worktree-sweep/scripts/survey.sh [ROOT] | column -t -s $'\t'
```

ROOT defaults to `$WORKTREE_SWEEP_ROOT`, then the parent of the current repo's
main checkout. It runs `git fetch --prune origin` for every repo, so allow a
long timeout. Main checkouts and the worktree you are running in are not
listed.

| verdict | meaning |
|---|---|
| `DELETE` | candidate for deletion |
| `CONFIRM(ignored files)` | show the ignored files (`git -C <PATH> status --porcelain --ignored \| grep '^!!'`) and ask per worktree: build outputs, fetched data or local config would be lost |
| `KEEP(...)` | leave it; the reason is in the parentheses |

`unique` counts commits whose patch is not in the base branch, so a branch that
was squash- or rebase-merged has `unique` 0 even when `ahead` is not.

## 2. Confirm

Show the DELETE and CONFIRM rows (repo, worktree path, branch, PR), plus the
KEEP count per reason. Ask before deleting anything. Without explicit consent,
delete nothing.

## 3. Delete

Only the worktrees the user approved:

- `orca=yes`: `orca worktree rm --worktree "path:<PATH>"`. Orca removes the
  branch too.
- Otherwise: `git -C <MAIN> worktree remove <PATH>`, then
  `git -C <MAIN> branch -D <BRANCH>`.
  - `<MAIN>` is the parent of `git -C <PATH> rev-parse --path-format=absolute --git-common-dir`.
  - Use `-D` only for branches with `unique` 0 in step 1. Skip it for
    `(detached)`.
  - "branch not found" after Orca already removed it is harmless.
  - If git refuses to remove a worktree, report it. Do not add `--force`
    without asking.

## 4. Verify and report

In each repo touched: `git -C <MAIN> worktree prune`,
`git -C <MAIN> worktree list`, and `git -C <MAIN> branch --list <deleted branches>`
(should print nothing).

Report the deleted and kept worktrees in a table with the reasons.

A branch with the same name in another repo is a different branch. Never
delete it.
