#!/bin/sh

if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

if command -v nvim > /dev/null; then
    export EDITOR="nvim"
elif command -v vim > /dev/null; then
    export EDITOR="vim"
elif command -v vi > /dev/null; then
    export EDITOR="vi"
fi

export LESSHISTFILE="-"
