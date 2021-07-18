#!/bin/bash

# date          2021/07/18
# author        Nick Smith
# purpose       Post OS deployment script
# requires      n/a
# reference     n/a
# usage         $> ./postdeploy.sh

# Variables
path_ssh=/bin/ssh
path_resolve=/bin/resolve.conf

# Cleanup SSH keys
sudo rm -v $path_ssh/ssh_host_*
sudo dpkg-reconfigure openssh-server
sudo systemctl restart ssh

# Disable local DNS server
sudo systemctl disable --now systemd-resolved.service
sudo rm -v $path_resolve
sudo touch $path_resolve
sudo echo "nameserver $1" > $path_resolve
sudo echo "options edns0" >> $path_resolve
sudo echo "search $2" >> $path_resolve

# Done
