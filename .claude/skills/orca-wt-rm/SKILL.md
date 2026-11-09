---
name: orca-wt-rm
description: Remove the current Orca-managed worktree and its branch after the work is done. Run only when the user explicitly asks, e.g. "/orca-wt-rm", "tidy up this worktree", "このworktreeを片付けて". To sweep every worktree under a parent dir, use worktree-sweep instead.
---

# Remove the current Orca worktree

If any check below fails, abort and delete nothing.

## 1. Identify

The CLI is `orca`; under WSL with Orca installed on Windows it is `orca.exe`.

Run `orca worktree current --json`. The worktree is under `.result.worktree`.

- Abort if `.ok` is false (e.g. `selector_not_found`: not Orca-managed) or
  `.isMainWorktree` is true.
- `ID`: `.id`, the full `<repoId>::<path>` string.
- `PATH`: `git rev-parse --show-toplevel`. Do not use `.path` for git: under
  WSL it is a Windows UNC path (`\\wsl.localhost\...`).
- Orca's branch: `.branch` with `refs/heads/` stripped. It is empty when HEAD
  is detached.
- `BASE`: `.baseRef` (a full ref such as `refs/remotes/origin/master`; may be
  null), else `origin/HEAD`, else `origin/main`.
- `MAIN`: not in the JSON. Use the parent of
  `git rev-parse --path-format=absolute --git-common-dir`.

If `git branch --show-current` differs from Orca's branch (it was renamed),
note both. Both are deleted in step 7.

## 2. Uncommitted changes

`git status --porcelain`: abort if it prints anything.

## 3. Ignored files

`git status --porcelain --ignored | grep '^!!'`, not counting the restored
links `CLAUDE.md` and `.claude`. If any remain, list them and ask before going
on: build outputs, fetched data or local config would be lost.

## 4. Merged into the base

`git fetch --prune origin`, then `git log <BASE>..HEAD`. Abort if it prints
any commit.

## 5. Update the main checkout

If `MAIN` is on BASE's branch and clean, run `git -C <MAIN> pull --ff-only`.
Otherwise leave it alone.

If the branch still exists on the remote, only report it. Never
`git push --delete`.

## 6. Announce

Tell the user what will be deleted (worktree path, branch names) and the log
path `${TMPDIR:-/tmp}/orca-wt-rm-<name>-<timestamp>.log`. Warn that this
session will likely die during the deletion, since it runs inside the
worktree.

## 7. Delete

From `MAIN`, run detached with `nohup`, logging to that file:

```bash
cd <MAIN> && nohup bash -c '
  orca worktree rm --worktree "id:<ID>" --force --delete-branch --json
  git worktree prune
  for b in <BRANCHES>; do
    git show-ref --verify --quiet "refs/heads/$b" && git branch -D "$b"
  done
' > "<LOG>" 2>&1 < /dev/null &
```

`git branch -D` is safe here because step 4 proved the branches are merged,
and Orca does not always delete them: `--delete-branch` keeps any branch
whose changes Orca cannot prove are merged, and `--force` does not force
branch deletion.

Always select by `id:<ID>`. Never use the `active` or `current` selectors (the
command runs from `MAIN`, not the worktree) or `--run-hooks`.

## 8. Report

If the session is still alive, read the log and report whether the worktree
and the branches are gone (`git -C <MAIN> worktree list`,
`git -C <MAIN> branch --list <BRANCHES>`).
