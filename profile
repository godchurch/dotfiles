# ~/.profile: executed by the command interpreter for login shells.

if [ -n "${BASH_VERSION}" ]; then
    if [ -f "${HOME}/.bashrc" ]; then
        . "${HOME}/.bashrc"
    fi
fi

for home_bin_path in "${HOME}/bin" "${HOME}/.local/bin"; do
    if [ -d "${home_bin_path}" ]; then
        if [ -n "${PATH%%${home_bin_path}*}" ]; then
            if [ -n "${PATH%%*:${home_bin_path}*}" ]; then
                export PATH="${home_bin_path}:${PATH}"
            fi
        fi
    fi
done
unset home_bin_path

for default_editor in /usr/bin/vim /usr/bin/vi /bin/nano; do
    if [ -x "${default_editor}" ]; then
        export EDITOR="${default_editor}"
        export VISUAL="${default_editor}"
        break 1
    fi
done
unset default_editor

export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32'

export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"

export LESSHISTFILE='-'
