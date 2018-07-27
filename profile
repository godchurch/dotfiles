# ~/.profile: executed by the command interpreter for login shells.

if [ -n "${BASH_VERSION}" ]; then
    if [ -f "${HOME}/.bashrc" ]; then
        . "${HOME}/.bashrc"
    fi
fi

ep()
{
    [ $# -gt 0 ] || return 1

    local function_name="ep" \
          requires_two=0 \
          actions= \
          input_delimiter=":" \
          output_delimiter= \
          input_string= \
          output_string= \
          option \
          argument_1 \
          argument_2 \
          IFS

    while getopts ":L:b:B:rpatTfFdDeE" option; do
        case "${option}" in
            b)
                input_delimiter="${OPTARG}"
                ;;
            B)
                output_delimiter="${OPTARG}"
                ;;
            L)
                if [ -n "${output_string}" ]; then
                    printf "%s: option specified more than once -- %c\n" "${function_name}" "${option}" >&2
                    return 1
                fi
                output_string="${OPTARG}"
                ;;
            [rpatfde])
                requires_two=1
                actions="${actions:+${actions}^}${option}"
                ;;
            [TFDE])
                actions="${actions:+${actions}^}${option}"
                ;;
            :)
                printf "%s: option requires an argument -- %c\n" "${function_name}" "${OPTARG}" >&2
                return 1
                ;;
            \?)
                printf "%s: illegal option -- %c\n" "${function_name}" "${OPTARG}" >&2
                return 1
                ;;
        esac
    done
    shift $((OPTIND - 1))

    [ -z "${output_delimiter}" ] && output_delimiter="${input_delimiter}"
    IFS="${input_delimiter}"
    [ -n "${output_string}" ] && input_string="$*" || output_string="$*"

    if [ -z "${output_string}" ]; then
        printf "%s: no arguments to create an output list\n" "${function_name}" >&2
        return 1
    elif [ ${requires_two} -eq 1 ] && [ -z "${input_string}" ]; then
        printf "%s: action(s) require list flag to be set\n" "${function_name}" >&2
        return 1
    fi

    IFS="^"
    set -- ${actions}
    IFS="${input_delimiter}"

    for option in "$@"; do
        case "${option}" in
            r)
                set --
                for argument_1 in ${output_string}; do
                    for argument_2 in ${input_string}; do
                        [ "${argument_1}" = "${argument_2}" ] && continue 2
                    done
                    set -- "$@" "${argument_1}"
                done
                output_string="$*"
                ;;
            p)
                set -- ${input_string} ${output_string}
                output_string="$*"
                ;;
            a)
                set -- ${output_string} ${input_string}
                output_string="$*"
                ;;
            t)
                set --
                for argument_1 in ${input_string}; do
                    for argument_2 in "$@"; do
                        [ "${argument_1}" = "${argument_2}" ] && continue 2
                    done
                    set -- "$@" "${argument_1}"
                done
                input_string="$*"
                ;;
            T)
                set --
                for argument_1 in ${output_string}; do
                    for argument_2 in "$@"; do
                        [ "${argument_1}" = "${argument_2}" ] && continue 2
                    done
                    set -- "$@" "${argument_1}"
                done
                output_string="$*"
                ;;
            f )
                set --
                for argument_1 in ${input_string}; do
                    [ -f "${argument_1}" ] || continue 1
                    set -- "$@" "${argument_1}"
                done
                input_string="$*"
                ;;
            d )
                set --
                for argument_1 in ${input_string}; do
                    [ -d "${argument_1}" ] || continue 1
                    set -- "$@" "${argument_1}"
                done
                input_string="$*"
                ;;
            e )
                set --
                for argument_1 in ${input_string}; do
                    [ -e "${argument_1}" ] || continue 1
                    set -- "$@" "${argument_1}"
                done
                input_string="$*"
                ;;
            F )
                set --
                for argument_1 in ${output_string}; do
                    [ -f "${argument_1}" ] || continue 1
                    set -- "$@" "${argument_1}"
                done
                output_string="$*"
                ;;
            D )
                set --
                for argument_1 in ${output_string}; do
                    [ -d "${argument_1}" ] || continue 1
                    set -- "$@" "${argument_1}"
                done
                output_string="$*"
                ;;
            E )
                set --
                for argument_1 in ${output_string}; do
                    [ -e "${argument_1}" ] || continue 1
                    set -- "$@" "${argument_1}"
                done
                output_string="$*"
                ;;
        esac
    done

    set -- ${output_string}
    IFS="${output_delimiter}"

    printf "%s\n" "$*"
    return 0
}

PATH="$(ep -L "${PATH}" -rdp "${HOME}/.local/bin" "${HOME}/bin")"
export PATH

LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32'
export LS_COLORS

XDG_DATA_HOME="${HOME}/.local/share"
XDG_CONFIG_HOME="${HOME}/.config"
XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME XDG_CONFIG_HOME XDG_CACHE_HOME

LESSHISTFILE="-"
export LESSHISTFILE

editors="/usr/bin/vim /usr/bin/vi /bin/nano"
for editor in ${editors}; do
    [ -x "${editor}" ] || continue 1

    EDITOR="${editor}"
    VISUAL="${editor}"
    export EDITOR VISUAL

    break
done
unset editor editors
