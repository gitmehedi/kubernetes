#!/bin/bash

DOCKER_VERSION=5:18.09.9~3-0~ubuntu-xenial

echo -e "========== Remove Older Version of Docker =========="
sudo apt-get remove -y docker docker-engine docker.io containerd runc

echo -e "========== Install Docker Packages =========="
sudo apt-get update -y
sudo apt-get install -y apt-transport-https
sudo apt-get install -y virtualbox virtualbox-ext-pack

sudo apt-get install -y docker.io
sudo setfacl --modify user:${USER}:rw /var/run/docker.sock
mkdir -p /etc/systemd/system/docker.service.d
systemctl daemon-reload
systemctl restart docker

echo -e "========== Install Kubernetes Packages =========="

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo touch /etc/apt/sources.list.d/kubernetes.list
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

echo -e "========== Install minikube in Ubuntu =========="
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube
sudo mkdir -p /usr/local/bin/
sudo install minikube /usr/local/bin/
minikube start --vm-driver=docker

echo -e "========== Install minikube in IOS =========="
kubectl api-versions
