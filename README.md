Act out of the box
==================

This repository is meant to be a Vagrant build script!

please install Vagrant first

then:

    vagrant up
    vagrant ssh


once connected:

    /vagrant/install.sh


Enjoy the ride!!

at this moment PostFix needs manual configuration:
    
    [ Local Only ]
    
    mongueurs.local
  


this is a NOT FULLY TESTED set-up to install

* Apache 1.2.42
* Mod_Perl 1.31

* Dependencies for Act

And it will look for a repository to install Act itself

Thanks to Alex Muntada for doing a lot of ground work.
His version actually also set up some additional software which I rather see as a two step process

Setup
=====

0) You have to enable virtualization support in your BIOS. Look for
   Keywords like "Intel VT-x", "AMD-V" or "Virtualization".

1) Clone Act-out-of-the-box from your favourite github account to your
   work directory on your host system. (Optionally, consider forking
   the project on github and clone that one instead.)

    $ git clone https://github.com/Act-Voyager/Act-out-of-the-box.git

2) Install vagrant and virtualbox on your host system

    $ apt-get install vagrant virtualbox

3) Set up a custom private SSH key for this virtual machine

    $ ssh-keygen -f $HOME/.ssh/act_developper

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

7) When inside, sudo to root and run the Act install script

    $ sudo -i
    # cd /vagrant
    # ./install.sh

   Output from the install script is logged in "install.log" in the
   same directory as itself.


(c) 2014 THEMA-MEDIA Th.J. van Hoesel

