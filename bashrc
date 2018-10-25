test -z "$PS1" && return 0
test -n  "$DISPLAY" && shopt -s checkwinsize

PS1='[\u@\h \W]\$ '

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

if ! shopt -oq posix; then
  if test -f "/usr/share/bash-completion/bash_completion"; then
    . "/usr/share/bash-completion/bash_completion"
  elif test -f "/etc/bash_completion"; then
    . "/etc/bash_completion"
  fi
fi
