#!/usr/bin/env bash

read -r -d '' ENV_CONFIG << EOM
  Main Menu
  - Ajuda
EOM
describe "Testing"
createMenu "menuAjuda" "$ENV_CONFIG"
addMenuItem "menuAjuda" "Ajuda 1" ajuda1
addMenuItem "menuAjuda" "Ajuda 2" ajuda2


script(){

	#Script para detecção de sub-dominios e ips de hosts e e html parsing
	if [ "$1" == "" ]
	then
		echo -e "Sem dados"
	else
	
	if [ ! -d logs ] 
	then
		mkdir -p logs
	fi
	
	if [[ ! -e logs/$1.html ]]; then
		touch logs/$1.html
	else
		truncate -s 0 logs/$1.html
		touch logs/$1.html
	fi
	
	if [[ ! -e logs/$1.txt ]]; then
		touch logs/$1.txt
	else
		truncate -s 0 logs/$1.txt
		touch logs/$1.txt
	fi

	
	
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
		
			#wget -q $1 -O $1.html
			cp includes/$1.html logs/$1.html
			#php -f html2text/convert.php logs/$1.txt 
			#git clone https://github.com/soundasleep/html2text.git
			#php -f html2text/convert.php logs/ajuda1.txt 
			
all(){
if [[ ! -e mytxt.html ]]; then
		touch mytxt.html
	else
		truncate -s 0 mytxt.html
		touch mytxt.html
	fi
	
LCHSET=`echo $LANG|sed 's/^.*\.//'`
LCHSETTST=`iconv -l | grep $LCHSET//`
if [ "$LCHSETTST" == "" ]; then
LCHSET="iso-8859-1"
fi
cp includes/ajuda1.html mytxt.html
touch mytxt.html
sed -i 's/\&/\&amp;/g' mytxt.html
sed -i 's/</\&lt;/g' mytxt.html
sed -i 's/>/\&gt;/g' mytxt.html
sed -i '1s/^/\n/' mytxt.html
sed -i '1c<html>' mytxt.html
sed -i '1a<head>' mytxt.html
sed -i "2a<title>`head -n 1 $1`<\/title>" mytxt.html
sed -i '3a<meta name="Generator" content="SamuraiDesigner v0.2 by Kurashov A.K.">' mytxt.html
sed -i "4a<meta http-equiv=\"content-type\" content=\"text\/html; charset=$LCHSET\">" mytxt.html
sed -i '5a<\/head>' mytxt.html
sed -i '6a<body bgcolor="#ffffff" text="#000000">' mytxt.html
sed -i '7a<p>' mytxt.html
sed -i '$a<\/p>' mytxt.html
sed -i '$a<\/body>' mytxt.html
sed -i '$a<\/html>' mytxt.html
sed -i 's/^$/<\/p><p>/g' mytxt.html
#rm $1



truncate -s 0 aaa.txt
touch aaa.txt
cat > aaa.txt < $(php -f html2text/convert.php logs/$1.html)


# Call the function


#arguments=$(php -f html2text/convert.php logs/ajuda1.txt )
#source test.sh $arguments
}





php -f config/convert.php includes/ajuda1.html> /dev/null 2>&1 &
php -f html2text/convert.php logs/$1.html
			
			grep "href" logs/$1.html | cut -d "/" -f 3 | grep "\." | cut -d '"' -f1 | egrep -v "<l|png|jpg|ico|js|css|mp3|mp4" | sort -u > logs/$1.txt2
			sleep 1.00
			
		lynx logs/$1.html
			echo -e "\033[31;91;2m
	_____________________________________________________________________________
	 [+] Concluido...
	 [+] Registrando O Resultado em logs/$1.txt                       
	-----------------------------------------------------------------------------
		\033[m"
			echo -e "\033[31;94;2m
	_____________________________________________________________________________
	 [+] Identificando o ip                                                     
	-----------------------------------------------------------------------------
		\033[m"
	fi

	for hst in $(cat logs/$1.txt);
	do
		host $hst | grep "has address" |  sed 's/has address/54.38.191.102/' | column -t;
		# sed 's/has address/\tIP:/' | column -t -s ' ';
		# sed 's/has address/<< IP >>/' | column -t;
	done
}

function ajuda1() {

	read -e -p "Ver ajuda:" -i "ajuda1" vip
	script $vip
	
	tput init
	pause

}
function ajuda2() {
	read -e -p "Ver ajuda:" -i "ajuda2" vip
	script $vip
	pause
}


