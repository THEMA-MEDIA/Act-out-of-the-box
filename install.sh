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

if [ "$CONFIRM" != "Yes" ]
then
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
# where to find everything...
#

export INSTALLER="/vagrant"

$INSTALLER/bin/apache-with-mod_perl.sh
$INSTALLER/bin/database.sh
$INSTALLER/bin/mailer.sh
$INSTALLER/bin/pre_install.sh
$INSTALLER/bin/useradd_voyager.sh

echo "we hope you did enjoy the ride..."
sleep 3
echo "now exit and re-login as actuser"


