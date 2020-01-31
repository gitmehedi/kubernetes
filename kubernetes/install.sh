#!/bin/bash
read -p "Node Type Master/Slave (m/s): " SER_TYPE
read -p "Kubernetes Hostname: " HOSTNAME

KUBE_VERSION=1.17.0-00
DOCKER_VERSION=5:18.09.9~3-0~ubuntu-xenial
IP=`hostname -I | awk '{print $2}'`

echo -e "========== Turn Off SWAP Memory =========="
sudo swapoff -a
sudo sed -i 's/\/swapfile/#\/swapfile/g' /etc/fstab

echo -e "========== Change Hostname of Node =========="
sudo hostnamectl set-hostname $HOSTNAME
echo -e "$IP $HOSTNAME.com $HOSTNAME" >> /etc/hosts
echo -e "
auto enp0s8
iface enp0s8 inet static
address $IP" >> /etc/network/interfaces

/etc/init.d/hostname restart

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
sudo apt-get install -y apt-transport-https
sudo apt-get install -y docker-ce=$DOCKER_VERSION docker-ce-cli=$DOCKER_VERSION containerd.io
sudo apt-get install -y conntrack cri-tools ebtables ethtool kubernetes-cni socat
sudo apt-get install -y kubelet=$KUBE_VERSION kubeadm=$KUBE_VERSION kubectl=$KUBE_VERSION

echo -e "========== Hold Docker and Kubernetes Update =========="
sudo apt-mark hold docker-ce kubelet kubeadm kubectl

echo -e "========== Enable iptables bridge call =========="
echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
echo -e "Environment=\"cgroup-driver=systemd/cgroup-driver=cgroupfs\"" >> /etc/systemd/system/kubelet.service.d/10-kubelet.conf

if [ $SER_TYPE == "m" ]
then
  echo -e "========== Initial Kubernetes with CIDR =========="
  sudo kubeadm init --pod-network-cidr=10.244.0.0/16

  echo -e "========== Setup local kubeconfig =========="
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

  echo -e "========== Install Flannel Networking =========="
  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/3f7d3e6c24f641e7ff557ebcea1136fdf4b1b6a1/Documentation/kube-flannel.yml
fi

echo -e "========== Export Join Token =========="
kubeadm token create --ttl 0 --print-join-command >> token.txt

echo -e "========== Version of Kubernetes =========="
kubectl api-versions
sudo reboot -f
