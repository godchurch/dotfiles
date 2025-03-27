#!/bin/sh

case "$-" in
    *i*) [ -n "${BASH_VERSION-}" ] && [ -f ~/.bashrc ] && . ~/.bashrc ;;
esac

if [ -x /usr/bin/vim ]; then
    export EDITOR="/usr/bin/vim"
    export MANPAGER="/usr/bin/vim +MANPAGER --not-a-term -"
fi

export LESSHISTFILE="-"
