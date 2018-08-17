# ~/.profile: executed by the command interpreter for login shells.

if [ -n "${BASH_VERSION}" ]; then
    if [ -f "${HOME}/.bashrc" ]; then
        . "${HOME}/.bashrc"
    fi
fi

for home_bin_path in "${HOME}/bin" "${HOME}/.local/bin"; do
    if [ -d "${home_bin_path}" -a -n "${PATH%%${home_bin_path}*}" -a -n "${PATH%%*:${home_bin_path}*}" ]; then
        export PATH="${home_bin_path}:${PATH}"
    fi
done

if [ -x /usr/bin/dircolors ]; then
    if [ -r "${HOME}/.dircolors" ]; then
        eval "$(dircolors -b "${HOME}/.dircolors")"
    else
        eval "$(dircolors -b)"
    fi
fi

export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"

export LESSHISTFILE="-"

for default_editor in "/usr/bin/vim" "/usr/bin/vi" "/bin/nano"; do
    if [ -x "${default_editor}" ]; then
        export EDITOR="${default_editor}"
        export VISUAL="${default_editor}"
        break
    fi
done
