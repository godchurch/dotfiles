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
	[[ $TERM == 'linux' ]] && local USE_COLOR="no" || local USE_COLOR="yes"

	if [[ $USE_COLOR == 'yes' ]]; then
		export GREP_COLORS='ms=01;33:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36'
		export LS_COLORS='no=00:fi=01;37:rs=00:di=01;38;5;37:ln=01;36:mh=01;37:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=00;32'

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

	if [[ $USE_COLOR == 'yes' ]]; then
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

		[[ $USE_COLOR == 'yes' ]] && GIT_PS1_SHOWCOLORHINTS=1

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
