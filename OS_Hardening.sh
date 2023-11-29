#!/bin/bash
#--------------------ASCII Font Values---------------
NC="\e[0m" #Reset/No Color modifications
BOLD="\e[1m" #Bold
UL="\e[4m" #Underline
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

if [ $UID -ne 0 ] #Check if the script is run as root
then
    echo -e "\n${R}[${W}!${R}] ${BR}${blink}Run the script as root${NC}"
    exit 1
fi

which apt &>> /dev/null #Check if apt is installed
if [ $? -eq 0 ]
then
    which figlet &>> /dev/null #Check if figlet is installed
    if [ $? -ne 0 ]
    then 
        sudo apt install figlet -y &>> /dev/null
    fi
fi
clear


echo -e "$W"; figlet -t Ubuntu OS Hardening; echo -e "$NC"
echo -e "\e[31;1m--- ${NC}This is a menu based automation script to harden Ubuntu Linux 22.04 LTS based on CIS Benchmarks v8 ${NC} \e[31;1m---${NC}"
echo -e "\t\t\e[31;1m:::::: \e[0;7mBy: Shrit Shah & Tarun Kalyani${NC} \e[31;1m::::::${NC}"

end()
{
    printf "\n${C}[${W}*${C}] ${W}Press ENTER key to continue...${NC}\n\n"; read
    clear
    exit 0 &>> /dev/null
}

#Section-1: Initial Setup
initial_setup() 
{
_1.1.2.1()
{
    fdisk -l | grep /dev/sd | awk '{print $2}' | cut -d: -f1
    printf "${C}[${W}+${C}] ${W}Enter the disk name to partition [e.g. /dev/sda]: ${NC}"
    read disk_name
    fdisk $disk_name
    printf "${C}[${W}+${C}] ${W}Enter the partition name [e.g. /dev/sda4]: ${NC}"
    read part_name
    mkfs.ext4 $part_name
    mount $part_name /tmp
}

while [ 0 ]
do
    echo -e "\v-----${BOLD}1. Initial Setup: IG-1 Controls${NC}-----"
    echo -e "\v\t${C}[${W}1${C}]  ${Y} \n"
    echo -e "\t${C}[${W}2${C}]  ${Y} \n"
    echo -e "\t${C}[${W}3${C}]  ${Y} \n"
    echo -e "\t${C}[${W}4${C}]  ${Y} \n"
    echo -e "\t${C}[${W}5${C}]  ${Y} \n"
    echo -e "\t${C}[${W}6${C}]  ${Y} \n"
    echo -e "\t${C}[${W}0${C}] ${Y}Exit${NC}\n"

    printf "${C}[${W}+${C}] Select section: ${NC}" 
    read menu_opt

    case $menu_opt in 
        1) 
            _1.1.2.1
            ;;
        2)  
            
            ;;
        3)  
            
            ;;
        4)  
            
            ;;
        5)  
            
            ;;
        6)  
            
            ;;
        0) 
            echo -e "${C}[${W}*${C}] ${R}Exiting to Main Menu...${NC}"
            break
            ;;
        *)
            echo -e "${R}[${W}!${R}] ${BR}${blink}Select valid option from the menu${NC}"
            ;;
    esac
done
break
}

#Section-2: Services
services()
{
    echo ""
}

#Section-3: Network Configuration
net_config()
{

}

#Section-4: Logging & Auditing
log_audit()
{

}

#Section-5: Access, Authentication & Authorization
AAA()
{

}

#Section-6: System Maintenance
sys_maint()
{

}

#Main Menu
while [ 0 ]
do
    echo -e "\v-----${BOLD}CIS Benchmarks Sections${NC}-----"
    echo -e "\v\t${C}[${W}1${C}] Initial Setup ${Y} \n"
    echo -e "\t${C}[${W}2${C}] Services ${Y} \n"
    echo -e "\t${C}[${W}3${C}] Network Configuration ${Y} \n"
    echo -e "\t${C}[${W}4${C}] Logging & Auditing ${Y} \n"
    echo -e "\t${C}[${W}5${C}] Access, Authentication & Authorization ${Y} \n"
    echo -e "\t${C}[${W}6${C}] System Maintenance ${Y} \n"
    echo -e "\t${C}[${W}0${C}] ${Y}Exit${NC}\n"

    printf "${C}[${W}+${C}] Select section: ${NC}" 
    read menu_opt

    case $menu_opt in 
        1) 
            initial_setup
            ;;
        2)  
            services
            ;;
        3)  
            net_config
            ;;
        4)  
            log_audit
            ;;
        5)  
            AAA
            ;;
        6)  
            sys_maint
            ;;
        0) 
            echo -e "${C}[${W}*${C}] ${R}Exiting...${NC}"
            end
            break
            ;;
        *)
            echo -e "${R}[${W}!${R}] ${BR}${blink}Select valid option from the menu${NC}"
            ;;
    esac
done

end