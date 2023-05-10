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
		local prompt_reset=$'\001\033[0m\002'
		local prompt_normal=$'\001\033[0m\033[1;38;5;255m\002'
		local prompt_folder=$'\001\033[0m\033[1;38;5;38m\002'
		local error_color=$'\033[0m\033[1;38;5;161m'
		local error_reset=$'\033[0m'
	else
		local prompt_reset=''
		local prompt_normal=''
		local prompt_folder=''
		local error_color=''
		local error_reset=''
	fi

	PROMPT_COMMAND=("case \$? in (0) ;; (*) echo \"${error_color}ERROR: \$?${error_reset}\" ;; esac")

	local prompt_start="${prompt_normal}>${prompt_reset} ${prompt_folder}\\w${prompt_reset}"
	local prompt_end="${prompt_normal}\\\$${prompt_reset}"

	PS1="${prompt_start} ${prompt_end} " PROMPT_DIRTRIM=4

	type __git_ps1 &> /dev/null || return 0

	(($use_color)) && GIT_PS1_SHOWCOLORHINTS=1

	GIT_PS1_SHOWSTASHSTATE=1
	GIT_PS1_SHOWDIRTYSTATE=1
	GIT_PS1_SHOWUNTRACKEDFILES=1
	GIT_PS1_SHOWUPSTREAM="auto"

	(($use_color)) && local prompt_git="%s" || local prompt_git="(%s)"

	PROMPT_COMMAND+=("__git_ps1 '$prompt_start ' '$prompt_end '  '$prompt_git '")
}

SetupShell; unset -f SetupShell
