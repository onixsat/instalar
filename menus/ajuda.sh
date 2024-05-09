#!/bin/bash

function globais() {

	readonly server_name=$(hostname)
	readonly green='\e[32m'
	readonly blue='\e[34m'
	readonly clear='\e[0m'
	
	ColorGreen(){
		echo -ne $green$1$clear
	}
	ColorBlue(){
		echo -ne $blue$1$clear
	}
	


	if [ ! -d ajuda ] 
	then
		mkdir -p ajuda
	fi
	
	if [[ ! -e /ajuda/ajuda1.html ]]; then
		#truncate -s 0 ajuda/ajuda1.html
		touch /ajuda/ajuda1.html
		cat > ajuda/ajuda1.html << "includes/ajuda1.html"
	fi
	if [[ ! -e /ajuda/ajuda2.html ]]; then
		#truncate -s 0 ajuda/ajuda1.html
		touch /ajuda/ajuda2.html
		cat > ajuda/ajuda2.html <<- "EOF"
		ajuda 2
		EOF
	fi

}
globais

function script(){
	#Script para detecção de sub-dominios e ips de hosts e e html parsing
	if [ "$1" == "" ]
	then
		echo -e "Sem dados"
	else
		echo -e "\033[32;94;5m
	#############################################################################
	- >                                 Ajuda                                 < -
	#############################################################################
		\033[m"
		echo -e "\033[32;94;2m
	_____________________________________________________________________________
	 [+] Trazendo a ajuda: $1                       
	-----------------------------------------------------------------------------
		\033[m"
		
			#wget -q $1 -O $1.html
			cp ajuda/$1.html $1.html
			grep "href" $1.html | cut -d "/" -f 3 | grep "\." | cut -d '"' -f1 | egrep -v "<l|png|jpg|ico|js|css|mp3|mp4" |sort -u |sed "s/'/ /" > $1.txt
			sleep 1.00
			
		lynx $1.html
			echo -e "\033[31;91;2m
	_____________________________________________________________________________
	 [+] Concluido...
	 [+] Registrando O Resultado em $1.txt                       
	-----------------------------------------------------------------------------
		\033[m"
			echo -e "\033[31;94;2m
	_____________________________________________________________________________
	 [+] Identificando o ip                                                     
	-----------------------------------------------------------------------------
		\033[m"
	fi

	for hst in $(cat $1.txt);
	do
		host $hst | grep "has address" |sed 's/has address/\tIP:/' | column -t -s ' ';
		# sed 's/has address/<< IP >>/' | column -t;
	done

}

function ajuda1() {
	read -e -p "Ver ajuda:" -i "ajuda1" vip
	script $vip
}
function ajuda2() {
	read -e -p "Ver ajuda:" -i "ajuda2" vip
	script $vip
}


press_enter() {
  echo ""
  echo -n "	Press Enter to continue "
  read
  clear
}

incorrect_selection() {
  echo "Incorrect selection! Try again."
}

until [ "$selection" = "0" ]; do
  clear
  echo ""
  echo "    	1  -  Menu Ajuda 1"
  echo "    	2  -  Menu Ajuda 2"
  echo "    	3  -  Menu Script"
  echo "    	0  -  Exit"
  echo ""
  echo -n "  Enter selection: "
  read selection
  echo ""
  case $selection in
    1 ) clear ; ajuda1 ; press_enter ;;
    2 ) clear ; ajuda2 ; press_enter ;;
	3 ) clear ; script2 "54.38.191.102" ; press_enter ;;
    0 ) clear ; exit ;;
    * ) clear ; incorrect_selection ; press_enter ;;
  esac
done
