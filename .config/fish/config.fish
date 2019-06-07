#--------------------------------------
# General Settings {{{1

# Disable greeting messages
set fish_greeting
# Set locale
set LANG 'en_US.UTF-8'

#--------------------------------------
# Paths {{{1

if status --is-login
  set -U fish_user_paths $HOME/bin $fish_user_paths
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
# dircolors {{{1

if [ -f $HOME/.dircolors ]; and type dircolors >/dev/null ^&1
  eval (dircolors $HOME/.dircolors | sed 's/LS_COLORS=/set LS_COLORS /')
end

#--------------------------------------
# global {{{1

if grep --quiet 'pygments-parser' /usr/local/etc/gtags.conf ^/dev/null
  export GTAGSLABEL=pygments
end

#--------------------------------------
# anyenv {{{1

if [ -d $HOME/.anyenv ];
  status --is-interactive; and source (anyenv init -|psub)
end

if [ -d $HOME/.anyenv/envs/rbenv ];
  status --is-interactive; and source (rbenv init -|psub)
end

if [ -d $HOME/.anyenv/envs/nodenv ];
  status --is-interactive; and source (nodenv init -|psub)
end

dedup_path

#--------------------------------------
# fzf {{{1

# On Bash on Windows, remove -fstype option (it doesn't work)
if grep --quiet 'Microsoft' /proc/version ^/dev/null
  set -g FZF_DEFAULT_COMMAND "command find -L . -mindepth 1 \\( -path '*/\\.*' \\) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | cut -b3-"
end

#--------------------------------------
# source local config {{{1

if [ -f ~/.config/fish/config_local.fish ]
  source ~/.config/fish/config_local.fish
end

