#!/bin/bash


cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sudo sysctl --system

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