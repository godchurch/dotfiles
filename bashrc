#!/bin/bash

[[ "$-" != *i* ]] && return

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

alias ll="ls -l --color=auto --human-readable"
alias la="ls -lA --color=auto --human-readable"
alias grp="grep --color=auto"

if command -v git > /dev/null
then PROMPT_COMMAND=('__bash_ps1 "$?" "$(git symbolic-ref --short HEAD 2> /dev/null)"')
else PROMPT_COMMAND=('__bash_ps1 "$?" ""')
fi

__bash_ps1 ()
{
    if ls /usr/local/share/fonts/*.ttf &> /dev/null
    then local PS1_PROMPT=$'\uf292 ' PS1_HOME=$'\uf46d' PS1_DRIVE=$'\uf472' PS1_SPACER=" "
    else local PS1_PROMPT="# "       PS1_HOME="(H)"     PS1_DRIVE="(D)"     PS1_SPACER=
    fi

    local PS1_COLOR_RESET="\[\033[0m\]"     PS1_COLOR_PROMPT="\[\033[95m\]" \
          PS1_COLOR_TRUE="\[\033[92m\]"     PS1_COLOR_FALSE="\[\033[91m\]" \
          PS1_COLOR_EXITCODE="\[\033[93m\]" PS1_COLOR_GITBRANCH="\[\033[93m\]"

    if [[ "${PS1_CONFIG_QUIET:-2}" == "1" ]]; then
        PS1="${PS1_COLOR_PROMPT}${PS1_PROMPT% }${PS1_COLOR_RESET} "
        PS2="$PS1"
        return 0
    fi

    if [[ "$1" -ge 1 ]]
    then local PS1_COLOR_DIRECTORY="$PS1_COLOR_FALSE" PS1_EXITCODE="$1 "
    else local PS1_COLOR_DIRECTORY="$PS1_COLOR_TRUE" PS1_EXITCODE=
    fi

    [[ -n "$2" ]] && local PS1_GITBRANCH=" $2" || local PS1_GITBRANCH=

    local PS1_DIRECTORY="$PWD" PS1_MOUNT="/media/$USER"
    case "$PS1_DIRECTORY" in
        "$HOME") PS1_DIRECTORY="$PS1_HOME" ;;
        "$HOME/"*) PS1_DIRECTORY="${PS1_HOME}${PS1_SPACER}${PS1_DIRECTORY#$HOME/}" ;;
        "$PS1_MOUNT") PS1_DIRECTORY="$PS1_DRIVE" ;;
        "$PS1_MOUNT/"*) PS1_DIRECTORY="${PS1_DRIVE}${PS1_SPACER}${PS1_DIRECTORY#$PS1_MOUNT/}" ;;
    esac

    local PS1_SEPARATOR=" "
    local PS1_WIDTH="$((${#PS1_EXITCODE} + ${#PS1_DIRECTORY} + ${#PS1_GITBRANCH} + ${#PS1_SEPARATOR} + ${#PS1_PROMPT}))"
    [[ "$PS1_WIDTH" -gt "$((${COLUMNS:-80} / 2 ))" ]] && PS1_SEPARATOR=$'\n'

    local PS1_COLORED_EXITCODE="${PS1_EXITCODE:+${PS1_COLOR_EXITCODE}${PS1_EXITCODE% }${PS1_COLOR_RESET} }"
    local PS1_COLORED_DIRECTORY="${PS1_COLOR_DIRECTORY}${PS1_DIRECTORY}${PS1_COLOR_RESET}"
    local PS1_COLORED_GITBRANCH="${PS1_GITBRANCH:+ ${PS1_COLOR_GITBRANCH}${PS1_GITBRANCH# }${PS1_COLOR_RESET}}"
    local PS1_COLORED_PROMPT="${PS1_COLOR_PROMPT}${PS1_PROMPT% }${PS1_COLOR_RESET} "

    PS1="${PS1_COLORED_EXITCODE}${PS1_COLORED_DIRECTORY}${PS1_COLORED_GITBRANCH}${PS1_SEPARATOR}${PS1_COLORED_PROMPT}"
    PS2="${PS1_COLORED_PROMPT}"
}
