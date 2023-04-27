case "$-" in (*i*) ;; (*) return ;; esac

unset HISTFILE

if ! shopt -oq posix; then
	if [[ -f /usr/share/bash-completion/bash_completion ]]; then
		source /usr/share/bash-completion/bash_completion
	elif [[ -f /etc/bash_completion ]]; then
		source /etc/bash_completion
	fi
fi

\unalias -a
IFS=$' \t\n'

if [[ -x /usr/bin/vim ]]; then
	export EDITOR="/usr/bin/vim" MANPAGER="/usr/bin/vim --not-a-term -M +MANPAGER -"
elif [[ -x /usr/bin/vi ]]; then
	export EDITOR="/usr/bin/vi"
elif [[ -x /usr/bin/nano ]]; then
	export EDITOR="/usr/bin/nano"
fi

export LESSHISTFILE=/dev/null

[[ $TERM =~ ^xterm|^rxvt|^tmux ]] && [[ -x /usr/bin/tty ]] && printf '\e]2;%d:%s\e\\' "$$" "$(/usr/bin/tty)"
[[ $TERM =~ ^xterm-color|-256color$ ]] && PROMPT_COLOR="yes"

if [[ $PROMPT_COLOR == "yes" ]]; then
	export GREP_COLORS='ms=01;33:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36'
	export LS_COLORS='no=00:fi=01;37:rs=00:di=01;38;5;37:ln=01;36:mh=01;37:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=00;32'

	alias la="ls -A --color=auto"
	alias ll="ls -Al --color=auto"
	alias grep="grep --color=auto"
else
	alias la="ls -AF"
	alias ll="ls -AlF"
fi

alias mv="mv -i"
alias rm="rm -i"
alias cp="cp -i"
alias dt="printf '%(%n  YEAR: %Y%n MONTH: %m (%B)%n   DAY: %d (%A)%n  TIME: %r%n%n)T'"

if [[ $PROMPT_COLOR == "yes" ]]; then
	PROMPT_ERROR='\e[1;38;5;161mERROR: %d\e[0m\n'
	PROMPT_BEGIN='\[\e[0m\e[1;38;5;249m\]>\[\e[0m\] \[\e[1;38;5;38m\]\w\[\e[0m\]'
	PROMPT_END=' \[\e[0m\e[1;38;5;249m\]\$\[\e[0m\] '
else
	PROMPT_ERROR='ERROR: %d\n'
	PROMPT_BEGIN='> \w'
	PROMPT_END=' \$ '
fi

PROMPT_ERROR="ERROR_$$=\$?; [[ \$ERROR_$$ -gt 0 ]] && printf '$PROMPT_ERROR' \"\$ERROR_$$\""

if [[ -x /usr/bin/git ]] && [[ -f ~/.local/share/git-prompt.sh ]] && source ~/.local/share/git-prompt.sh; then
	if [[ $PROMPT_COLOR == "yes" ]]; then
		PROMPT_GIT=' \[\e[1;38;5;249m\](\[\e[0m\]%s\[\e[0m\e[1;38;5;249m\])\[\e[0m\]'
	else
		PROMPT_GIT=' (%s)'
	fi

	GIT_PS1_SHOWUPSTREAM="auto"
	GIT_PS1_SHOWDIRTYSTATE=1
	GIT_PS1_SHOWSTASHSTATE=1
	GIT_PS1_SHOWUNTRACKEDFILES=1
	[[ $PROMPT_COLOR == "yes" ]] && GIT_PS1_SHOWCOLORHINTS=1

	PROMPT_PROMPT="__git_ps1 '$PROMPT_BEGIN' '$PROMPT_END' '$PROMPT_GIT'"
	PROMPT_COMMAND=("$PROMPT_ERROR" "$PROMPT_PROMPT")
else
	PS1="${PROMPT_BEGIN}${PROMPT_END}"
	PROMPT_COMMAND=("$PROMPT_ERROR")
fi

unset PROMPT_PROMPT PROMPT_ERROR PROMPT_BEGIN PROMPT_END PROMPT_GIT PROMPT_COLOR

PROMPT_DIRTRIM=3

# vim: filetype=sh syntax=bash
