test -z "$PS1" && return

ConfigureShellPrompt ()
{
	if command -v git > /dev/null; then
		if test -r "${XDG_CONFIG_HOME:-$HOME/.config}/git-prompt.sh"; then
			. "${XDG_CONFIG_HOME:-$HOME/.config}/git-prompt.sh"
		fi
	fi

	local colorSupport
	case "$TERM" in
		xterm-color|*-256color) colorSupport= ;;
		*) unset colorSupport ;;
	esac

	local promptTrue promptFalse promptEnd
	promptTrue="${colorSupport+\[\033[37;1m\]}>${colorSupport+\[\033[39;22m\]} ${colorSupport+\[\033[34;1;3m\]}\w${colorSupport+\[\033[39;22;23m\]} "
	promptFalse="${colorSupport+\[\033[31m\]}ERROR${colorSupport+\[\033[39m\]}: \$?\n${promptTrue}"
	promptEnd="${colorSupport+\[\033[37;1m\]}\\\$${colorSupport+\[\033[39;22m\]} "

	if command -v __git_ps1 > /dev/null; then
		promptVariables='GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWUNTRACKEDFILES=1 GIT_PS1_SHOWSTASHSTATE=1 GIT_PS1_SHOWUPSTREAM=auto'
		case "$TERM" in
			xterm-color|*-256color) promptVariables="$promptVariables GIT_PS1_SHOWCOLORHINTS=1" ;;
		esac
		promptTrue="__git_ps1 '$promptTrue' '$promptEnd' '(%s) '"
		promptFalse="__git_ps1 '$promptFalse' '$promptEnd' '(%s) '"
	else
		promptVariables=
		promptTrue="PS1='${promptTrue}${promptEnd}'"
		promptFalse="PS1='${promptFalse}${promptEnd}'"
	fi

	local promptName='PromptFunction'
	eval "$promptName ()
	{
		${promptVariables:+"local ${promptVariables};"}
		case \"\$1\" in
			0)
				$promptTrue
				;;
			[1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])
				$promptFalse
				;;
			*)
				printf '$promptName: illegal exit code -- '\\''%s'\\''\n' \"\${1:-NULL}\";
				return 1;
				;;
		esac;
		return \$1;
	}"

	PROMPT_DIRTRIM=3 PROMPT_COMMAND="$promptName \$?"

	return 0
}
ConfigureShell ()
{
	unset HISTFILE

	if ! shopt -oq posix; then
		if test -r /usr/share/bash-completion/bash_completion; then
			. /usr/share/bash-completion/bash_completion
		elif test -r /etc/bash_completion; then
			. /etc/bash_completion
		fi
	fi

	# Update the window title with the current shell process id and terminal.
	local currentTerminalLocation
	currentTerminalLocation="$(tty 2> /dev/null)"
	currentTerminalLocation="${currentTerminalLocation#/dev/}"
	printf '\033]2;%d:%s\033\\' "$$" "${currentTerminalLocation:-ERROR}"

	case "$TERM" in
		xterm-color|*-256color)
			export GREP_COLORS="ms=01;33:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36"
			export LS_COLORS="rs=00:di=00;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=00;32"
			alias gg="grep --color=auto"
			alias la="ls -AF --color=auto"
			alias ll="ls -AlF --color=auto"
			;;
		*)
			unset GREP_COLORS LS_COLORS
			alias gg="grep"
			alias la="ls -AF"
			alias ll="ls -AlF"
			;;
	esac

	alias mv="mv -i"
	alias rm="rm -i"
	alias cp="cp -i"
	alias sudo="sudo -E "
	alias date="date '+%n  YEAR: %Y%n MONTH: %m (%B)%n   DAY: %d (%A)%n  TIME: %r%n'"

	ConfigureShellPrompt; unset -f ConfigureShellPrompt

	bind -r '\e\C-l'
	bind -x '"\e\C-l": "ll"'

	return 0
}; ConfigureShell; unset -f ConfigureShell

# vim: filetype=sh syntax=bash
