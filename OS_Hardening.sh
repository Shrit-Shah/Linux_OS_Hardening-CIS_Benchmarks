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
        echo -e "\n${C}[${W}*${C}] ${W}Installing figlet...${NC}"
        sudo apt install figlet -y &>> /dev/null
    fi
fi
clear


echo -e "$W"; figlet -t Ubuntu OS Hardening; echo -e "$NC"
echo -e "\t\t\e[31;1m:::::: \e[0;7mBy: Shrit Shah & Tarun Kalyani${NC} \e[31;1m::::::${NC}"
echo -e "\e[31;1m--- ${NC}This is a menu based automation script to harden Ubuntu Linux 22.04 LTS based on CIS Benchmarks v8 ${NC} \e[31;1m---${NC}"

end()
{
    echo -e "\n${C}[${W}*${C}] ${W}Press ENTER key to continue...${NC}\n\n"; read
    clear
    exit 0 &>> /dev/null
}

#Section-1: Initial Setup
initial_setup() 
{
partition()
{
    if [ -d $1 ]
    then
        echo -e "\n${C}[${W}*${C}] Creating Partition for $1... \n${NC}"
        echo -e "${C}[${W}*${C}] Available Disks: ${NC}"
        fdisk -l | grep "Disk /dev/sd"
        printf "${C}[${W}+${C}] ${W}Enter the disk name to partition [/dev/sdX]: ${NC}"
        read disk_name
        echo -e "n\np\n\n\n+5G\n\nw" | fdisk $disk_name &>> /dev/null
        fdisk -l | grep $disk_name
        if [ $? -ne 0 ]
        then
            echo -e "${R}[${W}!${R}] ${BR}${blink}Error Creating Partition${NC}"
        else
            echo -e "${G}[${W}^${G}] ${BG}Partition Created Successfully${NC}"
        fi
        printf "${C}[${W}+${C}] ${W}Enter the partition name [e.g. /dev/sdb1]: ${NC}"
        read part_name
        mkfs.ext4 $part_name &>> /dev/null
        echo "$part_name $1 ext4 defaults,${2},${3},${4} 0 2 " >> /etc/fstab
        mount $part_name $1 &>> /dev/null
        if [ $? -ne 0 ]
        then
            echo -e "${R}[${W}!${R}] ${BR}${blink}Error Mounting Partition${NC}"
        else
                mount_part=$(df -hT $part_name)
            echo -e "${G}[${W}^${G}] ${BG}Partition Mounted Successfully:${NC}\n${mount_part}"
        fi 
    fi
}

while [ 0 ]
do
    echo -e "\v----------${BOLD} 1. Initial Setup Configuration${NC}----------"
    echo -e "\v\t${C}[${W}1${C}] Seperate Partitions:/tmp, /var, /var/tmp, /var/log, /var/log/audit & /home${Y}"
    echo -e "\t${C}[${W}2${C}] Disable USB and automounting ${Y}"
    echo -e "\t${C}[${W}3${C}] Software Patches & Upgrades ${Y}"
    echo -e "\t${C}[${W}4${C}] Unattended Auto Download and Installation of latest stable packages${Y}"
    echo -e "\t${C}[${W}0${C}] ${Y}Back to Main Menu${NC}\n"

    printf "${C}[${W}+${C}] Select section: ${NC}" 
    read menu_opt

    case $menu_opt in 
        1) 
            partition /tmp nodev noexec nosuid
            partition /var nodev nosuid
            partition /var/tmp nodev noexec nosuid
            partition /var/log nodev noexec nosuid
            partition /var/log/audit nodev noexec nosuid
            partition /home nodev nosuid
            ;;
        2)  
            echo -e "${C}[${W}*${C}] ${W}Disabling USB and automounting...${NC}"
            systemctl disable --now udisks2.service &>> /dev/null
            if [ $? -ne 0 ]
            then
                echo -e "${R}[${W}!${R}] ${BR}${blink}Error Stopping udisks.service${NC}"
            else
                systemctl mask udisks2.service &>> /dev/null
                echo -e "${G}[${W}^${G}] ${BG}Auto Mounting Disabled${NC}"
            fi
            echo 'blacklist uas' >> /etc/modprobe.d/blacklist.conf
            echo 'blacklist usb_storage' >> /etc/modprobe.d/blacklist.conf
            if [ $? -ne 0 ]
            then
                echo -e "${R}[${W}!${R}] ${BR}${blink}Error Disabling USB${NC}"
            else
                echo -e "${G}[${W}^${G}] ${BG}USB Disabled: Will be enforced on next reboot.${NC}"
            fi
            ;;
        3)  
            echo -e "${C}[${W}*${C}] ${W}Updating Packages...${NC}"
            apt update && apt upgrade -y
            if [ $? -ne 0 ]
            then
                echo -e "${R}[${W}!${R}] ${BR}${blink}Error Updating Packages${NC}"
            else
                echo -e "${G}[${W}^${G}] ${BG}Packages Updated Successfully${NC}"
            fi
            ;;
        4)  
            echo -e "${C}[${W}*${C}] ${W}Configuring Unattended Upgrades...${NC}"
            apt install unattended-upgrades -y &>> /dev/null
            if [ $? -ne 0 ]
            then
                echo -e "${R}[${W}!${R}] ${BR}${blink}Error Installing unattended-upgrades${NC}"
            else
                echo -e "${G}[${W}^${G}] ${BG}unattended-upgrades Installed Successfully${NC}"
                dpkg-reconfigure -plow unattended-upgrades &>> /dev/null
                if [ $? -ne 0 ]
                then
                    echo -e "${R}[${W}!${R}] ${BR}${blink}Error Configuring unattended-upgrades${NC}"
                else
                    echo -e "${G}[${W}^${G}] ${BG}unattended-upgrades Configured Successfully${NC}"
                fi
            fi
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
}

Section-2: Services
services()
{
    echo -e "${Y}[${W}-${Y}] ${BW}So far the Script is implmented for CIS Controls in IG1. And the ${BOLD}2. Services${NC}${BW} section of the Benchmarks is not a part of IG-1 ${NC}"
}

#Section-3: Network Configuration
#net_config()
#{

#}

#Section-4: Logging & Auditing
#log_audit()
#{

#}

#Section-5: Access, Authentication & Authorization
#AAA()
#{

#}

#Section-6: System Maintenance
#sys_maint()
#{

#}

#Main Menu
while [ 0 ]
do
    echo -e "\v----------${BOLD}CIS Benchmarks Sections${NC}----------"
    echo -e "\v\t${C}[${W}1${C}] Initial Setup ${Y}"
    echo -e "\t${C}[${W}2${C}] Services ${Y}"
    echo -e "\t${C}[${W}3${C}] Network Configuration ${Y}"
    echo -e "\t${C}[${W}4${C}] Logging & Auditing ${Y}"
    echo -e "\t${C}[${W}5${C}] Access, Authentication & Authorization ${Y}"
    echo -e "\t${C}[${W}6${C}] System Maintenance ${Y}"
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