#! /bin/bash

echo
echo " ******************** lswifi v1.0.0 ********************"
echo
dev=$1
if [[ "$dev" == "" ]]; then
    #echo " Using: lswifi [wifi interface name]"
    echo " Searching network interfaces for wireless hardware.."
    dev=$( iw dev | awk -F 'Interface ' '{print $2}' | grep -m 1 '[a-zA-Z1-9_-:.]')
    if [[ "$dev" == "" ]]; then
        echo " Command failed: Can\`t find any interfaces for wireless hardware."
        echo " Try using: lswifi [wifi interface name]"
        echo " or try sudo."
        exit
    else
        echo " Interface: $dev"
    fi
fi

echo " Scanning SSID.."
echo

output=$( { iw dev $dev scan | awk -F'SSID:' '{print $2}' | grep '[a-zA-Z1-9_-:.]' ; } 2>&1 )

if [[ "$output" == "" ]]; then
    echo " No WI-FI in range."
else
    errors=$(echo $output | grep "command failed")
    if [[ "$errors" != "" ]]; then
        echo " $output"
    else
        echo "$output"
    fi
fi

echo
