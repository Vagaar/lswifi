#! /bin/bash

# main data for instalation
path="/usr/bin/"
source_name=lswifi.sh
name="lswifi"
perm="755"

# colors for output
red='\033[0;31m'
green='\033[0;32m'
light='\033[1;31m'
yellow='\033[1;33m'
NC='\033[0m'

#############################################
#              Main Chunk                   #
#############################################

printf " ${green}Installing lswifi tool.${NC}\n"
printf " Name of executable:.... ${yellow}$name${NC}\n"
printf " Path to install:....... ${yellow}$path${NC}\n"
echo " Copying filess.."

output=$( { cp $source_name $path$name ; } 2>&1 )
if [[ "$output" != "" ]]; then
    printf " ${red}Installation failed!${NC}\n"
    printf " ${light}$output${NC}\n"
    exit
fi

echo " Setting up permissions.."

output=$( { chmod $perm $path$name ; } 2>&1 )

if [[ "$output" != "" ]]; then
    printf " ${red}Installation failed!${NC}\n"
    printf " ${light}$output${NC}\n"
    exit
fi

echo " Ending installation.."
printf " ${green}Successful.${NC}\n"