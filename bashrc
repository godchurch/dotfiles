#!/bin/bash

[[ "$-" != *i* ]] && return

\unalias -a
umask 0022
unset HISTFILE

IFS=$' \t\n'

case "$TERM" in xterm*|rxvt*|tmux*) printf "\e]0;PID: %d\a" "$$" ;; esac

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

PS1_CONFIG_SQUISH_DIRS=("$HOME" "$HOME/Downloads/streams")

__bash_ps1 ()
{
    local PS1_SYMBOL=$'\uE285'   PS1_STRING="\w" \
          PS1_HOME=$'\uF46D'     PS1_EXPANDED= \
          PS1_TRUE="\[\e[92m\]"  PS1_RESET="\[\e[0m\]" \
          PS1_FALSE="\[\e[91m\]" PS1_PROMPT="\[\e[95m\]" \
          PS1_EXIT="\[\e[93m\]"  PS1_GIT="\[\e[93m\]"

    PS1="${PS1_RESET}${PS1_PROMPT}${PS1_SYMBOL}${PS1_RESET} "
    PS2="${PS1_RESET}${PS1_PROMPT}${PS1_SYMBOL}${PS1_RESET} "

    [[ "${PS1_CONFIG_QUIET:-2}" == "1" ]] && return 0

    local PS1_SEPARATOR=$'\n'
    if [[ "$PWD" == "$HOME" ]]; then
        PS1_SEPARATOR=" " PS1_STRING="$PS1_HOME"
    elif [[ "${PS1_CONFIG_SQUISH:-2}" == "1" ]]; then
        PS1_SEPARATOR=" "
    elif [[ -n "$PS1_CONFIG_SQUISH_DIRS" ]]; then
        local PS1_CONFIG_SQUISH_DIRS_INDEX=
        for PS1_CONFIG_SQUISH_DIRS_INDEX in "${PS1_CONFIG_SQUISH_DIRS[@]}"; do
            [[ "$PWD" == "$PS1_CONFIG_SQUISH_DIRS_INDEX" ]] && PS1_SEPARATOR=" "
        done
    fi

    unset PROMPT_DIRTRIM
    until PS1_EXPANDED="${PS1_STRING@P}" && [[ ${#PS1_EXPANDED} -le 60 ]]; do
        [[ ${PROMPT_DIRTRIM:=7} -eq 1 ]] && break 1
        PROMPT_DIRTRIM=$((PROMPT_DIRTRIM - 1))
    done

    if [[ "$1" -eq 0 ]]
    then local PS1_PWD="${PS1_TRUE}${PS1_STRING}${PS1_RESET}" PS1_CODE=""
    else local PS1_PWD="${PS1_FALSE}${PS1_STRING}${PS1_RESET}" PS1_CODE="${PS1_EXIT}${1}${PS1_RESET} "
    fi

    if [[ -n "$2" ]]; then
        if [[ ${#2} -le 20 ]]
        then local PS1_BRANCH=" ${PS1_GIT}$2${PS1_RESET}"
        else local PS1_BRANCH=" ${PS1_GIT}${2:0:17}...${PS1_RESET}"
        fi
    fi

    PS1="${PS1_RESET}${PS1_CODE}${PS1_PWD}${PS1_BRANCH}${PS1_SEPARATOR}${PS1}"
}
