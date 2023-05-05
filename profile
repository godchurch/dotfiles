#!/bin/sh

export HISTFILE=/dev/null
export LESSHISTFILE=/dev/null

if [ -n "$BASH_VERSION" ]; then
	if [ -f ~/.bashrc ]; then
		. ~/.bashrc
	fi
fi
