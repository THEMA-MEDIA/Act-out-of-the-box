clear
cat <<'BANNER'
 ____           _    __ _      
|  _ \ ___  ___| |_ / _(_)_  __
| |_) / _ \/ __| __| |_| \ \/ /
|  __/ (_) \__ \ |_|  _| |>  < 
|_|   \___/|___/\__|_| |_/_/\_\
                               

BANNER
sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1

export LANG="en_US.UTF8"
export LC_ALL="en_US.UTF8"


#
# setup postfix for mail
#

# select local only
sudo apt-get --assume-yes install postfix

