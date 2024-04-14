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
    then declare -- BEGIN="\[\e[32m\]" END="\[\e[35m\]" EXPANDED="" CODE=""
    else declare -- BEGIN="\[\e[31m\]" END="\[\e[35m\]" EXPANDED="" CODE="$1 "
    fi

    if [[ ${#2} -eq 0 ]]; then
        declare -- GIT="" RESET="" BRANCH=""
    else
        if [[ ${#2} -lt 20 ]]
        then declare -- GIT="\[\e[33m\]" RESET="$BEGIN" BRANCH=" $2"
        else declare -- GIT="\[\e[33m\]" RESET="$BEGIN" BRANCH=" ${2:0:15}..."
        fi
    fi

    unset PROMPT_DIRTRIM; PS1="\w"
    until EXPANDED="${PS1@P}" && [[ ${#EXPANDED} -lt 40 ]]; do
        PROMPT_DIRTRIM=$((${PROMPT_DIRTRIM:-7} - 1))
    done

    PS1="\[\e[0m\]${BEGIN}[ ${CODE}${PS1}${GIT}${BRANCH}${RESET} ] ${END}"
    PS2="\[\e[0m\]${BEGIN}  -> ${END}"
}

PS0="\[\e[0m\]"
