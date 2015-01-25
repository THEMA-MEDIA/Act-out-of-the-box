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
# Done!, now restart the PostgreSQL server
#

sudo service postgresql-8.4 reload

#
# create a Act Database user
#

sudo -u postgres createuser --superuser --createdb --createrole actuser_data
psql -h localhost -U postgres <<END
\x
ALTER USER actuser_data WITH PASSWORD 'md58b5a506eb50be08b4602152e79749da9';
END

sudo -u postgres createuser --superuser --createdb --createrole actuser_wiki
psql -h localhost -U postgres <<END
\x
ALTER USER actuser_wiki WITH PASSWORD 'md5d55c7e1c47b492e33a9adcaaf02d3f61';
END

#
# setup PostgreSQL for Act! as usual
#

sudo -u postgres createdb act           --encoding=UTF8
sudo -u postgres createdb acttest       --encoding=UTF8
sudo -u postgres createdb actwiki       --encoding=UTF8

psql -h localhost -U postgres act     < ${INSTALLER}/etc/dbinit
psql -h localhost -U postgres acttest < ${INSTALLER}/etc/dbinit

#
# setup Sample Databases
# they come up with some odd names
#

#####sudo -u postgres pg_restore -O -C -d template1 /vagrant/actdb
#####sudo -u postgres pg_restore -O -C -d template1 /vagrant/actwikidb
#####
#####psql -h localhost -U postgres <<END
#####\x
#####ALTER DATABASE actdev     RENAME TO act_sample;
#####ALTER DATABASE actdevwiki RENAME TO act_sample_wiki;
#####END

#####psql -h localhost -U postgres <<END
#####\x
#####GRANT ALL PRIVILEGES ON DATABASE act             TO actuser_data;
#####GRANT ALL PRIVILEGES ON DATABASE acttest         TO actuser_data;
#####GRANT ALL PRIVILEGES ON DATABASE actwiki         TO actuser_wiki;
#####GRANT ALL PRIVILEGES ON DATABASE act_sample      TO actuser_data;
#####GRANT ALL PRIVILEGES ON DATABASE act_sample_wiki TO actuser_wiki;
#####END

psql -h localhost -U postgres <<END
\x
GRANT ALL PRIVILEGES ON DATABASE act             TO actuser_data;
GRANT ALL PRIVILEGES ON DATABASE acttest         TO actuser_data;
GRANT ALL PRIVILEGES ON DATABASE actwiki         TO actuser_wiki;
END

#
# Setup or Upgrade the Wiki databases,  (This utility is installed by Wiki::Toolkit.)
#

 wiki-toolkit-setupdb --type postgres --name actwiki         --user actuser_wiki --pass xyzzy;
#wiki-toolkit-setupdb --type postgres --name act_sample_wiki --user actuser_wiki --pass xyzzy;
