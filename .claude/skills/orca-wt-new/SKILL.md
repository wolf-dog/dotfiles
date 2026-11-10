---
name: orca-wt-new
description: From the main checkout, create a new Orca-managed worktree on branch feature/<name>, restore the CLAUDE.md / .claude links, then start a new claude session inside nvim's terminal in that worktree and hand it a prompt. Triggers include "/orca-wt-new", "create an Orca worktree", "Orca で worktree を作って". Not the same as EnterWorktree, which moves the current session into a worktree.
---

# New Orca worktree with its own claude session

## Usage

`/orca-wt-new <name> [prompt]`

`name` is the branch name without the prefix (e.g. `fix-login`, a ticket
number). The branch becomes `feature/<name>`. The current session stays in the
main checkout.

## Steps

1. Decide the name and the prompt. Ask only if the name is unclear.
2. From the main checkout root, run:

   ```bash
   ~/.claude/skills/orca-wt-new/start.sh <name> "<prompt>"
   ```

   For a long prompt, or one with quotes, write it to a `mktemp` file and pass
   `--prompt-file <file>` instead. The script copies it right away, so the
   file can be removed afterwards.

   Options (before or after the positionals):

   | option | effect |
   |---|---|
   | `--prefix <p>` | branch prefix instead of `feature/` |
   | `--base-branch <ref>` | base branch/ref for the worktree |
   | `--no-claude` | only create the worktree and restore the links |
   | `--no-nvim` | start claude without the nvim wrapper |

3. Read the JSON on the last line and report `status`, `path`, `branch`,
   `terminal` and `links` (and `note` if it is not empty). If there is no
   JSON, the script stopped before creating anything: report its stderr.
   Do not wait for the new session.

## Notes

- claude runs inside nvim via `~/.local/bin/claude-nvim`, installed by
  dotfiles' `.claude/install.sh`. Orca's Claude command override can point at
  the same wrapper, so Orca's new sessions and resumes also open in nvim.
- In nvim's terminal, `<C-j>` is mapped to leave Terminal mode, so it does not
  reach claude.
- On `failed` or `not-started`, report the worktree path if it exists. Never
  delete it.
- Never `orca repo add` an unregistered repo yourself. Show the command the
  script prints to the user.
- Clean up later with the orca-wt-rm skill, only when the user asks.
