#!/bin/sh

if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

if [ -d "$HOME/.local/bin" ]; then
    if [ -n "${PATH%%$HOME/.local/bin*}" ]; then
        if [ -n "${PATH%%*:$HOME/.local/bin*}" ]; then
            PATH="$HOME/.local/bin:$PATH"
        fi
    fi
fi

if command -v nvim > /dev/null; then
    export EDITOR="nvim" MANPAGER="nvim +Man!"
elif command -v vim > /dev/null; then
    export EDITOR="vim" MANPAGER="vim --not-a-term -M +MANPAGER -"
elif command -v vi > /dev/null; then
    export EDITOR="vi"
fi

export LESSHISTFILE="-"
export INPUTRC="$HOME/.config/inputrc"
