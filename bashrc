#!/bin/bash
case "$-" in *i*) ;; *) return 0 ;; esac

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

if [ -x /usr/bin/git ]
then PROMPT_COMMAND=('__generate_prompt "$?" "$(/usr/bin/git branch --show-current 2> /dev/null)"')
else PROMPT_COMMAND=('__generate_prompt "$?" ""')
fi

__generate_prompt ()
{
    local PROMPT_STRING= PROMPT_WIDTH=0 PROMPT_DIRECTORY="$PWD"

    if [ "$1" -ne 0 ]; then
        PROMPT_STRING="\[\033[93m\]$1\[\033[0m\] "
        PROMPT_WIDTH="$(($PROMPT_WIDTH + ${#1} + 1))"
    fi

         local PROMPT_UNICODE PROMPT_SHORT PROMPT_FOLDER
    while read PROMPT_UNICODE PROMPT_SHORT PROMPT_FOLDER; do
        case "$PROMPT_DIRECTORY/" in
            "$PROMPT_FOLDER/"*)
                PROMPT_DIRECTORY="${PROMPT_DIRECTORY#"$PROMPT_FOLDER"}"
                PROMPT_DIRECTORY="${PROMPT_UNICODE}${PROMPT_DIRECTORY:+ ...${PROMPT_DIRECTORY}}"
                #PROMPT_DIRECTORY="${PROMPT_SHORT}${PROMPT_DIRECTORY:+ ...${PROMPT_DIRECTORY}}"
                break 1
                ;;
        esac
    done << EOF
\ [Git]            [D|GIT]            /media/$USER/sandisk-pro/main/documents/git
\ [Main]           [D|MAIN]           /media/$USER/sandisk-pro/main
\ [Movies]         [D|MOVIES]         /media/$USER/sandisk-pro/movies
\ [Shows]          [D|SHOWS]          /media/$USER/sandisk-pro/shows
\ [Watch\ Later]   [D|WATCH_LATER]    /media/$USER/sandisk-pro/watch-later
                   [DRIVE]            /media/$USER/sandisk-pro
\ [Documents]      [H|DOCUMENTS]      $HOME/Documents
\ [Streams]        [H|STREAMS]        $HOME/Downloads/streams
\ [Downloads]      [H|DOWNLOADS]      $HOME/Downloads
\ [Music]          [H|MUSIC]          $HOME/Music
\ [Pictures]       [H|PICTURES]       $HOME/Pictures
\ [Videos]         [H|VIDEOS]         $HOME/Videos
                   [HOME]             $HOME
EOF

    if [ "$1" -eq 0 ]
    then PROMPT_STRING="$PROMPT_STRING\[\033[92m\]$PROMPT_DIRECTORY\[\033[0m\]"
    else PROMPT_STRING="$PROMPT_STRING\[\033[91m\]$PROMPT_DIRECTORY\[\033[0m\]"
    fi; PROMPT_WIDTH="$(($PROMPT_WIDTH + ${#PROMPT_DIRECTORY}))"

    if [ -n "$2" ]; then
        PROMPT_STRING="$PROMPT_STRING \[\033[93m\]$2\[\033[0m\]"
        PROMPT_WIDTH="$(($PROMPT_WIDTH + 1 + ${#2}))"
    fi

    PS1="\[\033[95m\]\[\033[0m\] "
    #PS1="\[\033[95m\]#\[\033[0m\] "
    PROMPT_WIDTH="$(($PROMPT_WIDTH + 1 + 1))"

    if [ $(($PROMPT_WIDTH + 1 )) -lt $((${COLUMNS:-80} / 2)) ]
    then PS1="$PROMPT_STRING $PS1"
    else PS1="$PROMPT_STRING
$PS1"
    fi
}
