[[ $- != *i* ]] && return

if [[ -f "${HOME}/.profile" ]]; then
  source "${HOME}/.profile"
fi

[[ -n "${DISPLAY}" ]] && shopt -s checkwinsize

PS1='[\u@\h \W]\$ '

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]; then
    source /etc/bash_completion
  fi
fi
