#!/usr/bin/env bash
# hex2rgb code by Rokin (https://stackoverflow.com/users/11417486/rokin)
# from the thread https://stackoverflow.com/questions/7253235/convert-hexadecimal-color-to-decimal-rgb-values-in-unix-shell-script
hex2rgb() {
	local hex_tmp hex a b c r g b
    hex_tmp="${1^^}"
    hex="${hex_tmp//#/}"

    a=$(echo "${hex}" | cut -c-2)
    b=$(echo "${hex}" | cut -c3-4)
    c=$(echo "${hex}" | cut -c5-6)

    r=$(echo "ibase=16; ${a}" | bc)
    g=$(echo "ibase=16; ${b}" | bc)
    b=$(echo "ibase=16; ${c}" | bc)

    echo -n "${r};${g};${b}"
}

color() {
	local ARG PROMPT_MODE PNF PRE END
	while getopts ':p' ARG; do
		case "${ARG}" in
			'p')
				shift
				printf '%s\n' "${@}"
				PROMPT_MODE=true
			;;
			*)
				echo "Unrecognized option '${ARG}'."
				return 1
			;;
		esac
	done
	
	__printf_color() {
		echo -e"${PNF}" "${PRE}\x1b[${1}m${END}"
	}
	
	__color_fg() {
		case "${1}" in
			'black'|'grey') __printf_color '30' ;;
			'red')          __printf_color '31' ;;
			'green')        __printf_color '32' ;;
			'yellow')       __printf_color '33' ;;
			'blue')         __printf_color '34' ;;
			'magenta')      __printf_color '35' ;;
			'cyan')         __printf_color '36' ;;
			'white')        __printf_color '37' ;;
			'reset')        __printf_color '39' ;;
			*) 
				if (( "${1}" < 256 )); then
					__printf_color "38;5;${1}"
				else
					local colors
					colors="$(hex2rgb "${1}")"
					__printf_color "38;2;${colors}"
				fi
			;;
		esac
	}
	
	__color_bg() {
		case "${1}" in
			'black'|'grey') __printf_color '40' ;;
			'red')          __printf_color '41' ;;
			'green')        __printf_color '42' ;;
			'yellow')       __printf_color '43' ;;
			'blue')         __printf_color '44' ;;
			'magenta')      __printf_color '45' ;;
			'cyan')         __printf_color '46' ;;
			'white')        __printf_color '47' ;;
			'reset')        __printf_color '49' ;;
			*) 
				if (( "${1}" < 256 )); then
					__printf_color "48;5;${1}"
				else
					local colors
					colors="$(hex2rgb "${1}")"
					__printf_color "48;2;${colors}"
				fi
			;;
		esac
	}
	
	__color_style() {
		case "${1}" in
			'bold')          __printf_color '1' ;;
			'dim')           __printf_color '2' ;;
			'underlined')    __printf_color '4' ;;
			'blink')         __printf_color '5' ;;
			'reverse')       __printf_color '7' ;;
			'hidden')        __printf_color '8' ;;
			'no_bold')       __printf_color '21' ;;
			'no_dim')        __printf_color '22' ;;
			'no_underlined') __printf_color '24' ;;
			'no_blink')      __printf_color '25' ;;
			'no_reverse')    __printf_color '27' ;;
			'no_hidden')     __printf_color '28' ;;
			'reset')         __printf_color '0' ;;
			*) ;;
		esac
	}
	
	if [[ "${PROMPT_MODE}" == true ]]; then
		shift
		PNF='n'
		PRE='\001'
		END='\002'
	else
		PNF=''
	fi
	
	case "${1}" in
		'fg'|'fore'|'foreground')
			shift
			__color_fg "${*}"
		;;
		'bg'|'back'|'background')
			shift
			__color_bg "${*}"
		;;
		'st'|'style')
			shift
			__color_style "${*}"
		;;
	esac
}