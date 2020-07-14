if test -n "$PS1"; then
  if test -n "$BASH" && test "$BASH" != "/bin/sh"; then
    test -f "$HOME/.bashrc" && . "$HOME/.bashrc"
  else
    test "$(id -u)" -eq 0 && PS1='# ' || PS1='$ '
  fi
fi

if EDITOR="$(command -v vim)"; then
  export EDITOR
elif EDITOR="$(command -v vi)"; then
  export EDITOR
elif EDITOR="$(command -v nano)"; then
  export EDITOR
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

# vim: ft=sh
