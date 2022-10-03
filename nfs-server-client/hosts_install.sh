#!/bin/bash


# Add route

sudo apt-get install -y net-tools
sudo route add default gw 192.168.56.1


# Add host for NFS
sudo cat >> /etc/hosts <<EOF
192.168.56.50    nfs8server
192.168.56.51    nfs8client
EOF

sudo sed -i 's/127.0.1.1/#127.0.1.1/g' /etc/hosts

touch /var/tmp/setup_hosts.sh