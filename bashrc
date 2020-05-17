test -z "$PS1" && return

PS1='[$?][$PWD]$ '

UPPER="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
LOWER="abcdefghijklmnopqrstuvwxyz"

alias ls="ls --color=auto"
alias grep="grep --color=auto"

alias ffmpeg="ffmpeg -hide_banner"
alias ffprobe="ffprobe -hide_banner"
alias ffplay="ffplay -hide_banner"

if test -x /usr/bin/vim; then
  export EDITOR="/usr/bin/vim" VISUAL="/usr/bin/vim"
elif test -x /usr/bin/vi; then
  export EDITOR="/usr/bin/vi" VISUAL="/usr/bin/vi"
elif test -x /bin/nano; then
  export EDITOR="/bin/nano" VISUAL="/bin/nano"
fi

export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32"
export LESSHISTFILE="/dev/null"
export HISTFILE="/dev/null"

if ! shopt -oq posix; then
  if test -f /usr/share/bash-completion/bash_completion; then
    . /usr/share/bash-completion/bash_completion
  elif test -f /etc/bash_completion; then
    . /etc/bash_completion
  fi
fi
