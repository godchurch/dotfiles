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
alias ls="ls --color=auto"
alias grep="grep --color=auto"

if command -v git > /dev/null
then PROMPT_COMMAND=('__generate_prompt "$?" "$(git branch --show-current 2> /dev/null)"')
else PROMPT_COMMAND=('__generate_prompt "$?" ""')
fi

__generate_prompt ()
{
    declare -- PS1_EXITCODE="$1" PS1_GITBRANCH="$2" PS1_DIRECTORY="$PWD"
    declare -- PS1_STRING=       PS1_PROMPT=        PS1_WIDTH=0

    if [[ "$PS1_EXITCODE" -ne 0 ]]; then
        PS1_STRING="$PS1_EXITCODE "
        PS1_WIDTH="$(( PS1_WIDTH + ${#PS1_STRING} ))"
        PS1_PROMPT="\[\033[93m\]$PS1_EXITCODE\[\033[0m\] "
    fi

    set -- \
        $'\uF0A0 [Git]'         "[D|GIT]"         "/media/$USER/sandisk-pro/main/documents/git" \
        $'\uF0A0 [Main]'        "[D|MAIN]"        "/media/$USER/sandisk-pro/main" \
        $'\uF0A0 [Movies]'      "[D|MOVIES]"      "/media/$USER/sandisk-pro/movies" \
        $'\uF0A0 [Shows]'       "[D|SHOWS]"       "/media/$USER/sandisk-pro/shows" \
        $'\uF0A0 [Watch Later]' "[D|WATCH_LATER]" "/media/$USER/sandisk-pro/watch-later" \
        $'\uF0A0'               "[DRIVE]"         "/media/$USER/sandisk-pro" \
        $'\uF46D [Documents]'   "[H|DOCUMENTS]"   "$HOME/Documents" \
        $'\uF46D [Streams]'     "[H|STREAMS]"     "$HOME/Downloads/streams" \
        $'\uF46D [Downloads]'   "[H|DOWNLOADS]"   "$HOME/Downloads" \
        $'\uF46D [Music]'       "[H|MUSIC]"       "$HOME/Music" \
        $'\uF46D [Pictures]'    "[H|PICTURES]"    "$HOME/Pictures" \
        $'\uF46D [Videos]'      "[H|VIDEOS]"      "$HOME/Videos" \
        $'\uF46D'               "[HOME]"          "$HOME"

    until [[ $# -eq 0 ]]; do
        if [[ "$PS1_DIRECTORY/" == "$3/"* ]]; then
            PS1_DIRECTORY="${PS1_DIRECTORY#"$3"}"
            PS1_DIRECTORY="$1${PS1_DIRECTORY:+ ...$PS1_DIRECTORY}"
            #PS1_DIRECTORY="$2${PS1_DIRECTORY:+ ...$PS1_DIRECTORY}"
            break 1
        fi
        shift 3
    done

    PS1_STRING="$PS1_DIRECTORY"
    PS1_WIDTH="$(( PS1_WIDTH + ${#PS1_STRING} ))"
    if [[ "$PS1_EXITCODE" -eq 0 ]]
    then PS1_PROMPT="$PS1_PROMPT\[\033[92m\]$PS1_DIRECTORY\[\033[0m\]"
    else PS1_PROMPT="$PS1_PROMPT\[\033[91m\]$PS1_DIRECTORY\[\033[0m\]"
    fi

    if [[ -n "$PS1_GITBRANCH" ]]; then
        PS1_STRING=" $PS1_GITBRANCH"
        PS1_WIDTH="$(( PS1_WIDTH + ${#PS1_STRING} ))"
        PS1_PROMPT="$PS1_PROMPT \[\033[93m\]$PS1_GITBRANCH\[\033[0m\]"
    fi

    PS1_WIDTH="$(( PS1_WIDTH + 2 ))"
    PS1=$'\\[\\033[95m\\]\uF101\\[\\033[0m\\] '
    #PS1="\[\033[95m\]#\[\033[0m\] "

    if [[ $(( PS1_WIDTH + 1 )) -lt $((${COLUMNS:-80} / 2)) ]]
    then printf -v PS1 "%s %s" "$PS1_PROMPT" "$PS1"
    else printf -v PS1 "%s\n%s" "$PS1_PROMPT" "$PS1"
    fi
}
