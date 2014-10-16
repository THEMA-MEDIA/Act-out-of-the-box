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
sleep 3

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

cpanm --sudo --installdeps --verbose $ACT_HOME

#
# create dir
#

cp -ai $ACT_HOME/eg/conf      $ACT_HOME
cp -ai $ACT_HOME/skel/actdocs $ACT_HOME

#
# $ACT_HOME/conf/act.ini
#

cat >$ACT_HOME/conf/act.ini <<'EOF'
[general]
conferences = test
cookie_name = act
searchlimit = 20
dir_photos  = photos
dir_ttc     = /home/act_developer/var
max_imgsize = 320x200

[database]
name        = act
dsn         = dbi:Pg:dbname=act_sample
user        = actuser_data
passwd      = use_Perl6;

test_dsn    = dbi:Pg:dbname=acttest
test_user   = actuser_data
test_passwd = use_Perl6;

[email]
sendmail    = /usr/sbin/sendmail
test        = 0
sender_address = act_tester@mongueurs.local

[wiki]
dbname      = act_sample_wiki
dbuser      = actuser_wiki
dbpass      = use_Perl6;

[payment]
open      = 0
invoices  = 0
type        = Fake
notify_bcc  = payments@mongueurs.local

[payment_type_Fake]
plugin = Fake

[flickr]
# see http://www.flickr.com/services/api/
apikey  = 0123456789ABCDEF0123456789ABCDEF
EOF

#
# $ACT_HOME/conf/local.ini
#

cat >$ACT_HOME/conf/local.ini <<'EOF'
[general]
default_language = en
languages = en
name_en = Perl Event Name
default_country = fr
full_uri = http://localhost:8080/
timezone = Europe/Paris

[talks]
durations = 20 40 120
start_date = 2014-08-06 18:00:00
end_date = 2014-08-07 18:00:00
submissions_open = 0
show_schedule = 0

[rooms]
rooms = roomA roomB
roomA_name_en = Room A
roomB_name_en = Room B

[database]
dump_file = act.dump
pg_dump = /usr/bin/pg_dump

[payment]
currency = EUR
type_fake_notify_bcc = vagrant+paymentbcc@localhost
products = registration

[product_registration]
prices = 1
name_en = Registration
[product_registration_price1]
amount = 25
EOF

#
# add VirtualHost to httpd.conf
#

cat >/tmp/act_developer_http.conf <<'EOF'
Listen 8080
<VirtualHost *:8080>
      ServerName   localhost:8080
      ServerAdmin  webmaster@example.com
      DocumentRoot /home/act_developer/act/wwwdocs
      Include      /home/act_developer/act/conf/httpd.conf
</VirtualHost>
EOF

sudo bash -c "cat /tmp/act_developer_http.conf >>/usr/local/apache/conf/httpd.conf"

rm /tmp/act_developer_http.conf 

#
# restart Apache httpd
#

sudo ACTHOME=/home/act_developer/act /usr/local/apache/bin/apachectl graceful

# cpanm --sudo --notest $ACT_HOME
cpanm --sudo --verbose $ACT_HOME

# DONE!!!!
