if [ "${my_environment}" = 1 ]; then
  return 0
fi

my_environment=1
export my_environment

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
