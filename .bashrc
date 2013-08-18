# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Settings {{{1
#--------------------------------------
# Don't use ^D to exit
set -o ignoreeof
# Disable Ctrl-s
stty stop undef
# Use case-insensitive filename globbing
shopt -s nocaseglob
# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# set default applications
export EDITOR=vim
export PAGER=less
# custom prompt
_set_up_prompt() {
    local _default='\[\033[0;0m\]'
    local _user
    if [ "$USER" = 'root' ]
    then
        local _user='\[\033[0;31m\]'
    else
        local _user='\[\033[0;33m\]'
    fi

    local _host
    if [ "$HOSTNAME" = 'localhost' -o "$HOSTNAME" = 'localhost.localdomain' ]
    then
        local _host='\[\033[0;32m\]'
    else
        local _host='\[\033[0;34m\]'
    fi

    export PS1="[$_user\u$_default@$_host\h$_default \w] \$ "
}
_set_up_prompt
unset -f _set_up_prompt
#--------------------------------------

# Aliases {{{1
#--------------------------------------
# Interactive operation...
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# Default to human readable figures
alias df='df -h'
alias du='du -h'
# Show diff on side by side mode
alias diff='diff -s'
alias colordiff='colordiff -s'
# use ignorecase in less
alias less='less -i'
# colorize on default
alias grep='grep --color'
alias tree='tree --dirsfirst -C'
# Some shortcuts for different directory listings
alias ls='ls -hF --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias lal='ls -lA'
alias lla='ls -lA'
alias l='ls'
# git
alias g='git'
# go up directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
#--------------------------------------

