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
sleep 3

export LANG="en_US.UTF8"
export LC_ALL="en_US.UTF8"

#
# install PostgrSQL
#

sudo apt-get --assume-yes install postgresql

#
# edit settings for access to PostgreSQL
#

# /etc/postgresql/8.4/main/pg_hba.conf
# local   all         all                               trust
# host    all         all         127.0.0.1/32          trust
# host    all         all         ::1/128               trust
sudo sed -i 's/^\(local\|host\)\( * all * all .* \)\([A-Za-z0-9]*\)$/\1\2trust/' /etc/postgresql/8.4/main/pg_hba.conf

#
# Done!, now restart
#

sudo service postgresql-8.4 reload

#
# setup PostgreSQL for Act!
#

sudo -u postgres createdb act           --encoding=UTF8
sudo -u postgres createdb acttest       --encoding=UTF8

psql -h localhost -U postgres act     < ${INSTALLER}/etc/dbinit
psql -h localhost -U postgres acttest < ${INSTALLER}/etc/dbinit

# END
