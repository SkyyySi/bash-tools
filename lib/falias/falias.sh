#!/usr/bin/env bash
function command_exists {
	command -v "${1}" &> /dev/null
}

function falias {
	if command_exists "${2}"; then
		eval "function ${1} { ${@:2}; }"
	fi
}