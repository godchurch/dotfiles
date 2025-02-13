#!/bin/sh

[ -n "$BASH_VERSION" -a -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

if command -v nvim > /dev/null; then export EDITOR="nvim" MANPAGER="nvim +Man!"
elif command -v vim > /dev/null; then export EDITOR="vim" MANPAGER="vim --not-a-term -M +MANPAGER -"
elif command -v vi > /dev/null; then export EDITOR="vi"
fi

export LESSHISTFILE="-"
