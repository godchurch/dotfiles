#!/bin/sh

if [ -n "${PS1-}" ]; then
    if [ -n "${BASH_VERSION-}" ]; then
        if [ -f ~/.bashrc ]; then
            . ~/.bashrc
        fi
    fi
fi

if command -v nvim > /dev/null; then
    export EDITOR="nvim"
elif command -v vim > /dev/null; then
    export EDITOR="vim"
elif command -v vi > /dev/null; then
    export EDITOR="vi"
fi

case "$EDITOR" in
    nvim) export MANPAGER="nvim +Man!" ;;
    vim) export MANPAGER="vim --not-a-term -M +MANPAGER" ;;
esac

export LESSHISTFILE="-"
