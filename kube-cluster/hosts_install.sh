#!/bin/bash


# Add route

sudo apt-get install -y net-tools
sudo route add default gw 192.168.56.1


# Add host for cluster
sudo cat >> /etc/hosts <<EOF
192.168.56.50    k8nfs
192.168.56.53    k8m
192.168.56.54    k8w1
192.168.56.55    k8w2
EOF

sudo sed -i 's/127.0.1.1/#127.0.1.1/g' /etc/hosts

touch /var/tmp/setup_hosts.sh