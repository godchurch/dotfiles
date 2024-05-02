#!/bin/bash

[ -z "$PS1" ] && return

\unalias -a
umask 0022
unset HISTFILE

IFS=$' \t\n'

case "$TERM" in
    xterm*|rxvt*|tmux*) printf "\033]0;PID: %d\007" "$$" ;;
esac

alias sudo="sudo "
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias ls="ls --color=auto"
alias grep="grep --color=auto"

if [ -x /usr/bin/git ]
then PROMPT_COMMAND='prompt_command_handle "$?" "$(/usr/bin/git branch --show-current 2> /dev/null)"'
else PROMPT_COMMAND='prompt_command_handle "$?" ""'
fi

prompt_command_handle ()
{
    case "$1" in
        0) PS1="\[\033[0m\]\[\033[1;34m\]\w${2:+ \[\033[2;33m\] $2}\n\[\033[1;35m\]❯\[\033[0m\] " ;;
        *) PS1="\[\033[0m\]\[\033[1;34m\]\w${2:+ \[\033[2;33m\] $2}\n\[\033[1;35m\]❯\[\033[0m\] " ;;
    esac

    return "$1"
}
