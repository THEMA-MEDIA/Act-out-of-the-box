#!/bin/sh

clear
cat <<'BANNER'
 ____           _                 ____   ___  _     
|  _ \ ___  ___| |_ __ _ _ __ ___/ ___| / _ \| |    
| |_) / _ \/ __| __/ _` | '__/ _ \___ \| | | | |    
|  __/ (_) \__ \ || (_| | | |  __/___) | |_| | |___ 
|_|   \___/|___/\__\__, |_|  \___|____/ \__\_\_____|
                   |___/                            
                                                    
BANNER
sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1

export LANG="en_US.UTF8"
export LC_ALL="en_US.UTF8"

#
# setup PostgrSQL
#

sudo apt-get --assume-yes install postgresql


