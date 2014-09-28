#! /bin/sh
#                      _           _        _ _ 
#   _ __  _ __ ___    (_)_ __  ___| |_ __ _| | |
#  | '_ \| '__/ _ \   | | '_ \/ __| __/ _` | | |
#  | |_) | | |  __/   | | | | \__ \ || (_| | | |
#  | .__/|_|  \___|___|_|_| |_|___/\__\__,_|_|_|
#  |_|           |_____|                        
#  

clear
if [ -f ${INSTALLER}/etc/banners/pre_install.txt ]; then
    cat ${INSTALLER}/etc/banners/pre_install.txt
else
    echo "Starting: pre installing Act dependencies..."
fi
sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1

export LANG="en_US.UTF8"
export LC_ALL="en_US.UTF8"

#
# pre_install Act dependencies
#

cp ${INSTALLER}/etc/cpanfile .
cpanm --verbose --sudo --installdeps .
