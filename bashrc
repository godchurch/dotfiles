test -n "$PS1" || return 0

PS1='[$?][\u@\h \W]\$ '

UPPER="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
LOWER="abcdefghijklmnopqrstuvwxyz"

unset HISTFILE

alias ls="ls --color=auto"
alias grep="grep --color=auto"

alias ffmpeg="ffmpeg -hide_banner"
alias ffprobe="ffprobe -hide_banner"

test -n "$DISPLAY" && \
  alias alert="notify-send -u normal -i utilities-terminal \"\$(test \"\$?\" -eq 0 && printf \"%s\n\" \"SUCCESS\" || printf \"%s\n\" \"ERROR\")\" \"\$(history 1 | sed 's/^[[:space:]]*[[:digit:]]\{1,\}[[:space:]]\{1,\}\(.*\)[;&][[:space:]]*alert[[:space:]]*$/\1/')\""

if test -x "/usr/bin/vim"; then
  export EDITOR="/usr/bin/vim" VISUAL="/usr/bin/vim"
elif test -x "/usr/bin/vi"; then
  export EDITOR="/usr/bin/vi" VISUAL="/usr/bin/vi"
elif test -x "/bin/nano"; then
  export EDITOR="/bin/nano" VISUAL="/bin/nano"
fi

export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32"

export LESSHISTFILE="/dev/null"

if ! shopt -oq posix; then
  if test -f "/usr/share/bash-completion/bash_completion"; then
    . "/usr/share/bash-completion/bash_completion"
  elif test -f "/etc/bash_completion"; then
    . "/etc/bash_completion"
  fi
fi
