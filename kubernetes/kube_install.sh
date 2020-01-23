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





# Some additional instruction on kubernetes

 curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# you can use 'xenial' for ubuntu instead for lab_release -cs

sudo add-apt-repository   "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# you can set kubernetes version for kubelet, kubeadm, kubectl and docker-ce
# sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io
# Uninstall previous versions sudo apt-get remove docker docker-engine docker.io containerd runc


KUBE_VERSION=1.17.0
DOCKER_VERSION=5:18.09.9~3-0~ubuntu-xenial

sudo apt-get update -y
sudo apt-get install -y docker-ce=$DOCKER_VERSION docker-ce-cli=$DOCKER_VERSION containerd.io
sudo apt-get install -y kuberlet=$KUBE_VERSION kubeadm=$KUBE_VERSION kubectl=$KUBE_VERSION


#Mark hold tthos version 
sudo apt-mark hold docker-ce kubelet kubeadm kubectl

#Enable IP table bridge call
echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# Run following command on Master Server
sudo swapoff -a
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# Setup local kubeconfig:
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install Flannel Networking
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/3f7d3e6c24f641e7ff557ebcea1136fdf4b1b6a1/Documentation/kube-flannel.yml

# On each kube node server
sudo kubeadm join $controller_private_ip:6443 --token $token --discovery-token-ca-cert-hash $hash   
