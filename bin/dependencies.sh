#! /bin/sh

clear
cat <<'BANNER'
     _                          _                 _           
  __| | ___ _ __  ___ _ __   __| | ___ _ __   ___(_) ___  ___ 
 / _` |/ _ \ '_ \/ _ \ '_ \ / _` |/ _ \ '_ \ / __| |/ _ \/ __|
| (_| |  __/ |_) | __/ | | | (_| |  __/ | | | (__| |  __/\__ \
 \__,_|\___| .__/\___|_| |_|\__,_|\___|_| |_|\___|_|\___||___/
           |_|                                                
                                                              
BANNER
sleep 3

export LANG="en_US.UTF8"
export LC_ALL="en_US.UTF8"

#
# pre_install Act dependencies
#

cp ${INSTALLER}/etc/cpanfile .
cpanm --verbose --sudo --installdeps .
