#!/bin/bash

[[ "$-" != *i* ]] && return

\unalias -a
umask 0022
unset HISTFILE

IFS=$' \t\n'

[[ "$TERM" == @(xterm*|rxvt*|tmux*) ]] && printf "\e]2;PID: %d\a" "$$"

if command -v nvim > /dev/null; then
    export EDITOR="nvim" MANPAGER="nvim +Man!"
elif command -v vim > /dev/null; then
    export EDITOR="vim" MANPAGER="vim --not-a-term -M +MANPAGER -"
elif command -v vi > /dev/null; then
    export EDITOR="vi"
fi

alias sudo="sudo "
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

alias ll="ls -l --color=auto --human-readable"
alias la="ls -lA --color=auto --human-readable"
alias grp="grep --color=auto"

if command -v git > /dev/null
then PROMPT_COMMAND=('__bash_ps1 "$?" "$(git symbolic-ref --short HEAD 2> /dev/null)"')
else PROMPT_COMMAND=('__bash_ps1 "$?" ""')
fi

__bash_ps1 ()
{
    if [[ "$1" -eq 0 ]]
    then declare -- BEGIN="\e[0;32m" RESET="\e[32m" END="\e[35m" CODE=
    else declare -- BEGIN="\e[0;31m" RESET="\e[31m" END="\e[35m" CODE="$1 "
    fi

    if [[ -n "$2" ]]
    then declare -- GIT="\e[33m" BRANCH="$2" SHORT="${2:0:20}"
    else declare -- GIT="\e[33m" BRANCH=     SHORT=
    fi

    [[ ${#BRANCH} -gt ${#SHORT} ]] && BRANCH="${SHORT}..."

    PS1="[ ${CODE}\w${BRANCH:+ ${BRANCH}} ] "

    unset PROMPT_DIRTRIM; declare -- EXPANDED="${PS1@P}"
    until [[ ${#EXPANDED} -lt 40 ]]; do
        PROMPT_DIRTRIM=$((${PROMPT_DIRTRIM:-7} - 1)); EXPANDED="${PS1@P}"
    done

    PS1="\[$BEGIN\][ $CODE\w${BRANCH:+ \[$GIT\]${BRANCH}\[$RESET\]} ] \[$END\]"
}

PS0="\[\e[0m\]"
