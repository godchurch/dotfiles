# ~/.profile: executed by the command interpreter for login shells.

if [ -n "${BASH_VERSION}" ]; then
    if [ -f "${HOME}/.bashrc" ]; then
        . "${HOME}/.bashrc"
    fi
fi

edit_path ()
{
    [ $# -gt 0 ] || return 1

    local PROGNAME \
          DELIMITER \
          REQUIRESTWO \
          ACTIONS \
          INPUTSTRING \
          OUTPUTSTRING \
          OPTION \
          ARGUMENT1 \
          ARGUMENT2 \
          IFS

    PROGNAME="edit_path"
    DELIMITER=":"
    REQUIRESTWO="false"
    ACTIONS=
    INPUTSTRING=
    OUTPUTSTRING=

    while getopts ":b:L:rpatTfFdDeE" OPTION; do
        case "${OPTION}" in
            b)
                DELIMITER="${OPTARG}"
            ;;
            L)
                if [ -n "${OUTPUTSTRING}" ]; then
                  printf "%s: option can only be specified once -- %c\n" "${PROGNAME}" "${OPTARG}" 1>&2
                  return 1
                fi
                OUTPUTSTRING="${OPTARG}"
            ;;
            [rpatfde])
                REQUIRESTWO="true";
                ACTIONS="${ACTIONS:+${ACTIONS} }${OPTION}"
            ;;
            [TFDE])
                ACTIONS="${ACTIONS:+${ACTIONS} }${OPTION}"
            ;;
            :)
                printf "%s: option requires an argument -- %c\n" "${PROGNAME}" "${OPTARG}" 1>&2
                return 1
            ;;
            \?)
                printf "%s: illegal option -- %c\n" "${PROGNAME}" "${OPTARG}" 1>&2
                return 1
            ;;
        esac
    done
    shift $((OPTIND - 1))

    IFS="${DELIMITER}"

    if [ "${REQUIRESTWO}" = "true" ] && [ -z "${OUTPUTSTRING}" ]; then
        printf "%s: action(s) require list flag\n" "${PROGNAME}" 1>&2
        return 1
    fi

    if [ -z "${ACTIONS}" ]; then
        if [ -n "${OUTPUTSTRING}" ]; then
            printf "%s: list flag requires an action option\n" "${PROGNAME}" 1>&2
            return 1
        elif [ $# -lt 1 ]; then
          printf "%s: no arguments supplied\n" "${PROGNAME}" 1>&2
          return 1
        fi
        printf "%s\n" "$*"
        return 0
    fi

    [ -n "${OUTPUTSTRING}" ] && INPUTSTRING="$*" || OUTPUTSTRING="$*"

    IFS=" "
    set -- ${ACTIONS}
    IFS="${DELIMITER}"
    ACTIONS="$*"

    for OPTION in ${ACTIONS}; do
        case "${OPTION}" in
            r)
                set --
                for ARGUMENT1 in ${OUTPUTSTRING}; do
                    for ARGUMENT2 in ${INPUTSTRING}; do
                        [ "${ARGUMENT1}" = "${ARGUMENT2}" ] && continue 2
                    done
                    set -- "$@" "${ARGUMENT1}"
                done
                OUTPUTSTRING="$*"
            ;;
            p)
                set -- ${INPUTSTRING} ${OUTPUTSTRING}
                OUTPUTSTRING="$*"
            ;;
            a)
                set -- ${OUTPUTSTRING} ${INPUTSTRING}
                OUTPUTSTRING="$*"
            ;;
            t)
                set --
                for ARGUMENT1 in ${INPUTSTRING}; do
                    for ARGUMENT2 in "$@"; do
                        [ "${ARGUMENT1}" = "${ARGUMENT2}" ] && continue 2
                    done
                    set -- "$@" "${ARGUMENT1}"
                done
                INPUTSTRING="$*"
            ;;
            T)
                set --
                for ARGUMENT1 in ${OUTPUTSTRING}; do
                    for ARGUMENT2 in "$@"; do
                        [ "${ARGUMENT1}" = "${ARGUMENT2}" ] && continue 2
                    done
                    set -- "$@" "${ARGUMENT1}"
                done
                OUTPUTSTRING="$*"
            ;;
            f)
                set --
                for ARGUMENT1 in ${INPUTSTRING}; do
                    [ -f "${ARGUMENT1}" ] || continue 1
                    set -- "$@" "${ARGUMENT1}"
                done
                INPUTSTRING="$*"
            ;;
            d)
                set --
                for ARGUMENT1 in ${INPUTSTRING}; do
                    [ -d "${ARGUMENT1}" ] || continue 1
                    set -- "$@" "${ARGUMENT1}"
                done
                INPUTSTRING="$*"
            ;;
            e)
                set --
                for ARGUMENT1 in ${INPUTSTRING}; do
                    [ -e "${ARGUMENT1}" ] || continue 1
                    set -- "$@" "${ARGUMENT1}"
                done
                INPUTSTRING="$*"
            ;;
            F)
                set --
                for ARGUMENT1 in ${OUTPUTSTRING}; do
                    [ -f "${ARGUMENT1}" ] || continue 1
                    set -- "$@" "${ARGUMENT1}"
                done
                OUTPUTSTRING="$*"
            ;;
            D)
                set --
                for ARGUMENT1 in ${OUTPUTSTRING}; do
                    [ -d "${ARGUMENT1}" ] || continue 1
                    set -- "$@" "${ARGUMENT1}"
                done
                OUTPUTSTRING="$*"
            ;;
            E)
                set --
                for ARGUMENT1 in ${OUTPUTSTRING}; do
                    [ -e "${ARGUMENT1}" ] || continue 1
                    set -- "$@" "${ARGUMENT1}"
                done
                OUTPUTSTRING="$*"
            ;;
        esac
    done

    printf "%s\n" "${OUTPUTSTRING}"
    return 0
}

PATH="$(edit_path -L "${PATH}" -rdp "${HOME}/.local/bin" "${HOME}/bin")"

LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32'
export LS_COLORS

XDG_DATA_HOME="${HOME}/.local/share"
XDG_CONFIG_HOME="${HOME}/.config"
XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME XDG_CONFIG_HOME XDG_CACHE_HOME

LESSHISTFILE="-"
export LESSHISTFILE

unset EDITOR VISUAL
if [ -x "/usr/bin/vim" ]; then
    EDITOR="/usr/bin/vim"
    VISUAL="/usr/bin/vim"
    export EDITOR VISUAL
elif [ -x "/usr/bin/vi" ]; then
    EDITOR="/usr/bin/vi"
    VISUAL="/usr/bin/vi"
    export EDITOR VISUAL
elif [ -x "/bin/nano" ]; then
    EDITOR="/bin/nano"
    VISUAL="/bin/nano"
    export EDITOR VISUAL
fi
