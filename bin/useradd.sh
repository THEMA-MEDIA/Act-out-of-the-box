#!/bin/sh

clear
cat <<'BANNER'
                              _     _ 
 _   _ ___  ___ _ __ __ _  __| | __| |
| | | / __|/ _ \ '__/ _` |/ _` |/ _` |
| |_| \__ \  __/ | | (_| | (_| | (_| |
 \__,_|___/\___|_|  \__,_|\__,_|\__,_|
                                      

BANNER
sleep 3

export NEW_USER="$1"

if [ -z "$NEW_USER" ]; then
    echo "missing username!" >&2
    exit 1
else
    echo "creating account and home directorie for $NEW_USER"
fi

export LANG="en_US.UTF8"
export LC_ALL="en_US.UTF8"

#
# create group and user
#

sudo groupadd actusers
sudo useradd --comment "Act Developer" --groups actusers,admin --create-home $NEW_USER

#
# edit /etc/passwd
#

sudo sed -i "s/^$NEW_USER:.:/$NEW_USER:3yz4lb5O4qEW6:/" /etc/passwd

#
# copy profile
#

sudo -u $NEW_USER bash -c "cat ${INSTALLER}/etc/profile >> /home/${NEW_USER}/.profile"

#
# copy unsafe Vagrant keys to the new user, so one can use 'vagrant ssh'
#

sudo cp -r ~/.ssh /home/$NEW_USER/
sudo chown $NEW_USER:$NEW_USER /home/$NEW_USER/.ssh
sudo chown $NEW_USER:$NEW_USER /home/$NEW_USER/.ssh/authorized_keys

