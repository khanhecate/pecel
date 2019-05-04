#!/bin/bash
#Identity
# NAME="Pecel (file Compressing)"
# VERSION="0.1"
# AUTHOR="Hecate"
# EMAIL="khanafi.mrsd@gmail.com"
# SOURCE="https://linux.101hacks.com/archive-compression/advanced-compression-using-zip-command/"
# POWERED_BY="zip"
#color
RED="\033[1;31m" # light red
GREEN="\033[1;32m" # light green 
YELLOW="\033[1;33m" # light yellow
BLUE="\033[1;34m" # light blue
WHITE="\033[1;37m" # light white
CLEAR="\033[0m" # default color
MSG_FAIL=$(echo -e ${RED}FAIL${CLEAR})
MSG_DONE=$(echo -e ${GREEN}DONE${CLEAR})


#Function
MSG_CAUTION() {
whiptail --title "[ $TITLE ]" --msgbox "$MSGBOX" 10 60
}
MSG_INPUT() {
input=$(whiptail --title "[ $TITLE ]" --no-button "Exit" --inputbox "$MSGBOX" 10 60 3>&1 1>&2 2>&3) 
inputquit=$?
if ! [ $inputquit = 0 ]; then
    exit
fi
}

# first aid kit for me when i forgot what i wrote
#
# use variable TITLE for show name title window whiptail
# use variable MSGBOX for show text in window whiptail
# use variable PERINTAH for run command after MSG_YESNO
#

#checking dependency
#checking zip package
C_ZIP="command -v zip"
if [[ -z $C_ZIP ]]; then
	TITLE="Alert!"
	MSGBOX="Please install package zip" && MSG_CAUTION
fi
#welcome
TITLE="WELCOME"
MSGBOX="Welcome to Pecel shell sciprt
Pecel is shell sciprt for Compressing folder if you lazy to type Compressing command " && MSG_CAUTION
TITLE="OPTION"
MSGBOX="Pecel have 3 option :
- fast  -> not reduce file size but it fast
- high  -> reduce a few size file ,speed ? normal
- ultra -> max quiality of Compressing , speed ? slow" && MSG_CAUTION
#input folder
while true
do
	while true
	do
	clear
	menu=$(whiptail --title "[ Menu ]" --cancel-button "exit" --menu "Choose menu below : " 15 60 5 \
	"FAST" "Perform little compression. But, will be very fast" \
	"NORMAL" "Default level of Compression" \
	"HIGH" "Maximum compression" 3>&1 1>&2 2>&3)
	#check array data
	quitmenu=$?

	if ! [[ -z $menu ]]; then
		case $menu in
			 FAST)C_TYPE="-1"
				;;
			 NORMAL)C_TYPE="-6"
				;;
			 HIGH)C_TYPE="-9"
				;;
		esac
		break
	else exit
	fi
	done

	#C_TYPE is type compressing
	while true
	do
	TITLE="TARGET"
	MSGBOX="input folder target location : (don't forget to put slash (/) in back)" && MSG_INPUT
	D_FOLDER="$input"
	#checking user input
	C_INPUT=$(printf $D_FOLDER 2>/dev/null | tail -c 1)
	if ! echo $C_INPUT | grep -q "/";then
		#source https://unix.stackexchange.com/questions/163481/a-command-to-print-only-last-3-characters-of-a-string
		TITLE="Alert !"
		MSGBOX="please input slash (/) in back, example /home/khan/app/ (correct) don't /home/khan/app (wrong)" && MSG_CAUTION
	else break
	fi
	done	
	#configuring input (for me whet forgot)
	#$FOLDER is data user input
	#
	while true
	do
	TITLE="Name"
	MSGBOX="Input name file :" && MSG_INPUT
	NAMA=$input
	#check name
	if [[ -z $NAMA ]]; then
		TITLE="Alert"
		MSGBOX="name can't be empty !" && MSG_CAUTION
	else break
	fi
	done
	TITLE="Alert !"
	MSGBOX="this is correct ? :
	name              = $NAMA.zip
	folder            = $D_FOLDER
	Compression level = $menu "
	if whiptail --title "[ $TITLE ]" --yesno "$MSGBOX" 20 60 3>&1 1>&2 2>&3 ; then
		break
	fi
done
#checking all prior compressing ..
if cd $D_FOLDER 2>/dev/null ;then
	cd - 1>/dev/null
	echo "Testing folder $D_FOLDER ..." ; echo -e $MSG_DONE
else echo "Testing folder $D_FOLDER ..." ; echo -e $MSG_FAIL
	TITLE="Alert !"
	MSGBOX="folder can't open so Compression was cancelled 
please make sure you didn't wrong type then exit" && MSG_CAUTION
	exit
fi
echo -e "Starting Compression ....  [ ${YELLOW}START${CLEAR} ]"
zip $C_TYPE $NAMA.zip $D_FOLDER* && echo -e "Compression [ ${GREEN}DONE${CLEAR} ]"
TITLE="Thank"
MSGBOX="Thank for using my tools 
Terimakasih Telah menggunakan tools saya bujank :D" && MSG_CAUTION