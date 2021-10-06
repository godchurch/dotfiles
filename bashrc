[[ -z "$PS1" ]] && return

unset HISTFILE

if command -v __git_ps1 > /dev/null; then
  GIT_PS1_SHOWDIRTYSTATE='1' GIT_PS1_SHOWUNTRACKEDFILES='1'
  GIT_PS1_SHOWSTASHSTATE='1' GIT_PS1_SHOWUPSTREAM='auto'
  PROMPT_COMMAND='__git_ps1 "($?)[$PWD]" "\n\\\$ " " (%s)"'
else
  PS1='[$?][$PWD]\n\$ '
fi

alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

command -v ffmpeg > /dev/null && alias ffmpeg='ffmpeg -hide_banner'
command -v ffprobe > /dev/null && alias ffprobe='ffprobe -hide_banner'
command -v ffplay > /dev/null && alias ffplay='ffplay -hide_banner'

if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
  fi
fi
