#! /bin/bash


# colors for output
red='\033[0;31m'
green='\033[0;32m'
light='\033[1;31m'
yellow='\033[1;33m'
NC='\033[0m'

echo
echo " ******************** lswifi v1.0.0 ********************"
echo

##############################################################################################
#                                 Getting Interfaces Names                                   #
##############################################################################################

dev=$1
if [[ "$dev" == "" ]]; then
    #echo " Using: lswifi [wifi interface name]"
    echo " Searching network interfaces for wireless hardware.."
    dev=$( iw dev | awk -F 'Interface ' '{print $2}' | grep -m 1 '[a-zA-Z1-9_-:.]')
    if [[ "$dev" == "" ]]; then
        printf " ${light}Command failed: Can\`t find any interfaces for wireless hardware.${NC}\n"
        echo " Try using: lswifi [wifi interface name]"
        echo " or try sudo."
        exit
    else
        printf " Interface: ${yellow}$dev${NC}\n"
    fi
fi

##############################################################################################
#                                         Main Chunk                                         #
##############################################################################################

echo " Scanning SSID.."
echo

output=$( { iw dev $dev scan | awk -F'SSID:' '{print $2}' | grep '[a-zA-Z1-9_-:.]' ; } 2>&1 )

if [[ "$output" == "" ]]; then
    echo " No WI-FI in range."
else
    errors=$(echo $output | grep "command failed")
    if [[ "$errors" != "" ]]; then
        printf " ${light}$output${NC}\n"
    else
        echo "$output"
    fi
fi

echo
