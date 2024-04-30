#!/bin/bash

[ -z "$PS1" ] && return

\unalias -a
umask 0022
unset HISTFILE

IFS=$' \t\n'

case "$TERM" in
    xterm*|rxvt*|tmux*) printf "\e]0;PID: %d\a" "$$" ;;
esac

alias sudo="sudo "
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias ls="ls --color=auto"
alias grep="grep --color=auto"

if [ -x /usr/bin/git ]
then PROMPT_COMMAND=('__generate_prompt "$?" "$(/usr/bin/git branch --show-current 2> /dev/null)"')
else PROMPT_COMMAND=('__generate_prompt "$?" ""')
fi

__generate_prompt ()
{
    case "$1" in
        0) PS1="\n\[\033[1;35m\]❯\[\033[0m\] " ;;
        *) PS1="\n\[\033[1;31m\]❯\[\033[0m\] " ;;
    esac

    if [ -n "$2" ]; then
        PS1=" \[\033[2;33m\]$2\[\033[0m\]$PS1"
    fi

    PS1="\[\033[1;34m\]\w\[\033[0m\]$PS1"
}
