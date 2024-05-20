#!/bin/bash
HEADER_MSG="BASH TOOLKIT"

createMenu "mainMenu" "Main Menu"
addMenuItem "mainMenu" "Quit" l8r
addMenuItem "mainMenu" "Password" showPassword
addMenuItem "mainMenu" "Update" showUpdate
addMenuItem "mainMenu" "Configuracao" loadMenu "menuConfig"
addMenuItem "mainMenu" "Instalar" loadMenu "menuInstall"
addMenuItem "mainMenu" "Ajuda" loadMenu "menuAjuda"
addMenuItem "mainMenu" "Verificar" loadMenu "menuVerificar"

source menus/config.sh
source menus/instalar.sh
source menus/ajuda.sh
source menus/verificar.sh

function globais() {

	readonly sshport="222"
	readonly version="1.0.0"
	readonly WHITE="$(tput setaf 7)"
	readonly CYAN="$(tput setaf 6)"
	readonly MAGENTA="$(tput setaf 5)"
	readonly YELLOW="$(tput setaf 3)"
	readonly GREEN="$(tput setaf 2)"
	readonly BLUE="$(tput setaf 4)"
	readonly RED="$(tput setaf 1)"
	readonly NORMAL="$(tput sgr0)"
	
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
	
	if [[ ! -e ajuda/ajuda1.html ]]; then
		truncate -s 0 ajuda/ajuda1.html
		touch ajuda/ajuda1.html
		cat > ajuda/ajuda1.html << "includes/ajuda1.html"
	fi
	if [[ ! -e ajuda/ajuda2.html ]]; then
		truncate -s 0 ajuda/ajuda1.html
		touch ajuda/ajuda2.html
		cat > ajuda/ajuda2.html <<- "EOF"
		ajuda 2
		EOF
	fi
	
	
	

}
function banner(){

	ARG1=${1:-0}
    sleep "$ARG1"
	clear
    echo -n "${GREEN}                                                         "
    echo -e "${BLUE}                       Version ${version}${YELLOW} OnixSat"
    echo -n "${NORMAL}"
	
}

function showPassword(){

	globais
	banner
	source menus/password.sh
	tput init
	pause
	
}

function showUpdate(){

	globais
	banner
	source menus/update.sh
	tput init
	pause
	
}

function extra(){
	#Bloquear ou desbloquear file: chattr +i 
	confirmar(){
	  echo "${WHITE}Press ENTER to continue"
	  read -n 1 confirm
	  if [ ! "$confirm" = "" ]; then
		confirm
		#exit
	  fi
	}
	configureMySQL(){
		if ! grep -q 'local-infile=0' /etc/yum.conf ; then
			echo 'local-infile=0' >> /etc/my.cnf
			/scripts/restartsrv_mysql
		fi
	}
	configurePHP(){
		# Example ea-phpXX file location
		# /opt/cpanel/ea-php72/root/etc/php.ini
		EA_PHP_FILES=( /opt/cpanel/ea-php*/root/etc/php.ini )
		# Replace is default /usr/local/lib/php.ini files
		sed -i -e 's/enable_dl = On/enable_dl = Off/g' /usr/local/lib/php.ini
		sed -i -e 's/disable_functions =.*/disable_functions = show_source, system, shell_exec, passthru, exec, phpinfo, popen, proc_open, allow_url_fopen, ini_set/g' /usr/local/lib/php.ini
		# Replace in any /opt/cpanel/ea-phpXX/root/etc/php.ini files
		sed -i -e 's/enable_dl = On/enable_dl = Off/g' "${EA_PHP_FILES[@]}"
		sed -i -e 's/disable_functions =.*/disable_functions = show_source, system, shell_exec, passthru, exec, phpinfo, popen, proc_open, allow_url_fopen, ini_set/g' "${EA_PHP_FILES[@]}"
	}
	fun1(){
		function check(){
			if [ "$1" = "true" ];
			then
				true
				return
			else
				false
				return
			fi
		}
		if check "true"; then
			echo yes
		fi
		check "true"
	}
	fun2(){
		MY="1"
		GREEN="$(tput setaf 4)"
		globaisx() {
			readonly GREEN="$(tput setaf 2)"
			readonly MY=0
		}
		globaisx
		#MY="2"
		#declare -r MY=3
		echo $MY
		echo "$GREEN OnixSat"
		echo -n "${GREEN}OnixSat"
	}
	fun3(){
		funcxx() {
			printf -v "$var" '5'
		}
		var=var_name
		funcxx
		echo "$var_name"
	}
	
}