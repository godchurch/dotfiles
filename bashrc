[[ $- != *i* ]] && return

unset HISTFILE

if shopt -oq posix; then
	if [[ -f /usr/share/bash-completion/bash_completion ]]; then
		source /usr/share/bash-completion/bash_completion
	elif [[ -f /etc/bash_completion ]]; then
		source /etc/bash_completion
	fi
fi

__terminal_supports_color=$(tput colors 2> /dev/null)
[[ $? -eq 0 ]] && test "${__terminal_supports_color:-2}" -ge 8 || __terminal_supports_color=0

printf '\033]2;%d:%s\033\\' "$$" "$(tty | sed 's|^/dev/||')"

if [[ $__terminal_supports_color -gt 0 ]]; then
	__setup_ls_colors_variable ()
	{
		local LS_COLORS_RESET="rs=0"  #----------------------#  reset to "normal" color
		local LS_COLORS_DIR="di=00;36"  #--------------------#  directory
		local LS_COLORS_LIN="ln=01;36"  #--------------------#  symbolic link.
		local LS_COLORS_MULTIHARDLINK="mh=00"  #-------------#  regular file with more than one link
		local LS_COLORS_FIFO="pi=40;33"  #-------------------#  pipe
		local LS_COLORS_SOCK="so=01;35"  #-------------------#  socket
		local LS_COLORS_DOOR="do=01;35"  #-------------------#  door
		local LS_COLORS_BLK="bd=40;33;01"  #-----------------#  block device driver
		local LS_COLORS_CHR="cd=40;33;01"  #-----------------#  character device driver
		local LS_COLORS_ORPHAN="or=40;31;01"  #--------------#  symlink to nonexistent file, or non-stat'able file ...
		local LS_COLORS_MISSING="mi=00"  #-------------------#  ... and the files they point to
		local LS_COLORS_SETUID="su=37;41"  #-----------------#  file that is setuid (u+s)
		local LS_COLORS_SETGID="sg=30;43"  #-----------------#  file that is setgid (g+s)
		local LS_COLORS_CAPABILITY="ca=30;41"  #-------------#  file with capability
		local LS_COLORS_STICKY_OTHER_WRITABLE="tw=30;42"  #--#  dir that is sticky and other-writable (+t,o+w)
		local LS_COLORS_OTHER_WRITABLE="ow=34;42"  #---------#  dir that is other-writable (o+w) and not sticky
		local LS_COLORS_STICKY="st=37;44"  #-----------------#  dir with the sticky bit set (+t) and not other-writable
		local LS_COLORS_EXEC="ex=01;32"  #-------------------#  This is for files with execute permission

		set -- "$LS_COLORS_RESET" "$LS_COLORS_DIR" "$LS_COLORS_LIN" "$LS_COLORS_MULTIHARDLINK" "$LS_COLORS_FIFO" "$LS_COLORS_SOCK" "$LS_COLORS_DOOR" "$LS_COLORS_BLK" "$LS_COLORS_CHR" "$LS_COLORS_ORPHAN" "$LS_COLORS_MISSING" "$LS_COLORS_SETUID" "$LS_COLORS_SETGID" "$LS_COLORS_CAPABILITY" "$LS_COLORS_STICKY_OTHER_WRITABLE" "$LS_COLORS_OTHER_WRITABLE" "$LS_COLORS_STICKY" "$LS_COLORS_EXEC"

		local IFS=':'; export LS_COLORS="$*"
	}
	__setup_ls_colors_variable; unset -f __setup_ls_colors_variable

	export GREP_COLOR='1;33'
	alias l="ls -AF --color=auto"
	alias ll="ls -AlF --color=auto"
	alias grep="grep --color=auto"
else
	alias l="ls -AF"
	alias ll="ls -AlF"
fi

alias mv="mv -i"
alias rm="rm -i"
alias cp="cp -i"

alias date="date '+%n YEAR: %Y%nMONTH: %m (%B)%n  DAY: %d (%A)%n TIME: %I:%M %p%n'"

{
	command -v ffmpeg && alias ffmpeg="ffmpeg -hide_banner"
	command -v ffprobe && alias ffprobe="ffprobe -hide_banner"
} > /dev/null

__setup_shell_prompt ()
{
	if [[ $__terminal_supports_color -gt 0 ]]; then
		local __prompt_command_begin_true='> \[\e[1;36m\]\w\[\e[0m\]'
		local __prompt_command_begin_false="\[\e[31m\]ERROR\[\e[0m\]: EXIT CODE (\$?)\n$__prompt_command_begin_true"
	else
		local __prompt_command_begin_true='> \w'
		local __prompt_command_begin_false="ERROR: EXIT CODE (\$?)\n$__prompt_command_begin_true"
	fi
	local __prompt_command_end=' \\$ '


	if { command -v git && command -v __git_ps1; } > /dev/null; then
		GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWUNTRACKEDFILES=1 GIT_PS1_SHOWSTASHSTATE=1 GIT_PS1_SHOWCOLORHINTS= GIT_PS1_SHOWUPSTREAM="auto"

		[[ $__terminal_supports_color -gt 0 ]] && GIT_PS1_SHOWCOLORHINTS=1 || unset GIT_PS1_SHOWCOLORHINTS

		local __prompt_command_true="__git_ps1 \"$__prompt_command_begin_true\" '$__prompt_command_end' ' (%s)'"
		local __prompt_command_false="__git_ps1 \"$__prompt_command_begin_false\" '$__prompt_command_end' ' (%s)'"
	else
		local __prompt_command_true="PS1=\"$__prompt_command_begin_true$__prompt_command_end\""
		local __prompt_command_false="PS1=\"$__prompt_command_begin_false$__prompt_command_end\""
	fi


	PROMPT_DIRTRIM=3 PROMPT_COMMAND="case \$? in 0) $__prompt_command_true ;; *) $__prompt_command_false ;; esac"
}
__setup_shell_prompt; unset -f __setup_shell_prompt

bind -r '\e\C-l'
bind -x '"\e\C-l": "ll"'

unset __terminal_supports_color

# vim: filetype=sh syntax=bash
