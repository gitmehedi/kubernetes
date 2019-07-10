#!/bin/bash

echo -e "\n--------------- add docker repository in ubuntu 16.04--------------"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo -e "\n-----------add kubernetes repository in ubuntu 16.04-----------------"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

cat << EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

echo -e "\n-----Install Docker and Kubernetes packages-------------\n"

sudo apt-get update

echo -e "\n---------install docker and kubernetes with dependencies----------------"
sudo apt-get install -y docker-ce=18.06.1~ce~3-0~ubuntu kubelet=1.13.5-00 kubeadm=1.13.5-00 kubectl=1.13.5-00

sudo apt-mark hold docker-ce kubelet kubeadm kubectl

echo -e "\n---------------- Enable iptables bridge call---------------------"
echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

