#!/bin/sh

clear

echo "                                                              "
echo "            ########                                          "
echo "            ########                                          "
echo "            ########  ########                                "
echo "  ########  ########  ########                                "
echo "  ########            ########                                "
echo "  ########  ########  ########                                "
echo "  ########  ########                                          "
echo "            ########  ########                                "
echo "  ########  ########  ########                                "
echo "  ########            ########                                "
echo "  ########  ########  ########                                "
echo "  ########  ########                                          "
echo "            ########                                          "
echo "            ########            (c) 2014  www.THEMA-MEDIA.nl  "
echo "                                                              "
echo
echo "You should not run this script unless you know what you are doing."
echo "There is no assurance that it works or does what you mean."
echo "You have been warned."
echo
echo "                                Theo van Hoesel & Alex Muntada"
echo
read -p "Are you sure you want to continue [Yes] ? " -r CONFIRM

if [ $CONFIRM != "Yes" ]
then
  clear
  echo
  echo "Exit, very well"
  echo
  exit
else
  echo
  echo "Enjoy the ride..."
  echo
fi

set -e

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

patch -p0 < /vagrant/apache_1.3.42.patch

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

#
# setup postfix for mail
#

# select local only
sudo apt-get --assume-yes install postfix

#
# setup PostgrSQL
#

sudo apt-get --assume-yes install postgresql

#
# install some tools for working on distrubutions
#

cpanm --sudo Module::Install

echo
echo "Done !!!"
echo
