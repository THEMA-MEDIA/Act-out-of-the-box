Act out of the box
==================

In the final stage, as described at
https://github.com/Act-Voyager/Act-out-of-the-box
hacking on Act will start as simple as:

    mkdir act_voyager
    cd act_voyager
    curl -Os raw.githubusercontent.com/Act-Voyager/Act-out-of-the-box/master/Vagrantfile
    vagrant up
    vagrant ssh

This repository is entirely dedicated on creating a Act-out-of-the-box
package

How to contribute
=================

Contributions are welcome at any time! This repository is meant to be
a Vagrant build script.

Repository: https://github.com/THEMA-MEDIA/Act-out-of-the-box


About the repository
====================

This Vagrant Builder script installs the following:

* Apache 1.2.42
* Mod_Perl 1.31
* PostFix
* PostgreSQL 8.4

* Dependencies for Act
* Sample Database

* some other tools, like cpanm

Setup / Installation
====================

1) Clone Act-out-of-the-box from your favourite github account to your
   work directory on your host system. (Optionally, consider forking
   the project on github and clone that one instead.)

    $ git clone https://github.com/THEMA-MEDIA/Act-out-of-the-box.git

2) Install vagrant and virtualbox on your host system. You may follow
   instructions on http://vagrantup.com/downloads.html or on Ubuntu, run

    $ apt-get install vagrant virtualbox

4) Optionally, edit the Vagrantfile field for config.vm.network ip
   address to suit your needs. By default, the VM is set up to use DHCP
   to get an IP address. You can override this by uncommenting the
   following line in Vagrantfile:

    config.vm.network: "private_network", ip: "192.168.42.42"

5) Run "vagrant up". This downloads the required image and set up
   your Act instance.

    $ vagrant up

6) Log into the VM to start Act setup process

    $ vagrant ssh

7) When inside, run the Act install script

    $ /vagrant/install.sh

   Output from the install script is logged in "install.log" in your
   current working directory.

8) Start hacking!

9) Package the box and ship it

    $ vagrant package

VagrantFile
===========

As part of the build and distribution proces, one might distribute the
package.box file with a VagrantFile. That would be nice for a base install.
However, since there will probably be two versions of it might be more
convenient to keep the basebox and the final VagrantFile seperated.

Acknowledgements
================

Thanks to Alex Muntada for doing a lot of ground work.
His version actually also set up some additional software which I rather
see as a two step process. Thanks to Detlev Hauschildt for keeping notes
of his longwinded install troubles that gave even more insight
Thanks for Salve J. Nilsen for checking and editing where needed


Copyright & License
===================

(c) 2014 THEMA-MEDIA Th.J. van Hoesel

