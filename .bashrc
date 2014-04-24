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
_set_user_color() {
    if [ "$USER" = 'root' ]; then
        echo '\[\033[0;31m\]'
    else
        echo '\[\033[0;33m\]'
    fi
}

_set_host_color() {
    if [ "$HOSTNAME" = 'localhost' ]; then
        echo '\[\033[0;32m\]'
    else
        echo '\[\033[0;34m\]'
    fi
}

_DEFAULT_COLOR='\[\033[0;0m\]'

if [ -f ~/.git-completion.bash -a -f ~/.git-prompt.sh ]; then
    source ~/.git-completion.bash
    source ~/.git-prompt.sh
    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWSTASHSTATE=true
    GIT_PS1_SHOWUNTRACKEDFILES=true
    GIT_PS1_SHOWUPSTREAM=true
    GIT_PS1_SHOWCOLORHINTS=true

    export PROMPT_COMMAND='__git_ps1 "'`_set_user_color`'\u'${_DEFAULT_COLOR}'@'`_set_host_color`'\h\[\033[01;33m\] \w\[\033[00m\]" "\n'${_DEFAULT_COLOR}\$' "'
else
    export PS1="["`_set_user_color`"\u${_DEFAULT_COLOR}@"`_set_host_color`"\h${_DEFAULT_COLOR} \w] \$ "
fi
unset -f _set_user_color
unset -f _set_host_color
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
# tmux always use 256-color terminal
alias tmux='tmux -2'
# go up directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
#--------------------------------------

# Source local definitions
if [ -f .bashrc_local ]; then
    . .bashrc_local
fi

