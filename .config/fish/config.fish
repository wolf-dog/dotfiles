#--------------------------------------
# General Settings {{{1

# Disable greeting messages
set fish_greeting
# Set locale
set LANG 'en_US.UTF-8'

#--------------------------------------
# Paths {{{1

if status --is-login
  set PATH $HOME/bin $PATH
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
# source local config {{{1

if [ -f ~/.config/fish/config_local.fish ]
  source ~/.config/fish/config_local.fish
end
