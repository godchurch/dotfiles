#!/bin/bash

[ -n "${PS1+x}" ] || return 0

\unalias -a
umask 0022
unset HISTFILE

IFS=$' \t\n'

alias sudo="sudo "
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias ls="ls --color=auto"
alias grep="grep --color=auto"

command -p -v git > /dev/null  &&
    declare -a PROMPT_COMMAND=('BASH_GIT_BRANCH="$(command -p git branch --show-current 2> /dev/null)"')

PS2="\[\033[0;00m\]\[\033[1;33m\]|\[\033[0;00m\] "
PS1="\[\033[0;00m\]\[\033[1;34m\]\w\[\033[0;00m\]\${BASH_GIT_BRANCH:+ \[\033[1;36m\]<\$BASH_GIT_BRANCH>\[\033[0;00m\]} \[\033[1;35m\]\$?\[\033[0;00m\]\n$PS2"
