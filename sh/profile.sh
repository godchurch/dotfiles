if [ "${my_environment}" = 1 ]; then
  return 0
fi

remove_path() {
  local input_path="${input_path:-$1}"
  local custom_path=""
  case "${PATH}" in
    *${input_path}*)
      local IFS=":"
      local directory=""
      for directory in ${PATH}; do
        if [ "${directory}" != "${input_path}" ]; then
          custom_path="${custom_path:+${custom_path}:}${directory}"
        fi
      done
      ;;
  esac
  echo "${custom_path:-${PATH}}"
}

prepend_path() {
  local input_path="$1"
  local custom_path="$(remove_path)"
  echo "${input_path}:${custom_path}"
}

append_path() {
  local input_path="$1"
  local custom_path="$(remove_path)"
  echo "${custom_path}:${input_path}"
}

if [ -d "${HOME}/.local/bin" ]; then
  PATH="$(prepend_path "${HOME}/.local/bin")"
  export PATH
fi

my_environment=1
export my_environment

LS_COLORS="di=1:fi=0:ln=36:pi=33;40:so=35:bd=33;40:cd=33;40:or=31:mi=0:ex=32"
export LS_COLORS

XDG_DATA_HOME="${HOME}/.local/share"
XDG_CONFIG_HOME="${HOME}/.config"
XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME XDG_CONFIG_HOME XDG_CACHE_HOME

LESSHISTFILE="-"
export LESSHISTFILE

unset EDITOR
if [ -x "/usr/bin/vim" ]; then
  EDITOR="/usr/bin/vim"
elif [ -x "/usr/bin/vi" ]; then
  EDITOR="/usr/bin/vi"
elif [ -x "/bin/nano" ]; then
  EDITOR="/bin/nano"
fi

export EDITOR="${EDITOR}"
export VISUAL="${EDITOR}"
