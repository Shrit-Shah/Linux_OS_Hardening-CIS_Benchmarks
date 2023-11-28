#!/bin/bash

which apt &>> /dev/null
if [ $? -eq 0 ]
then
    which figlet &>> /dev/null
    if [ $? -ne 0 ]
    then 
        sudo apt install figlet -y &>> /dev/null
    fi
fi
clear
#--------------------ASCII Font Values---------------
NC="\e[0m" #Reset/No Color modifications
#Font Colour with BOLD
R="\e[1;31m" #RED
G="\e[1;32m" #Green
Y="\e[1;33m" #Yellow/Brown
B="\e[1;34m" #Blue
C="\e[1;36m" #Cyan
W="\e[1;37m" #White/Gray
#Background colour
BR="\e[0;1;41m" #RED
BG="\e[0;1;42m" #Green
BY="\e[0;1;43m" #Yellow/Brown
BC="\e[0;1;46m" #Cyan
BW="\e[0;1;47m" #White/Gray

blink="\e[5m" #Blinking Text
#---------------------------------------------------------------

echo -e "$W"; figlet -t Ubuntu OS Hardening; echo -e "$NC"
echo -e "\e[31;1m--- ${NC}This is a menu based automation script to harden Ubuntu Linux 22.04 LTS based on CIS Benchmarks v8 ${NC} \e[31;1m---${NC}"
echo -e "\t\t\e[31;1m:::::: \e[0;7mBy: Shrit Shah & Tarun Kalyani${NC} \e[31;1m::::::${NC}"

