#!/usr/bin/env bash
# chpwd is a function similar to precmd, but it only gets executed if
# the working directory has changed.
# An example use:
#chpwd() {
#	command ls --color=auto -GFhsk
#}

__run_chpwd() {
	if [[ -n "$(type -t chpwd)" ]]; then
		chpwd
	fi
	
	[[ -n "${chpwd_functions}" ]] || return
	local i
	for i in ${chpwd_functions}; do
		"${i}"
	done
}