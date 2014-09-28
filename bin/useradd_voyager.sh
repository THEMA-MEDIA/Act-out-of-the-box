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

export ACT_USER="voyager"

export LANG="en_US.UTF8"
export LC_ALL="en_US.UTF8"

#
# create group and user
#

sudo groupadd actusers
sudo useradd --comment "Act Developper" --groups actusers,admin --create-home $ACT_USER

#
# copy pub keys
#

sudo -u $ACT_USER mkdir /home/$ACT_USER/.ssh
sudo -u $ACT_USER touch /home/$ACT_USER/.ssh/authorized_keys
sudo -u $ACT_USER chmod 600 /home/$ACT_USER/.ssh/authorized_keys
sudo -u $ACT_USER bash -c "cat ${INSTALLER}/etc/${ACT_USER}.pub >> /home/${ACT_USER}/.ssh/authorized_keys"

# ask me how to generate the private key, but ofcourse you can create your own pair

#
# copy profile
#

sudo -u $ACT_USER bash -c "cat ${INSTALLER}/etc/profile >> /home/${ACT_USER}/.profile"

#
# copy installers
#

sudo -u $ACT_USER mkdir /home/$ACT_USER/.out-of-the-box
sudo -u $ACT_USER cp -p ${INSTALLER}/bin/github-clone-and-make.sh /home/${ACT_USER}/.out-of-the-box/github-clone-and-make.sh
