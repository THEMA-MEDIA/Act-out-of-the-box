#!/bin/sh

clear
cat <<'BANNER'
                    _           _        _ _ 
 _ __  _ __ ___    (_)_ __  ___| |_ __ _| | |
| '_ \| '__/ _ \   | | '_ \/ __| __/ _` | | |
| |_) | | |  __/   | | | | \__ \ || (_| | | |
| .__/|_|  \___|___|_|_| |_|___/\__\__,_|_|_|
|_|           |_____|                        
                                             
BANNER
sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1

export LANG="en_US.UTF8"
export LC_ALL="en_US.UTF8"

#
# prepare apt-get and set-up a Perl develop environment, including cpanminus
#

sudo sed -i -e 's,http://[^ ]*,mirror://mirrors.ubuntu.com/mirrors.txt,' /etc/apt/sources.list
sudo apt-get update

# install developers essentials
sudo apt-get --assume-yes install vim build-essential libgdbm-dev libperl-dev libgmp3-dev libfreetype6-dev libgif-dev libjpeg62-dev libpng3-dev libtiff4-dev libpq-dev libt1-dev git-core

# use cpanminus to install from CPAN
wget --no-check-certificate http://cpanmin.us -O cpanm
chmod a+x cpanm
sudo mv cpanm /usr/local/bin


