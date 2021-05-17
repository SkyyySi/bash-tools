#!/usr/bin/env bash
add-bash-hook() {
	case "${1}" in
		precmd)
			[[ "${precmd_functions}" =~ "${1}" ]] && return
			precmd_functions+=( "${1}" )
		;;
		preexec)
			[[ "${preexec_functions}" =~ "${1}" ]] && return
			preexec_functions+=( "${1}" )
		;;
		chpwd)
			[[ "${chpwd_functions}" =~ "${1}" ]] && return
			chpwd_functions+=( "${1}" )
		;;
		*)
			echo "Hook '${1}' is not implemented! "
			return 1
		;;
	esac
}