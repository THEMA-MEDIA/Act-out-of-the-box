#/ bin/sh
#
# install the Act software from github...

if [ -z "$ACTHOME" ]; then
    echo ""                        >> ~/.profile
    echo "export ACTHOME=~/act"    >> ~/.profile
    echo ""                        >> ~/.profile
    export ACTHOME=~/act
fi

git clone https://github.com/Act-Voyager/Act.git $ACTHOME

cd $ACTHOME

#
# cpanm is smart enough to handle the whole distribution at once
#
# just make sure that Module::Install has been installed
# just make sure that there is a valid Act config
#

# cpanm --sudo .
cpanm --sudo --install-deps .
cpanm --sudo --no-test


