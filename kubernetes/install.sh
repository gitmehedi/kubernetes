#!/bin/bash
read -p "Node Type Master/Slave (m/s): " SER_TYPE

KUBE_VERSION=1.17.0-00
DOCKER_VERSION=5:18.09.9~3-0~ubuntu-xenial

echo -e "========== Remove Older Version of Docker =========="
sudo apt-get remove -y docker docker-engine docker.io containerd runc

echo -e "========== Add Docker and Kubernetes Repository =========="
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

cat << EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

echo -e "========== Install Docker and Kubernetes packages =========="
sudo apt-get update -y
sudo apt-get install -y docker-ce=$DOCKER_VERSION docker-ce-cli=$DOCKER_VERSION containerd.io
sudo apt-get install -y kuberlet=$KUBE_VERSION kubeadm=$KUBE_VERSION kubectl=$KUBE_VERSION

echo -e "========== Hold Docker and Kubernetes Update =========="
sudo apt-mark hold docker-ce kubelet kubeadm kubectl

echo -e "========== Enable iptables bridge call =========="
echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

if [ $SER_TYPE == "m" ]
then
  echo -e "========== Initial Kubernetes with CIDR =========="
  sudo swapoff -a
  sudo kubeadm init --pod-network-cidr=10.244.0.0/16

  echo -e "========== Setup local kubeconfig =========="
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

  echo -e "========== Install Flannel Networking =========="
  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/3f7d3e6c24f641e7ff557ebcea1136fdf4b1b6a1/Documentation/kube-flannel.yml
fi

TYPE="p"
if [ $TYPE == 'k' ]
then
	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
	sudo touch /etc/apt/sources.list.d/kubernetes.list
	echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
	sudo apt-get -y update
	sudo apt-get install -y  kubelet kubeadm
elif [ $TYPE == 'mk' ]
then
	curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.28.2/minikube-linux-amd64
	chmod +x minikube && sudo mv minikube /usr/local/bin/
	minikube start
else
	echo -e "========== No process to execute =========="
fi

echo -e "========== Version of Kubernetes =========="
kubectl api-versions