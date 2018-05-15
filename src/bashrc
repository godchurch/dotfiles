if [[ $- != *i* ]]; then
  return 0
fi

if [[ -f "${HOME}/.profile" ]]; then
  source "${HOME}/.profile"
fi

if [[ -n "${DISPLAY}" ]]; then
  shopt -s checkwinsize
fi

PS1='\[\e[1m\]●\[\e[0m\] [$?] \u:\h [\w]\n\$ '

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
