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
    [[ "${PS1_CONFIG_LINES:-2}" -eq 1 ]] &&
        declare -- PS1_SYMBOL=$'\uE285' PS1_EXPANDED= PS1_SEPARATOR=" " ||
        declare -- PS1_SYMBOL=$'\uE285' PS1_EXPANDED= PS1_SEPARATOR=$'\n'

    [[ "$1" -eq 0 ]] &&
        declare -- PS1_PWD="\[\e[32m\]\w\[\e[0m\]" PS1_CODE="" ||
        declare -- PS1_PWD="\[\e[31m\]\w\[\e[0m\]" PS1_CODE="\[\e[33m\]$1\[\e[0m\] "

    if [[ -n "$2" ]]; then
        [[ ${#2} -le 20 ]] &&
            declare -- PS1_BRANCH=" \[\e[33m\]$2\[\e[0m\]" ||
            declare -- PS1_BRANCH=" \[\e[33m\]${2:0:17}...\[\e[0m\]"
    fi

    unset PROMPT_DIRTRIM; PS1="\w"
    until PS1_EXPANDED="${PS1@P}" && [[ ${#PS1_EXPANDED} -le 60 ]]; do
        [[ ${PROMPT_DIRTRIM:=7} -eq 1 ]] && break 1
        PROMPT_DIRTRIM=$((PROMPT_DIRTRIM - 1))
    done

    PS2="\[\e[35m\]$PS1_SYMBOL\[\e[0m\] "
    PS1="\[\e[0m\]${PS1_CODE}${PS1_PWD}${PS1_BRANCH}${PS1_SEPARATOR}${PS2}"
}
