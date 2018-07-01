[[ $- != *i* ]] && return

if [[ -f "${HOME}/.profile" ]]; then
  source "${HOME}/.profile"
fi

shopt -s checkwinsize

PS1='[\u@\h \W]\$ '

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32';
export LS_COLORS

edit_path() (
  local option=     \
        remove="0"  \
        prepend="0" \
        append="0"  \
        variable=   \
        string=

  while getopts :raptv:s: option; do
    case "${option}" in
      r) remove="1" ;;
      a) append="1" ;;
      p) prepend="1" ;;
      v) variable="${OPTARG}" ;;
      s) string="${OPTARG}" ;;
      :)
        echo "${FUNCNAME}: option needs an argument -- '${OPTARG}'"
        return 1
        ;;
      \?)
        echo "${FUNCNAME}: invalid option -- '${OPTARG}'"
        return 1
        ;;
    esac
  done
  shift $((OPTIND - 1))

  if [[ -z "${string}" ]]; then
    echo "${FUNCNAME}: string missing"
    return 1
  fi

  if [[ -z "${variable}" ]]; then
    echo "${FUNCNAME}: variable missing"
    return 1
  fi

  local value="${!variable}"

  local IFS=':'
  set -- ${value}
  for argument; do
    shift
    [[ "${argument}" == "${string}" ]] && continue
    set -- "$@" "${argument}"
  done

  if [[ "${remove}" -eq 1 ]]; then
    printf "%s;\n%s\n" "${variable}=$*" "export ${variable}"
  elif [[ "${append}" -eq 1 ]]; then
    printf "%s;\n%s\n" "${variable}=$*:${string}" "export ${variable}"
  elif [[ "${prepend}" -eq 1 ]]; then
    printf "%s;\n%s\n" "${variable}=${string}:$*" "export ${variable}"
  fi
)

if [ -d "${HOME}/.local/bin" ]; then
  eval "$(edit_path -p -v "PATH" -s "${HOME}/.local/bin")"
fi

if ! shopt -oq posix; then
  if [[ -f "/usr/share/bash-completion/bash_completion" ]]; then
    source "/usr/share/bash-completion/bash_completion"
  elif [[ -f "/etc/bash_completion" ]]; then
    source "/etc/bash_completion"
  fi
fi
