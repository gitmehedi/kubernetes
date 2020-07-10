#!/bin/bash

read -p "Node Hostname: " HOSTNAME
read -p "Node Type (m/s): " TYPE

echo -e "========== Update OS =========="
sudo apt-get update -y
sudo hostnamectl set-hostname $HOSTNAME
echo -e "========== Turn Off SWAP Memory =========="
sudo swapoff -a
sudo sed -i 's/\/swapfile/#\/swapfile/g' /etc/fstab


echo -e "========== Install Docker =========="
sudo apt-get install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker
sudo docker --version

echo -e "========== Install Kubernetes =========="
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update -y
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

kubeadm version

echo -e "========== Enable iptables bridge call =========="
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system
#echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

if [ $TYPE == "m" ]
then
  echo -e "========== Configure Kubernetes =========="
  sudo kubeadm init --pod-network-cidr=10.244.0.0/16
  sudo mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

  kubectl get nodes

  echo -e "========== Add Flannel Networks =========="
#  sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
  kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

  kubeadm token create --ttl 0 --print-join-command >> token.txt
  kubectl api-versions

fi

echo -e "========== Reboot OS =========="
sudo reboot -f


