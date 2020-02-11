#!/bin/bash

echo -e "========== Install minikube in Ubuntu =========="
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube
sudo mkdir -p /usr/local/bin/
sudo install minikube /usr/local/bin/
minikube start --vm-driver=docker

echo -e "========== Install minikube in IOS =========="
# brew install minikube
