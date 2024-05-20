#!/usr/bin/env bash
function banner(){
	readonly version="1.0.0"
	readonly WHITE="$(tput setaf 7)"
	readonly CYAN="$(tput setaf 6)"
	readonly MAGENTA="$(tput setaf 5)"
	readonly YELLOW="$(tput setaf 3)"
	readonly GREEN="$(tput setaf 2)"
	readonly BLUE="$(tput setaf 4)"
	readonly RED="$(tput setaf 1)"
	readonly NORMAL="$(tput sgr0)"
	
	tput init
	ARG1=${1:-0}
    sleep "$ARG1"
	clear
    
	echo -n "${GREEN}                                                         "
    echo -e "${BLUE}                       Version ${version}${YELLOW} OnixSat"
    echo -n "${NORMAL}"
}


banner

script(){

	echo -e "\033[32;94;2m
	_____________________________________________________________________________
	 [+] Trazendo a ajuda: includes/$1                       
	-----------------------------------------------------------------------------
		\033[m"
		
	#echo "$(<$FILE )"
	#echo "$(pad "$(<$FILE )" 30)"
	while read p; do
		echo "         $p"
	done <$1

	echo -e "\033[31;91;2m
	_____________________________________________________________________________
	 [+] Concluido...
	 [+] Registrando O Resultado em logs/$1.txt                       
	-----------------------------------------------------------------------------
		\033[m"

}
script "/etc/mailips"

all(){
	center_text2(){

		local terminal_width=$(tput cols)     # query the Terminfo database: number of columns
		local text="${1:?}"                   # text to center
		local glyph="${2:-=}"                 # glyph to compose the border
		local padding="${3:-2}"               # spacing around the text

		local text_width=${#text}             

		local border_width=$(( (terminal_width - (padding * 2) - text_width) / 2 ))

		local border=                         # shape of the border

		# create the border (left side or right side)
		for ((i=0; i<border_width; i++))
		do
			border+="${glyph}"
		done

		# a side of the border may be longer (e.g. the right border)
		if (( ( terminal_width - ( padding * 2 ) - text_width ) % 2 == 0 ))
		then
			# the left and right borders have the same width
			local left_border=$border
			local right_border=$left_border
		else
			# the right border has one more character than the left border
			# the text is aligned leftmost
			local left_border=$border
			local right_border="${border}${glyph}"
		fi

		# space between the text and borders
		local spacing=

		for ((i=0; i<$padding; i++))
		do
			spacing+=" "
		done

		# displays the text in the center of the screen, surrounded by borders.
		printf "${left_border}${spacing}${text}${spacing}${right_border}\n"
	}
	#center_text2 "Something I want to print" "~"
	#center_text2 "Something I want to print" "=" 60


	function pad (){
		[ "$#" -gt 1 ] && [ -n "$2" ] && printf "%$2.${2#-}s" "$1";
	}

}