#!/bin/bash

[[ $- != *i* ]] && return

\unalias -a
umask 0022
unset HISTFILE

IFS=$' \t\n'

[[ $TERM == @(xterm*|rxvt*|tmux*) ]] && printf "\e]2;PID: %d\a" "$$"

if command -v nvim > /dev/null; then
    export EDITOR="nvim" MANPAGER="nvim +Man!"
elif command -v vim > /dev/null; then
    export EDITOR="vim" MANPAGER="vim --not-a-term -M +MANPAGER -"
elif command -v vi > /dev/null; then
    export EDITOR="vi"
fi

if [[ $TERM != "linux" ]]; then
    alias la="ls -A --color=auto"
    alias ll="ls -Al --color=auto"
    alias grep="grep --color=auto"
else
    alias la="ls -A -F"
    alias ll="ls -Al -F"
fi

alias sudo="sudo "
alias mv="mv -i"
alias rm="rm -i"
alias cp="cp -i"

if command -v git > /dev/null; then
    PROMPT_COMMAND=('__bash_ps1 "$?" "$(git symbolic-ref --short HEAD 2> /dev/null)"')
else
    PROMPT_COMMAND=('__bash_ps1 "$? ""')
fi

__bash_ps1 ()
{
    local open="[ " close=" ]" end="\[\e[36m\]"

    case "$1" in
        (0) local begin="\[\e[1;32m\]" reset="\[\e[32m\]" code=""    ;;
        (*) local begin="\[\e[1;31m\]" reset="\[\e[31m\]" code="$1 " ;;
    esac

    case "${#2}" in
        (0) local git=             branch=     branch_short=            sep=    ;;
        (*) local git="\[\e[33m\]" branch="$2" branch_short="${2:0:20}" sep=" " ;;
    esac

    [ "${#branch}" -gt "${#branch_short}" ] && branch="${branch_short}..."

    case "$PWD" in
        (~)   local cwd="~"         ;;
        (~/*) local cwd="~${PWD#~}" ;;
        (*)   local cwd="$PWD"      ;;
    esac

    until [ "$((${#open} + ${#code} + ${#cwd} + ${#sep} + ${#branch} + ${#close}))" -lt 60 ]; do
        case "$cwd" in
            (.../*/*) cwd=".../${cwd#.../*/}" ;;
               (/*/*) cwd=".../${cwd#/*/}" ;;
                  (*) break 1 ;;
        esac
    done

    PS0="\[\e[0m\]"
    PS1="${begin}${open}${code}${cwd}${branch:+${sep}${git}${branch}${reset}}${close} ${end}"
}
