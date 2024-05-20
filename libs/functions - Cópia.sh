#!/bin/bash
print_center(){
    local x
    local y
	
	while read -r line; do
    text+=("$line")
	done < /etc/mailips

    #text="$*"
    x=$(( ($(tput cols) - ${#text}) / 2))
    echo -ne "\E[6n";read -sdR y; y=$(echo -e "${y#*[}" | cut -d';' -f1)
    echo -e "\033[${y};${x}f$*"
}

# clear the screen, put the cursor at line 10, and set the text color to light blue.
#echo -ne "\\033[2J\033[10;1f\e[94m"

print_center "/etc/mailips" #'A big blue title!'



f_M () {
    tl=100
    _c=50
    _L=5
    f_numread () {
        printf $1 | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta'
    }
    f_C () {
        local x=$(printf $1 | wc -c)
        local y=$(expr $_c - $(expr $x / 2))
        local z=$(expr $tl - $y)
        local space=' '
        printf "%${y}s%-${z}s\n" "$space" "$1"
    }
    case $1 in
        -S)
            fill=' '
            if [[ -n $2 ]]; then
                if [[ -n $3 ]]; then
                    fill="$2"
                    if [[ $3 =~ ^-?[0-9]+$ ]]; then
                        tl=$3
                    fi
                else
                    if [[ $2 =~ ^-?[0-9]+$ ]]; then
                        tl=$2
                    fi
                fi
            fi
            printf "${fill}%.0s" {1..$tl}
            ;;
        *)
            if [[ $3 =~ ^-?[0-9]+$ ]]; then
                tl=$3
                _L=$3
                _c=$(expr $tl / 2)
            fi
            if [[ $1 =~ ^-?[0-9]+$ ]]; then
                local x=$(f_numread $1)
                case $2 in
                    L)
                        printf "%-${_L}s\n" "$x" ;;
                    R)
                        printf "%${_L}s\n" "$x" ;;
                    C)
                        f_C $x ;;
                    "")
                        printf '%s\n' $x
                esac
            else
                case $2 in
                    L)
                        printf "%-${_L}s\n" "$1" ;;
                    R)
                        printf "%${_L}s\n" "$1" ;;
                    C)
                        f_C $1 ;;
                    "")
                        printf '%s\n' $1
                esac
            fi
            ;;
    esac
}
f_fancy_box () {
    local s=''
    for s in ${text[@]}; do
        case $s in
            000) printf '%s\n' "<$(f_M -S = -)>" ;;
            ---) printf '%s\n' "| $(f_M -S - 70) |" ;;
            *) printf '%s\n' "<$(f_M $s L 72)>" ;;
        esac
    done
}

text=(
"000"
" "
"It is hobbies like this"
"that keep me from ever getting any sleep lol"
" "
"---"
" "
"But I think it is worth it"
" "
"000"
)

f_fancy_box

exit

#!/usr/bin/env bash

function alinhar() {

	if ! [[ $2 =~ '^[0-9]+$' ]]; then 
		ARG="2"
	else
		ARG=$2
	fi
	
    columns="$(tput cols)"
    declare -a text=()
    text+=($1)
    for((i=0;i<${#text[@]};i++)); do
        printf "%*s\n" $(( (${#text[i]} + columns) / $ARG)) "${text[i]}"
    done
	
}

text=(
'First'
'Second'
'Third'
)

alinhar ${text[@]} 8
#!/bin/zsh
# Formatting using printf
# 
# _L == total length for 'L' and 'R' options
# tl == total length for 'C' option
# _c == center for 'C' option ( tl / 2 )
# fill == filler character or space by default
# 
# Default lengths declared at top of function
# 
# usage $) f_M [string] [L,R,C] [character count]
#       -S option:
#       $) f_M -S [character] [total length (- for default 'space')]
#        -3rd var ($3) is needed for filler character ($2) or
#         else ($2) is total length
f_M () {
    tl=72
    _c=36
    _L=16
    f_numread () {
        printf $1 | sed ':a;s/\B[0-9]\{3\}\>/,&/;ta'
    }
    f_C () {
        local x=$(printf $1 | wc -c)
        local y=$(expr $_c - $(expr $x / 2))
        local z=$(expr $tl - $y)
        local space=' '
        printf "%${y}s%-${z}s\n" "$space" "$1"
    }
    case $1 in
        -S)
            fill=' '
            if [[ -n $2 ]]; then
                if [[ -n $3 ]]; then
                    fill="$2"
                    if [[ $3 =~ ^-?[0-9]+$ ]]; then
                        tl=$3
                    fi
                else
                    if [[ $2 =~ ^-?[0-9]+$ ]]; then
                        tl=$2
                    fi
                fi
            fi
            printf "${fill}%.0s" {1..$tl}
            ;;
        *)
            if [[ $3 =~ ^-?[0-9]+$ ]]; then
                tl=$3
                _L=$3
                _c=$(expr $tl / 2)
            fi
            if [[ $1 =~ ^-?[0-9]+$ ]]; then
                local x=$(f_numread $1)
                case $2 in
                    L)
                        printf "%-${_L}s\n" "$x" ;;
                    R)
                        printf "%${_L}s\n" "$x" ;;
                    C)
                        f_C $x ;;
                    "")
                        printf '%s\n' $x
                esac
            else
                case $2 in
                    L)
                        printf "%-${_L}s\n" "$1" ;;
                    R)
                        printf "%${_L}s\n" "$1" ;;
                    C)
                        f_C $1 ;;
                    "")
                        printf '%s\n' $1
                esac
            fi
            ;;
    esac
}
f_fancy_box () {
    local s=''
    for s in ${text[@]}; do
        case $s in
            000) printf '%b\n' "<$(f_M -S = -)>" ;;
            ---) printf '%b\n' "| $(f_M -S - 70) |" ;;
            *) printf '%b\n' "|$(f_M $s C)|" ;;
        esac
    done
}

text=(
"000"
" "
"It is hobbies like this"
"that keep me from ever"
"getting any sleep lol"
" "
"---"
" "
"But I think"
"it is worth it"
":P"
" "
"000"
)

f_fancy_box

exit

script(){

	FILE="/etc/mailips"
	
	echo -e "\033[32;94;5m
	#############################################################################
	- >                                 Ajuda                                 < -
	#############################################################################
		\033[m"
	echo -e "\033[32;94;2m
	_____________________________________________________________________________
	 [+] Trazendo a ajuda: includes/$1                       
	-----------------------------------------------------------------------------
		\033[m"
		
	echo "$(<$FILE )"
	
	echo -e "\033[31;91;2m
	_____________________________________________________________________________
	 [+] Concluido...
	 [+] Registrando O Resultado em logs/$1.txt                       
	-----------------------------------------------------------------------------
		\033[m"

}
script "/etc/mailips"