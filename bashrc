[[ -z "$PS1" ]] && return

unset HISTFILE

if command -v __git_ps1 > /dev/null; then
  GIT_PS1_SHOWDIRTYSTATE='1' GIT_PS1_SHOWUNTRACKEDFILES='1'
  GIT_PS1_SHOWSTASHSTATE='1' GIT_PS1_SHOWUPSTRAP='auto'
  PROMPT_COMMAND='__git_ps1 "($?)[$PWD]" "\n\\\$ " " (%s)"'
else
  PS1='[$?][$PWD]\n\$ '
fi

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

command -v ffmpeg > /dev/null && alias ffmpeg="ffmpeg -hide_banner"
command -v ffprobe > /dev/null && alias ffprobe="ffprobe -hide_banner"
command -v ffplay > /dev/null && alias ffplay="ffplay -hide_banner"

export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32"
export LESSHISTFILE="/dev/null"
export HISTFILE="/dev/null"

if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
  fi
fi
