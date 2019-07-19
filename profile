if test -n "$PS1"; then
  if test -n "$BASH" && test "$BASH" != "/bin/sh"; then
    test -f "$HOME/.bashrc" && . "$HOME/.bashrc"
  else
    test "$(id -u)" -eq 0 && PS1='# ' || PS1='$ '
  fi
fi

if test -d "$HOME/bin"; then
  if test -n "${PATH%%$HOME/bin*}"; then
    if test -n "${PATH%%*:$HOME/bin*}"; then
      export PATH="$HOME/bin${PATH:+:$PATH}"
    fi
  fi
fi

if test -d "$HOME/.local/bin"; then
  if test -n "${PATH%%$HOME/.local/bin*}"; then
    if test -n "${PATH%%*:$HOME/.local/bin*}"; then
      export PATH="$HOME/.local/bin${PATH:+:$PATH}"
    fi
  fi
fi

test -d "/tmp/tmp-$(id -u)" || mkdir "/tmp/tmp-$(id -u)"

# vim: ft=sh
