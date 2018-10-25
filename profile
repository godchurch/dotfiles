# ~/.profile: executed by the command interpreter for login shells.

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

if test -x "/usr/bin/vim"; then
  export EDITOR="/usr/bin/vim" VISUAL="/usr/bin/vim"
elif test -x "/usr/bin/vi"; then
  export EDITOR="/usr/bin/vi" VISUAL="/usr/bin/vi"
elif test -x "/bin/nano"; then
  export EDITOR="/bin/nano" VISUAL="/bin/nano"
fi

export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32'

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

export LESSHISTFILE='-'

# vim: ft=sh
