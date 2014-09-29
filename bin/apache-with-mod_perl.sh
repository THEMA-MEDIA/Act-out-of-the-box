#!/bin/sh

clear
cat <<'BANNER'
                        _                                    _ 
  __ _ _ __   __ _  ___| |__   ___     _     _ __   ___ _ __| |
 / _` | '_ \ / _` |/ __| '_ \ / _ \  _| |_  | '_ \ / _ \ '__| |
| (_| | |_) | (_| | (__| | | |  __/ |_   _| | |_) |  __/ |  | |
 \__,_| .__/ \__,_|\___|_| |_|\___|   |_|   | .__/ \___|_|  |_|
      |_|                                   |_|                
                                                               
BANNER
sleep 3

export LANG="en_US.UTF8"
export LC_ALL="en_US.UTF8"

#
# Apache with Mod_Perl
#

mkdir ~/apache-with-mod_perl
cd ~/apache-with-mod_perl

wget https://archive.apache.org/dist/httpd/apache_1.3.42.tar.gz
wget https://www.apache.org/dist/perl/mod_perl-1.31.tar.gz
wget https://archive.apache.org/dist/httpd/libapreq/libapreq-1.34.tar.gz

tar xf apache_1.3.42.tar.gz
tar xf mod_perl-1.31.tar.gz
tar xf libapreq-1.34.tar.gz

patch -p0 < ${INSTALLER}/etc/apache_1.3.42.patch

# mod_perl needs /bin/sh to be bash
sudo ln -snf bash /bin/sh

#
# mod_perl
#

cd ~/apache-with-mod_perl/mod_perl-1.31
perl Makefile.PL APACHE_SRC=../apache_1.3.42/src DO_HTTPD=1 USE_APACI=1 EVERYTHING=1 APACI_ARGS=--enable-module=so
make
make test
sudo make install

#
# apache
#

cd ~/apache-with-mod_perl/apache_1.3.42
sudo make install
PATH=$PATH:/usr/local/apache/bin

# t/response/TestMore/testpm.pm needs to setup $0 in order for tests to pass.
# You can install without testing or add this block in testpm.pm:
# BEGIN { my $file = __FILE__; *0 = \$file }
cpanm --sudo --notest Apache::Test

#
# libapreq
#

cd ~/apache-with-mod_perl/libapreq-1.34
perl Makefile.PL
make
# t/response/TestApReq/big_input.pm needs to setup $0 in order for tests to pass.
# You can install without testing or add this block in big_input.pm:
# BEGIN { my $file = __FILE__; *0 = \$file }
#make test
sudo make install

cd ~/

