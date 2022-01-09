test "X${PS1+INTERACTIVE}" != X || return 0
test "X${BASH_VERSION-}" != X || return 0
test "${BASH_VERSINFO[0]}" -ge 5 || { test "${BASH_VERSINFO[0]}" -eq 4 && test "${BASH_VERSINFO[1]}" -ge 2; } || return 0

\unalias -a
IFS=$' \t\n'

ConfigurePrompt ()
{
	local c_error c_pwd c_standout c_reset
	if (( terminal_colors >= 256 )); then
		c_standout='\[\e[1;38;5;249m\]' c_error='\[\e[1;38;5;161m\]'
		c_pwd='\[\e[1;38;5;73m\]'  c_reset='\[\e[0m\]'
	elif (( terminal_colors >= 8 )); then
		c_standout='\[\e[1;37m\]' c_error='\[\e[1;31m\]'
		c_pwd='\[\e[1;34m\]' c_reset='\[\e[0m\]'
	else
		unset c_error c_pwd c_standout c_reset
	fi

	local s_true s_false s_git s_end
	s_true="${c_reset}${c_standout}> ${c_pwd}\\w"
	s_false="${c_reset}${c_error}ERROR: \$?\\n${c_standout}> ${c_pwd}\\w"
	s_git=" ${c_standout}(${c_reset}%s${c_reset}${c_standout})${c_reset}"
	s_end=" ${c_standout}\\\$${c_reset} "

	if [[ -f ~/.git-prompt.sh ]] && . ~/.git-prompt.sh; then
		GIT_PS1_SHOWUPSTREAM="auto"
		GIT_PS1_SHOWDIRTYSTATE=1
		GIT_PS1_SHOWSTASHSTATE=1
		GIT_PS1_SHOWUNTRACKEDFILES=1

		(( terminal_colors >= 8 )) && GIT_PS1_SHOWCOLORHINTS=1

		s_true="__git_ps1 '$s_true' '$s_end' '$s_git'"
		s_false="__git_ps1 '$s_false' '$s_end' '$s_git'"
	else
		s_true="PS1='${s_true}${s_end}'"
		s_false="PS1='${s_false}${s_end}'"
	fi

	PROMPT_DIRTRIM=3
	PROMPT_COMMAND="PF_$$"

	eval "PF_$$ () { local E_$$=\$?; ((E_$$ == 0)) && $s_true || $s_false; return \$E_$$; }"
}
ConfigureShell ()
{
	if [[ x${BASH_COMPLETION_VERSINFO-} == "x" ]]; then
		if [[ -f /usr/share/bash-completion/bash_completion ]]; then
			. /usr/share/bash-completion/bash_completion
		fi
	fi

	unset HISTFILE

	export LESSHISTFILE=-
	export SED="s/'/'\\\\''/g; s/^.*$/'&'/; s/^''//; s/''$//"

	local terminal_colors current_terminal
	terminal_colors="$(tput colors 2> /dev/null)" || terminal_colors=2
	current_terminal="$(tty 2> /dev/null)"
	current_terminal="${current_terminal:-ERROR}"

	printf '\033]2;%d:%s\033\\' "$$" "${current_terminal#/dev/}"

	if command -v vim; then export EDITOR="vim"
	elif command -v vi; then export EDITOR="vi"
	elif command -v nano; then export EDITOR="nano"
	else unset EDITOR
	fi > /dev/null

	if test "$EDITOR" = "vim"; then
		export MANPAGER="/bin/sh -c \"col -b | view -c 'set ft=man nomod nolist' -\""
	fi

	if (( terminal_colors >= 8 )); then
		GREP_COLORS='ms=01;33:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36'
		LS_COLORS='no=00:fi=01;37:rs=00:di=34:ln=01;36:mh=01;37:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=00;32'

		export GREP_COLORS LS_COLORS
	else
		unset GREP_COLORS LS_COLORS
	fi

	if (( terminal_colors >= 8 )); then
		alias gg="grep --color=auto"
		alias la="ls -AF --color=auto"
		alias ll="ls -AF --color=auto -l"
	else
		alias gg="grep"
		alias la="ls -AF"
		alias ll="ls -AF -l"
	fi

	alias mv="mv -i"
	alias rm="rm -i"
	alias cp="cp -i"
	alias sudo="sudo -E "
	alias date="date '+%n  YEAR: %Y%n MONTH: %m (%B)%n   DAY: %d (%A)%n  TIME: %r%n'"

	ConfigurePrompt; unset -f ConfigurePrompt

	bind -r '\e\C-l'
	bind -x '"\e\C-l": "la"'

}; ConfigureShell; unset -f ConfigureShell
