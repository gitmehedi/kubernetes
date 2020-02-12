#!/bin/bash

DOCKER_VERSION=5:18.09.9~3-0~ubuntu-xenial

echo -e "========== Remove Older Version of Docker =========="
sudo apt-get remove -y docker docker-engine docker.io containerd runc

echo -e "========== Install Docker and Kubernetes packages =========="
sudo apt-get update -y
sudo apt-get install -y apt-transport-https
#sudo apt-get install -y docker-ce=$DOCKER_VERSION docker-ce-cli=$DOCKER_VERSION containerd.io
sudo apt-get install -y docker.io
sudo setfacl --modify user:${USER}:rw /var/run/docker.sock

mkdir -p /etc/systemd/system/docker.service.d
systemctl daemon-reload
systemctl restart docker

echo -e "========== Install minikube in Ubuntu =========="
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube
sudo mkdir -p /usr/local/bin/
sudo install minikube /usr/local/bin/
minikube start --vm-driver=docker

echo -e "========== Install minikube in IOS =========="
# brew install minikube
