#!/bin/bash

case "$-" in
    *i*) ;;
      *) return 0 ;;
esac

\unalias -a
umask 0022
unset -v HISTFILE

IFS=$' \t\n'

alias sudo="sudo "
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias ls="ls --color=auto"
alias grep="grep --color=auto"

declare -a PROMPT_COMMAND=('BASH_GIT_BRANCH="$(command git branch --show-current 2> /dev/null)"')

PS1='\[\033[0m\]\[\033[1;38;5;109m\]\w\[\033[0m\]${BASH_GIT_BRANCH:+ \[\033[1;38;5;108m\]<$BASH_GIT_BRANCH>\[\033[0m\]} \[\033[1;38;5;137m\]$?\[\033[0m\]\n\[\033[1;38;5;139m\]|\[\033[0m\] '
PS2='\[\033[0m\]\[\033[1;38;5;139m\]|\[\033[0m\] '
