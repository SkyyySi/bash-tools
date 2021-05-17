#!/usr/bin/env bash
print_right_prompt() {
	if [[ -z "${RPS1}" ]]; then
		return
	fi
	
	if [[ -z "${BASH_RPS1_INDENT}" ]]; then
		BASH_RPS1_INDENT='1'
	fi
	
	local rps="${RPS1@P}"
	local rps_short
	rps_short="$(sed 's,\x1B\[[0-9;]*[a-zA-Z],,g' <<<${rps})"
	local rps_length="${#rps_short}"
	
	local cols="${COLUMNS:-$(tput cols)}"
	local space="$(( cols - rps_length - BASH_RPS1_INDENT ))"
	
	printf "%*s${rps}\r" "${space}" ''
}