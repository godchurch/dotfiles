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

export LESSHISTFILE="-"
