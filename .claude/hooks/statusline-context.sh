#!/bin/sh
#
# Claude Code statusLine command. settings.base.json runs it as:
#   /bin/sh "$HOME/.claude/hooks/statusline-context.sh"
#
# Shows the context window usage, e.g. "Opus | ctx 42% used · 116k left",
# colored yellow at 70% and red at 85%. The same stdin JSON is also passed to
# Orca's statusline script so that Orca keeps working.
#
# WARNING: do not put the string "agent-hooks/claude-statusline" in the
# settings.json command. Orca treats such a command as its own and overwrites
# it. That is why this wrapper lives under ~/.claude/hooks and calls Orca's
# script itself.

input=$(cat)

# Hand the same JSON to Orca in the background and do not wait for it.
orca_statusline="$HOME/.orca/agent-hooks/claude-statusline.sh"
if [ -x "$orca_statusline" ]; then
  printf '%s\n' "$input" | /bin/sh "$orca_statusline" >/dev/null 2>&1 &
fi

# shellcheck disable=SC2016
program='
  def humanize:
    if . >= 1000000 then "\((. / 100000 | floor) / 10)m"
    elif . >= 1000 then "\(. / 1000 | floor)k"
    else tostring
    end;

  (.model.display_name // "?") as $model
  | (.context_window // {}) as $cw
  | $cw.used_percentage as $used
  | $cw.context_window_size as $size
  | if $used == null then
      "\($model) | ctx -"
    else
      ($used | floor) as $u
      | (if $u >= 85 then "\u001b[31m"
         elif $u >= 70 then "\u001b[33m"
         else "" end) as $color
      | (if $color == "" then "" else "\u001b[0m" end) as $reset
      | ($cw.current_usage
         | if . == null then null
           else (.input_tokens // 0)
                + (.cache_creation_input_tokens // 0)
                + (.cache_read_input_tokens // 0)
           end) as $tokens
      | (if $size == null then ""
         elif $tokens != null then
           " · \($size - $tokens | humanize) left"
         else
           " · \($size * (100 - $used) / 100 | floor | humanize) left"
         end) as $left
      | "\($model) | \($color)ctx \($u)% used\($left)\($reset)"
    end
'

if ! line=$(printf '%s\n' "$input" | jq -r "$program" 2>/dev/null); then
  line='ctx -'
fi
printf '%s\n' "$line"
