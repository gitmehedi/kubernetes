#!/bin/bash
echo -e "Kubernetes Insstaion Type: Options [k/mk]":; read TYPE

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

echo -e "Version of Kubernetes: "
kubectl api-versions
