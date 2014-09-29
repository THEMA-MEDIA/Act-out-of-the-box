#!/bin/sh

clear
cat <<'BANNER'
                              _     _ 
 _   _ ___  ___ _ __ __ _  __| | __| |
| | | / __|/ _ \ '__/ _` |/ _` |/ _` |
| |_| \__ \  __/ | | (_| | (_| | (_| |
 \__,_|___/\___|_|  \__,_|\__,_|\__,_|
                                      

BANNER
sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1

export ACT_USER="$1"

if [ -z "$ACT_USER" ]; then
    echo "missing username!" >&2
    exit 1
else
    echo "creating account and home directorie for $ACT_USER"
fi

export LANG="en_US.UTF8"
export LC_ALL="en_US.UTF8"

#
# create group and user
#

sudo groupadd actusers
sudo useradd --comment "Act Developper" --groups actusers,admin --create-home $ACT_USER

#
# edit /etc/passwd
#

sudo sed -i "s/^$ACT_USER:.:/$ACT_USER:3yz4lb5O4qEW6:/" /etc/passwd

#
# copy profile
#

sudo -u $ACT_USER bash -c "cat ${INSTALLER}/etc/profile >> /home/${ACT_USER}/.profile"

#
# copy installers
#

sudo -u $ACT_USER mkdir /home/$ACT_USER/.out-of-the-box
sudo -u $ACT_USER cp -p ${INSTALLER}/bin/github-clone-and-make.sh /home/${ACT_USER}/.out-of-the-box/github-clone-and-make.sh
