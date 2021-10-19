if test -n "$PS1"; then
	if test -n "$BASH" && test "$BASH" != "/bin/sh"; then
		test -f "$HOME/.bashrc" && . "$HOME/.bashrc"
	else
		test `id -u` -eq 0 && PS1="# " || PS1="$ "
	fi
fi

if command -v vim > /dev/null; then
	export EDITOR="vim" MANPAGER="vim -M +MANPAGER -"
elif command -v vi > /dev/null; then
	export EDITOR="vi"
elif command -v nano > /dev/null; then
	export EDITOR="nano"
else
	unset EDITOR
fi

if test -d "$HOME/.local/bin"; then
	if test -n "${PATH%%$HOME/.local/bin*}"; then
		if test -n "${PATH%%*:$HOME/.local/bin*}"; then
			PATH="$HOME/.local/bin${PATH:+:$PATH}"
		fi
	fi
fi

if test -d "$HOME/bin"; then
	if test -n "${PATH%%$HOME/bin*}"; then
		if test -n "${PATH%%*:$HOME/bin*}"; then
			PATH="$HOME/bin${PATH:+:$PATH}"
		fi
	fi
fi

# vim: filetype=sh
