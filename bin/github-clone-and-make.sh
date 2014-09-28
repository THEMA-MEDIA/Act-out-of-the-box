#/ bin/sh

clear
cat <<'BANNER'
       _ _          _                  
  __ _(_) |_    ___| | ___  _ __   ___ 
 / _` | | __|  / __| |/ _ \| '_ \ / _ \
| (_| | | |_  | (__| | (_) | | | |  __/
 \__, |_|\__|  \___|_|\___/|_| |_|\___|
 |___/                                 
                                       
BANNER
sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1; echo

#
# install the Act software from github...
#

# if [ -z "$ACTHOME" ]; then
#     echo ""                        >> ~/.profile
#     echo "export ACTHOME=~/act"    >> ~/.profile
#     echo ""                        >> ~/.profile
#     export ACTHOME=~/act
# fi

git clone https://github.com/Act-Voyager/Act.git $ACT_HOME

#
# cpanm is smart enough to handle the whole distribution at once
#
# just make sure that Module::Install has been installed
# just make sure that there is a valid Act config
#

# cpanm --sudo .
cpanm --sudo --installdeps $ACT_HOME
cpanm --sudo --notest $ACT_HOME


