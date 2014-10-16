clear
cat <<'BANNER'
 ____           _    __ _      
|  _ \ ___  ___| |_ / _(_)_  __
| |_) / _ \/ __| __| |_| \ \/ /
|  __/ (_) \__ \ |_|  _| |>  < 
|_|   \___/|___/\__|_| |_/_/\_\
                               

BANNER
sleep 3

export LANG="en_US.UTF8"
export LC_ALL="en_US.UTF8"


#
# setup postfix for mail
#

# make debian config choos the right options, so it won't wait for user input

echo "postfix postfix/mailname string "`hostname`".local"     | sudo debconf-set-selections
echo "postfix postfix/main_mailer_type string 'Local only'"   | sudo debconf-set-selections

sudo apt-get --assume-yes install postfix

# Postfix is now set up with a default configuration.
# - If you need to make changes, edit
#   /etc/postfix/main.cf (and others) as needed.
# - To view Postfix configuration values, see postconf(1).
# 
# After modifying main.cf, be sure to run '/etc/init.d/postfix reload'.

