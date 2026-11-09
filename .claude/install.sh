#!/usr/bin/env bash
#
# Apply the machine-independent Claude config in dotfiles/.claude to this
# machine.
#
# - CLAUDE.md, hooks/* and skills/* are symlinked into ~/.claude, one file or
#   one skill directory at a time. ~/.claude itself is never symlinked as a
#   whole.
# - bin/* is symlinked into ~/.local/bin.
# - settings.json is NOT symlinked: it is machine-local, and apply-settings.sh
#   merges settings.base.json into it.
# - Machine-specific things are placed directly in ~/.claude and are not
#   handled here.

set -euo pipefail

src=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)
dst="$HOME/.claude"
bindir="$HOME/.local/bin"

mkdir -p "$dst/hooks" "$dst/skills" "$bindir"

# link <from> <to>
link() {
  local from=$1 to=$2 backup

  if [[ -L "$to" && "$(readlink "$to")" == "$from" ]]; then
    return 0
  fi

  if [[ -e "$to" || -L "$to" ]]; then
    if [[ ! -L "$to" ]] && diff -rq "$from" "$to" >/dev/null 2>&1; then
      rm -rf "$to"
    else
      # Back up outside the original directory: a backup inside skills/ would
      # be loaded as a second skill with the same name.
      backup="$dst/pre-dotfiles-backup/${to#"$HOME"/}"
      mkdir -p "$(dirname "$backup")"
      rm -rf "$backup"
      mv "$to" "$backup"
      echo "Backed up: $to -> $backup"
    fi
  fi

  ln -s "$from" "$to"
  echo "Linked: $to -> $from"
}

link "$src/CLAUDE.md" "$dst/CLAUDE.md"

# Globs that match nothing stay literal, so check each entry before linking.
for f in "$src"/hooks/*; do
  [[ -f "$f" ]] || continue
  link "$f" "$dst/hooks/$(basename "$f")"
done

for d in "$src"/skills/*; do
  [[ -d "$d" ]] || continue
  link "$d" "$dst/skills/$(basename "$d")"
done

for f in "$src"/bin/*; do
  [[ -f "$f" ]] || continue
  link "$f" "$bindir/$(basename "$f")"
done

# CLAUDE.md imports this file.
if [[ ! -e "$dst/CLAUDE.local.md" ]]; then
  echo '# Machine-specific instructions (not managed by dotfiles)' > "$dst/CLAUDE.local.md"
fi

bash "$src/apply-settings.sh"
