#!/bin/bash

# 
# install docker from below link
# https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
# 20200803 Arif
#




cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sudo sysctl --system


sudo apt-get update -y && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update -y
echo "Installing kube* software"
sudo apt-get install -y kubelet=1.18.6-00 kubeadm=1.18.6-00 kubectl=1.18.6-00
sudo apt-mark hold kubelet kubeadm kubectl


echo "initialize kubeadm cluster (master node only), in worker node join only command is required from master"
# additional check 
# kubeadm config print init-defaults
# kubeadm config images list
# kubeadm config images pull
# sudo docker images

#Final command to initialize kube cluster master node for calico CNI
#config file for calico CNI
cat <<EOF | sudo tee kubeadm-config.yaml
apiVersion: kubeadm.k8s.io/v1beta2
kind: ClusterConfiguration
EOF
#sudo kubeadm init --config kubeadm-config.yaml
#kubectl apply -f https://docs.projectcalico.org/v3.14/manifests/calico.yaml


#Final command to initialize kube cluster master node for flanel CNI
#sudo kubeadm init --pod-network-cidr=10.244.0.0/16
#sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# now follow on screen instruction for accessing kube cluster and command for joining worker node


#systemctl daemon-reload
#systemctl restart kubelet

#ctl flag
touch /var/tmp/k18-kube-software-install.sh
