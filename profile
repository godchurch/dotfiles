# ~/.profile: executed by the command interpreter for login shells.

if test -n "$PS1"; then
  if test -n "$BASH" && test "$BASH" != "/bin/sh"; then
    if test -f "$HOME/.bashrc"; then
      . "$HOME/.bashrc"
    fi
  else
    if test "$(id -u)" -eq 0; then
      PS1='# '
    else
      PS1='$ '
    fi
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

# vim: ft=sh
