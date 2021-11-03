test -z "$PS1" && return

unset HISTFILE LS_COLORS

alias mv="mv -i"
alias rm="rm -i"
alias cp="cp -i"

if command -v dircolors > /dev/null && eval " $(dircolors -b)"; then
	alias l="ls --color=auto -AF"
	alias ll="ls --color=auto -AlF"
else
	alias l="ls -AF"
	alias ll="ls -AlF"
fi

command -v ffmpeg > /dev/null && alias ffmpeg="ffmpeg -hide_banner"
command -v ffprobe > /dev/null && alias ffprobe="ffprobe -hide_banner"

alias date="date '+%n YEAR: %Y%nMONTH: %m (%B)%n  DAY: %d (%A)%n TIME: %I:%M %p%n'"

if test -n "$LS_COLORS"; then
	__ps1_prompt_print_error ()
	{
		local exit=$?
		case $exit in 0) ;; *) printf '\033[31mERROR\033[0m: EXIT CODE (%d)\n' $exit ;; esac
		return $exit
	}
else
	__ps1_prompt_print_error ()
	{
		local exit=$?
		case $exit in 0) ;; *) printf 'ERROR: EXIT CODE (%d)\n' $exit ;; esac
		return $exit
	}
fi

PROMPT_DIRTRIM=3
PROMPT_COMMAND='__ps1_prompt_print_error;'
if command -v __git_ps1 > /dev/null; then
	GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWUNTRACKEDFILES=1
	GIT_PS1_SHOWSTASHSTATE=1 GIT_PS1_SHOWUPSTREAM="auto"

	if test -n "$LS_COLORS"; then
		GIT_PS1_SHOWCOLORHINTS=1
		PROMPT_COMMAND+=' __git_ps1 "\\[\\e[33m\\]\\u\\[\\e[0m\\] - \\[\\e[34m\\]\\h\\[\\e[0m\\]:\\[\\e[36m\\]\\w\\[\\e[0m\\]" " \\$ " " (%s)"'
	else
		unset GIT_PS1_SHOWCOLORHINTS
		PROMPT_COMMAND+=' __git_ps1 "\\u - \\h:\\w" " \\$ " " (%s)"'
	fi
else
	if test -n "$LS_COLORS"; then
		PS1='\[\e[33m\]\u\[\e[0m\] - \[\e[34m\]\h\[\e[0m\]:\[\e[36m\]\w\[\e[0m\] \$ '
	else
		PS1='\u - \h:\w\$ '
	fi
fi

if test -f /usr/share/bash-completion/bash_completion; then
	shopt -oq posix || . /usr/share/bash-completion/bash_completion
elif test -f /etc/bash_completion; then
	shopt -oq posix || . /etc/bash_completion
fi

bind 'set colored-stats On'
bind 'set colored-completion-prefix On'

bind '"\e[Z": menu-complete'
bind -r '\e\C-l'
bind -x '"\e\C-l": "ll"'

# vim: filetype=sh syntax=bash
