#--------------------------------------
# General Settings {{{1

# Disable greeting messages
set fish_greeting

#--------------------------------------
# Paths {{{1

if status --is-login
  set -U fish_user_paths $HOME/bin
end

#--------------------------------------
# Aliases {{{1

# Interactive operations
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# Display human readable figures
alias df='df -h'
alias du='du -h'
# Show diff on side by side mode
alias diff='diff -s'
alias colordiff='colordiff -s'
# Use ignorecase and chop long lines in less
alias less='less -iS'
# Colorize on default
alias grep='grep --color'
alias tree='tree --dirsfirst -C'
# Some shortcuts for different directory listings
alias ls='ls -hF --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias lal='ls -lA'
alias lla='ls -lA'
alias l='ls'
# Git
alias g='git'
# Let tmux use 256-color terminal
alias tmux='tmux -2'
# Go up directories
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

#--------------------------------------
# fzf {{{1

# On Bash on Windows, remove -fstype option (it doesn't work)
if grep -q 'Microsoft' /proc/version
  set -g FZF_FIND_FILE_COMMAND "
  command find -L . \\( -path '*/\\.*' \\) -prune \
  -o -type f -print \
  -o -type d -print \
  -o -type l -print 2> /dev/null | sed 1d | cut -b3-"
end
