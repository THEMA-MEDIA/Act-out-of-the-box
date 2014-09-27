export ACT_USER="voyager"

sudo groupadd actusers
sudo useradd --comment "Act Voyager member" --groups actusers,admin --create-home $ACT_USER

# better... create voyager public keys
sudo -u $ACT_USER mkdir /home/$ACT_USER/.ssh
sudo -u $ACT_USER touch /home/$ACT_USER/.ssh/authorized_keys
sudo -u $ACT_USER chmod 600 /home/$ACT_USER/.ssh/authorized_keys
# sudo -u $ACT_USER bash -c "cat /vagrant/$ACT_USER.pub >> /home/$ACT_USER/.ssh/authorized_keys"
sudo -u $ACT_USER bash -c "echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDxZYg2je7sPGV9CvrJ4RBST0/aMQDTNsrxPJ953EAJ3qOnGrBT62lIM/dU3cHYE2pLftL93dcxgZxc4I6wOX24aKQzPY8xFICLkantFUv8P6dPBggMi+VNQNOztauB4OHY0sKrEmAz79R3R+ZLUGUBvZXjOkj9/kMGiZH1X2GJYxAQ6MdmoDs2jiJyQOCBE8/v6i8obZZuPMCEwhce5td7qvxZUDHFld//VHpw+qWqynkX+VAr6Vf7nXMeT64oVf/3sC1QH6i7q1VvHger+IVkb1VOI1WBvi1Ni5nTAXKa3mrQbz4PKizG+KQIZQGfHDDpVpP5L2Ryykb9MAJHQr9R insecure Act-Voyager key" >> /home/$ACT_USER/.ssh/authorized_keys"

# ask me how to generate the private key, but ofcourse you can create your own pair



