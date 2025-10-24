#!/bin/sh

if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

if [ -x /usr/bin/vim ]; then
    export EDITOR="/usr/bin/vim"
    export MANPAGER="/usr/bin/vim +MANPAGER --not-a-term -"
fi

export LESSHISTFILE="-"
