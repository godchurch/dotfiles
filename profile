#!/bin/sh

[ -n "$BASH_VERSION" -a -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

if command -v nvim > /dev/null; then export EDITOR="nvim"
elif command -v vim > /dev/null; then export EDITOR="vim"
elif command -v vi > /dev/null; then export EDITOR="vi"
fi

export LESSHISTFILE="-"
