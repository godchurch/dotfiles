[[ $- != *i* ]] && return

\unalias -a
umask 0022
unset HISTFILE

IFS=$' \t\n'

[[ -f /usr/share/bash-completion/bash_completion ]] && source /usr/share/bash-completion/bash_completion
[[ -f /usr/lib/git-core/git-sh-prompt ]] && type git &> /dev/null && source /usr/lib/git-core/git-sh-prompt

SetupShell()
{
	[[ $TERM =~ ^xterm|^rxvt|^tmux ]] && echo -en "\033]2;PID: $$\007"

	if type nvim &> /dev/null; then
		export EDITOR="nvim" MANPAGER="nvim +Man!"
	elif type vim &> /dev/null; then
		export EDITOR="vim" MANPAGER="vim --not-a-term -M +MANPAGER -"
	elif type vi &> /dev/null; then
		export EDITOR="vi"
	fi

	# assume 256 color support, unless in tty
	[[ $TERM == 'linux' ]] && local use_color=0 || local use_color=1

	if (($use_color)); then
		alias la="ls -A --color=auto"
		alias ll="ls -Al --color=auto"
		alias grep="grep --color=auto"
	else
		alias la="ls -A -F"
		alias ll="ls -Al -F"
	fi

	alias sudo="sudo "
	alias mv="mv -i"
	alias rm="rm -i"
	alias cp="cp -i"
	alias dt="date '+%n  YEAR: %Y%n MONTH: %m (%B)%n   DAY: %d (%A)%n  TIME: %r%n'"

	if (($use_color)); then
		local PROMPT_COLOR_RESET='\001\033[0m\002'
		local PROMPT_COLOR_STANDARD='\001\033[0m\033[1;38;5;249m\002'
		local PROMPT_COLOR_DIRECTORY='\001\033[0m\033[1;38;5;38m\002'
		local PROMPT_COLOR_ERROR='\001\033[0m\033[1;38;5;161m\002'
	else
		local PROMPT_COLOR_RESET=
		local PROMPT_COLOR_STANDARD=
		local PROMPT_COLOR_DIRECTORY=
		local PROMPT_COLOR_ERROR=
	fi

	local PROMPT_ERROR
	printf -v PROMPT_ERROR 'case $? in (0) ;; (*) echo "%bERROR: $?%b" ;; esac' \
		"$PROMPT_COLOR_ERROR" "$PROMPT_COLOR_RESET"

	if type __git_ps1 &> /dev/null; then
		GIT_PS1_SHOWUPSTREAM="auto"
		GIT_PS1_SHOWDIRTYSTATE=1
		GIT_PS1_SHOWSTASHSTATE=1
		GIT_PS1_SHOWUNTRACKEDFILES=1

		(($use_color)) && GIT_PS1_SHOWCOLORHINTS=1

		printf -v PROMPT_COMMAND '__git_ps1 '\''%b>%b %b\\w%b '\'' '\''%b\\$%b '\''  '\''%b(%b%%s%b)%b '\' \
			"$PROMPT_COLOR_STANDARD" "$PROMPT_COLOR_RESET" "$PROMPT_COLOR_DIRECTORY" "$PROMPT_COLOR_RESET" \
			"$PROMPT_COLOR_STANDARD" "$PROMPT_COLOR_RESET" \
			"$PROMPT_COLOR_STANDARD" "$PROMPT_COLOR_RESET" "$PROMPT_COLOR_STANDARD" "$PROMPT_COLOR_RESET"

		PROMPT_COMMAND=("$PROMPT_ERROR" "$PROMPT_COMMAND")
	else
		printf -v PS1 '> \\w \\$ '

		PROMPT_COMMAND=("$PROMPT_ERROR")
	fi

	PROMPT_DIRTRIM=3
}

SetupShell; unset -f SetupShell
