# kubernetes Cluster Installation Hard Way



Table of Contents
==================


## Document History
* [Kubernetes Cluster Installation Hard Way](#kubernetes-cluster-installation-hard-way)
   * [Document History](#document-history)
   * [Introduction](#introduction)
   * [Kubernetes Software Cluster Details](#kubernetes-software-cluster-details)
   * [Provision Computer Node Using Vagrant](#provision-computer-node-using-vagrant)
      * [Install Vagrant](#install-vagrant)
      * [Provision Computer Node](#provision-computer-node)
   * [Installing the Client Tools](#installing-the-client-tools)
      * [Kubectl Install and Configure](#kubectl-install-and-configure)
   * [Certificate Authority and TLS Certificates](#certificate-authority-and-tls-certificates)
      * [Certificate Authority](#certificate-authority) 
      * [TLS Certificates](#tls-certificates) 
      * [Distribute Certificates](#distribute-certificates)
   * [Generating Kubernetes Configuration Files](#generating-kubernetes-configuration-files)
   * [Generating the Data Encryption Config and Key](#generating-the-data-encryption-config-and-key)
   * [Bootstrapping the etcd Cluster](#bootstrapping-the-etcd-cluster)
   * [Bootstrapping the Kubernetes Control Plane](#bootstrapping-the-kubernetes-control-plane)

# Kubernetes Cluster Installation Hard Way
## Document History
```reStructuredText
Document History:
2020-04-19	V1 Mehedi Hasan "Install Multi Node Kubernetes Cluster Hard Way"
```

## Introduction 
Installation procedure followed [kubernetes-the-hard-way](https://github.com/mmumshad/kubernetes-the-hard-way) and few steps are modified according to latest software release.

## Kubernetes Software Cluster Details
```bash
Kubernetes Version: 1.18.0
Docker Container Runtime: 19.3.8
CNI Container Networking: 0.8.5
ETCD Version: v3.4.7
Weave Networking: v0.8.5
CoreDNS: v1.6.9 
```

## Provision Computer Node Using Vagrant
### Install Vagrant 
```bash
$ wget https://releases.hashicorp.com/vagrant/2.2.7/vagrant_2.2.7_x86_64.deb

/* Double click on binary files and install it */

$ vagrant -v 
  Vagrant 2.2.7
```
Setup vagrant environment variable for root & other user to get control config location from any where.
```bash
#Final Vagrant Config dir in my linux desktop: 
/ext/wdc512/LinuxContent/vagrantVMsRepo/vagrant.d

#set VAGRANT_HOME dir to find host specific config file
vi /home/arif/.bashrc
export VAGRANT_HOME=/ext/wdc512/LinuxContent/vagrantVMsRepo/vagrant.d
chown arif:arif -R /ext/wdc512/LinuxContent/vagrantVMsRepo/vagrant.d


#set vagrant path to find prefered config file
vi /home/arif/.bashrc
vagMyRepo=/ext/wdc512/LinuxContent/vagrantVMsRepo
export VAGRANT_CWD=$vagMyRepo/kube_hard_way/vagrant

#open virtual box as root user and setup prefered image location
```

### Provision Computer Node

```bash
mkdir -p /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way
cd /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way
cp -rfp ~/gitRepos/kubernetes-the-hard-way-mmumshad/vagrant /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way

/ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant$ sudo vagrant up --provider=virtualbox

Below command is working after upgrading vagrant to 2.2.7
$ sudo vagrant up --provider=virtualbox


$ sudo vagrant status
Current machine states:

master-1                  running (virtualbox)
master-2                  running (virtualbox)
master-3                  running (virtualbox)
loadbalancer              running (virtualbox)
worker-1                  running (virtualbox)
worker-2                  running (virtualbox)
worker-3                  running (virtualbox)
worker-4                  running (virtualbox)

This environment represents multiple VMs. The VMs are all listed
above with their current state. For more information about a specific
VM, run `vagrant status NAME`.

# vagrant status

$ vagrant global-status

```

## Installing the Client Tools
Login vagrant master-1 node
```bash
$ vagrant ssh master-1
```

Generate ssh public/private key in master-1 node
```bash
vagrant@master-1:~$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/vagrant/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/vagrant/.ssh/id_rsa.
Your public key has been saved in /home/vagrant/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:N9JAwJ1fK2aLjOkOK/d6HVPT8pbPObeYV94irYX0Lx0 vagrant@master-1
The key's randomart image is:
+---[RSA 2048]----+
|     ..o..       |
|      ..o   .    |
|        .. o .   |
|         oO o    |
|       +S=+*..   |
|      o =o.o+o E.|
|    .. . o ..+o++|
|  . .oo .   ..@o=|
|   oo=o     .=.*o|
+----[SHA256]-----+

```

View genrated ssh public key ID: 
```bash
vagrant@master-1:~$ cat .ssh/id_rsa.pub 
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCeEEbkVL9qFw/y1qtql9tQMoiQnRZouOD7sXa5C1yMbnaKs+m5YDq0mSdtkyWe1LyLGQF2dEnWsi6CfzJ/zIyv3CnkoOfjIXJaePT5yS8X3DsfopqAH5/g21s9Bo18qEhIkscFdXR3ubzf95tZTONrmz7B1NqVSUB49VXwhXkZaXe9HKsG4mSwvlQX2fsmwsYbzN9aNTQIXph6UENklbBRz2RR5QXxbqSbrW0a+BJf8OKRN6QeIcsXU5q2VTOH+XrOhJq/n2mzeMDDfUUiAISPW/zhwfgKpWBzTK56ezZSPphowW2df8HSiXDT94olRB/IzASlV0VeakkCE3YXsX8z vagrant@master-1
```
Move generate public key of master to all other VMs:
```bash
vagrant@master-2:~$ cat >> ~/.ssh/authorize_key <<EOF 
> ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCeEEbkVL9qFw/y1qtql9tQMoiQnRZouOD7sXa5C1yMbnaKs+m5YDq0mSdtkyWe1LyLGQF2dEnWsi6CfzJ/zIyv3CnkoOfjIXJaePT5yS8X3DsfopqAH5/g21s9Bo18qEhIkscFdXR3ubzf95tZTONrmz7B1NqVSUB49VXwhXkZaXe9HKsG4mSwvlQX2fsmwsYbzN9aNTQIXph6UENklbBRz2RR5QXxbqSbrW0a+BJf8OKRN6QeIcsXU5q2VTOH+XrOhJq/n2mzeMDDfUUiAISPW/zhwfgKpWBzTK56ezZSPphowW2df8HSiXDT94olRB/IzASlV0VeakkCE3YXsX8z vagrant@master-1 
> EOF
```
### Kubectl Install and Configure

1. Check latest stable version of ```kubectl```
```bash
vagrant@master-1:~$ curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt
v1.18.2
```
2. Download ```kubectl``` latest version
```bash
vagrant@master-1:~$ curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
vagrant@master-1:~$ chmod +x ./kubectl 
vagrant@master-1:~$ sudo mv kubectl /usr/local/bin/
```
3. Verify ```kubectl``` version
```bash
vagrant@master-1:~$ kubectl version --client
Client Version: version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.2", GitCommit:"52c56ce7a8272c798dbc29846288d7cd9fbae032", GitTreeState:"clean", BuildDate:"2020-04-16T11:56:40Z", GoVersion:"go1.13.9", Compiler:"gc", Platform:"linux/amd64"}
```

## Certificate Authority and TLS Certificates
With [openssl](https://www.openssl.org/) we will generate both CA and TLS certificate.
```bash
- CA
- TLS
```
*Components*  
First Generate a [Certificate Authority (CA)](cerfiticate-authority) and then 
generate TLS certificate for the following components using Certificate Authority

1. [etcd]() 
2. [kube-apiserver]()
3. [kube-controller-manager]()
4. [kube-scheduler]()
5. [kubelet]()
6. [kube-proxy]()

* Create a directory to keep separate all the the certificate
```bash
vagrant@master-1:~$ mkdir -p ~/pki
vagrant@master-1:~$ cd ~/pki
```
### Certificate Authority
In this section you will provision a Certificate Authority that can be used to generate additional TLS certificates.

Create a CA certificate, then generate a Certificate Signing Request and use it to create a private key:

Following file will be generate for CA
```bash
- ca.key
- ca.csr
- ca.crt  
```

* Create a file for generate random sequence number
```bash
vagrant@master-1:~$ touch ~/.rnd
```
* Create a private key (**ca.key**) for CA
```bash
vagrant@master-1:~$ openssl genrsa -out ca.key 2048
Generating RSA private key, 2048 bit long modulus (2 primes)
.+++++
...+++++
e is 65537 (0x010001)
```
* Create Certificate Signing Request (CSR) (**ca.csr**) for the private key
```bash
vagrant@master-1:~$ openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr
```
* Self sign the CSR using it's own private key and generate a certificate (**cs.crt**)
```bash
vagrant@master-1:~$ openssl x509 -req -in ca.csr -signkey ca.key -CAcreateserial  -out ca.crt -days 10000
Signature ok
subject=CN = KUBERNETES-CA
Getting Private key
```

### TLS Certificates
Create following client certificates
1. [Admin Client Certificate](#1-admin-client-certificate)
2. [Kube API Server Client Certificate](#2-kube-api-server-client-certificate)
3. [ETCD Server Client Certificate](#3-etcd-server-client-certificate)
4. [Scheduler Client Certificate](#4-scheduler-client-certificate)
5. [Controller Manager Client Certificate](#5-controller-manager-client-certificate)
6. [Kube Proxy Client Certificate](#6-kube-proxy-client-certificate)
7. [Service Account Client Certificate](#7-service-account-client-certificate)

#### 1. Admin Client Certificate
Generate following public key and TLS certificate for admin
```bash
- admin.key
- admin.csr
- admin.crt  
```

* Create a file for generate random sequence number
```bash
vagrant@master-1:~$ touch ~/.rnd
```
* Create a private key (**admin.key**) for admin user
```bash
vagrant@master-1:~/pki$ openssl genrsa -out admin.key 2048
Generating RSA private key, 2048 bit long modulus (2 primes)
..........+++++
.......................................+++++
e is 65537 (0x010001)

```
* Create Certificate Signing Request (CSR) (**admin.csr**) for the admin user
```bash
vagrant@master-1:~/pki$ openssl req -new -key admin.key -subj "/CN=admin/O=system:masters" -out admin.csr
```
* Self sign the CSR using it's own private key and generate a certificate for admin user (**admin.crt**)
```bash
vagrant@master-1:~/pki$ openssl x509 -req -in admin.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out admin.crt -days 10000
Signature ok
subject=CN = admin, O = system:masters
Getting CA Private Key
```
#### 2. Kube API Server Client Certificate
The kube-apiserver certificate requires all names that various components may reach it to be part of the alternate names. These include the different DNS names, and IP addresses such as the master servers IP address, the load balancers IP address, the kube-api service IP address etc.

The `openssl` command cannot take alternate names as command line parameter. So we must create a `conf` file for it:

```bash
cat > openssl.cnf <<EOF
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = kubernetes
DNS.2 = kubernetes.default
DNS.3 = kubernetes.default.svc
DNS.4 = kubernetes.default.svc.cluster.local
IP.1 = 10.96.0.1
IP.2 = 192.168.57.11
IP.3 = 192.168.57.12
IP.4 = 192.168.57.13
IP.5 = 192.168.57.30
IP.6 = 127.0.0.1
EOF
```
Generate following public key and TLS certificate for admin
```bash
- kube-apiserver.key
- kube-apiserver.csr
- kube-apiserver.crt  
```

* Create a private key (**kube-apiserver.key**) for admin user
```bash
vagrant@master-1:~/pki$ openssl genrsa -out kube-apiserver.key 2048
Generating RSA private key, 2048 bit long modulus (2 primes)
.....................................+++++
.+++++
e is 65537 (0x010001)
```
* Create Certificate Signing Request (CSR) (**kube-apiserver.csr**) for the etcd client
```bash
vagrant@master-1:~/pki$ openssl req -new -key kube-apiserver.key -subj "/CN=kube-apiserver" -out kube-apiserver.csr -config openssl.cnf
```
* Self sign the CSR using it's own private key and generate a certificate for admin user (**kube-apiserver.crt**)
```bash
vagrant@master-1:~/pki$ openssl x509 -req -in kube-apiserver.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out kube-apiserver.crt -extensions v3_req -extfile openssl.cnf -days 1000
Signature ok
subject=CN = kube-apiserver
Getting CA Private Key
```
#### 3. ETCD Server Client Certificate
First of all create a openssl.conf file in ```etcd``` server
```bash
cat > openssl-etcd.cnf <<EOF
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names
[alt_names]
IP.1 = 192.168.57.11
IP.2 = 192.168.57.12
IP.3 = 192.168.57.13
IP.4 = 127.0.0.1
EOF
```
Generate following public key and TLS certificate for admin
```bash
- etcd-server.key
- etcd-server.csr
- etcd-server.crt  
```

* Create a private key (**etcd-server.key**) for admin user
```bash
vagrant@master-1:~/pki$ openssl genrsa -out etcd-server.key 2048
Generating RSA private key, 2048 bit long modulus (2 primes)
.....................................+++++
.+++++
e is 65537 (0x010001)
```
* Create Certificate Signing Request (CSR) (**etcd-server.csr**) for the etcd client
```bash
vagrant@master-1:~/pki$ openssl req -new -key etcd-server.key -subj "/CN=etcd-server" -out etcd-server.csr -config openssl-etcd.cnf
```
* Self sign the CSR using it's own private key and generate a certificate for admin user (**etcd-server.crt**)
```bash
vagrant@master-1:~/pki$ openssl x509 -req -in etcd-server.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out etcd-server.crt -extensions v3_req -extfile openssl-etcd.cnf -days 1000
Signature ok
subject=CN = etcd-server
Getting CA Private Key
```
#### 4. Scheduler Client Certificate

Generate following public key and TLS certificate for admin

```bash
- kube-scheduler.key
- kube-scheduler.csr
- kube-scheduler.crt  
```

* Create a private key (**etcd-server.key**) for admin user

```bash
vagrant@master-1:~/pki$ openssl genrsa -out kube-scheduler.key 2048
Generating RSA private key, 2048 bit long modulus (2 primes)
.....................................+++++
.+++++
e is 65537 (0x010001)
```

* Create Certificate Signing Request (CSR) (**kube-scheduler.csr**) for the etcd client

```bash
vagrant@master-1:~/pki$ openssl req -new -key kube-scheduler.key -subj "/CN=system:kube-scheduler" -out kube-scheduler.csr
```

* Self sign the CSR using it's own private key and generate a certificate for admin user (**kube-scheduler.crt**)
```bash
vagrant@master-1:~/pki$ openssl x509 -req -in kube-scheduler.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out kube-scheduler.crt -days 1000
Signature ok
subject=CN = system:kube-scheduler
Getting CA Private Key
```

#### 5. Controller Manager Client Certificate
Generate following public key and TLS certificate for admin

```bash
- kube-controller-manager.key
- kube-controller-manager.csr
- kube-controller-manager.crt  
```

* Create a private key (**kube-controller-manager.key**) for admin user

```bash
vagrant@master-1:~/pki$ openssl genrsa -out kube-controller-manager.key 2048
Generating RSA private key, 2048 bit long modulus (2 primes)
..........................................+++++
...............+++++
e is 65537 (0x010001)
```

* Create Certificate Signing Request (CSR) (**kube-controller-manager.csr**) for the etcd client

```bash
vagrant@master-1:~/pki$ openssl req -new -key kube-controller-manager.key -subj "/CN=system:kube-controller-manager" -out kube-controller-manager.csr
```

* Self sign the CSR using it's own private key and generate a certificate for admin user (**kube-controller-manager.crt**)
```bash
vagrant@master-1:~/pki$ openssl x509 -req -in kube-controller-manager.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out kube-controller-manager.crt -days 1000
Signature ok
subject=CN = system:kube-controller-manager
Getting CA Private Key
```

#### 6. Kube Proxy Client Certificate
Generate following public key and TLS certificate for admin

```bash
- kube-proxy.key
- kube-proxy.csr
- kube-proxy.crt  
```

* Create a private key (**kube-proxy.key**) for admin user

```bash
vagrant@master-1:~/pki$ openssl genrsa -out kube-proxy.key 2048
Generating RSA private key, 2048 bit long modulus (2 primes)
..........................................................+++++
.....................+++++
e is 65537 (0x010001)
```

* Create Certificate Signing Request (CSR) (**kube-proxy.csr**) for the etcd client

```bash
vagrant@master-1:~/pki$ openssl req -new -key kube-proxy.key -subj "/CN=system:kube-proxy" -out kube-proxy.csr
```

* Self sign the CSR using it's own private key and generate a certificate for admin user (**kube-proxy.crt**)
```bash
vagrant@master-1:~/pki$ openssl x509 -req -in kube-proxy.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out kube-proxy.crt -days 1000
Signature ok
subject=CN = system:kube-proxy
Getting CA Private Key
```

openssl x509 -req -in kube-proxy.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out kube-proxy.crt -days 1000
#### 7. Service Account Client Certificate
Generate following public key and TLS certificate for admin

```bash
- service-account.key
- service-account.csr
- service-account.crt  
```

* Create a private key (**service-account.key**) for admin user

```bash
vagrant@master-1:~/pki$ openssl genrsa -out service-account.key 2048
Generating RSA private key, 2048 bit long modulus (2 primes)
..........................................................................................+++++
...................+++++
e is 65537 (0x010001)
```

* Create Certificate Signing Request (CSR) (**service-account.csr**) for the etcd client

```bash
vagrant@master-1:~/pki$ openssl req -new -key service-account.key -subj "/CN=service-accounts" -out service-account.csr
```

* Self sign the CSR using it's own private key and generate a certificate for admin user (**service-account.crt**)
```bash
vagrant@master-1:~/pki$ openssl x509 -req -in service-account.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out service-account.crt -days 1000
Signature ok
subject=CN = service-accounts
Getting CA Private Key
```

### Distribute Certificates

Copy the appropriate certificates and private keys to each controller instance:

```bash
for instance in master-1 master-2; do
  scp ca.crt ca.key kube-apiserver.key kube-apiserver.crt \
    service-account.key service-account.crt \
    etcd-server.key etcd-server.crt \
    ${instance}:~/
done
```


## Generating Kubernetes Configuration Files

**Generating Kubernetes Configuration Files for Authentication**

Generate kube config file for following component

```bash
- controller manager
- kubelet
- kube-proxy
- scheduler
- admin user
```
#### Define Kubernetes Public IP Address
```bash
LOADBALANCER_ADDRESS=192.168.57.30
```
#### kube-proxy Kubernetes Configuration File
```bash
cd ~/pki
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.crt \
    --embed-certs=true \
    --server=https://${LOADBALANCER_ADDRESS}:6443 \
    --kubeconfig=kube-proxy.kubeconfig

  kubectl config set-credentials system:kube-proxy \
    --client-certificate=kube-proxy.crt \
    --client-key=kube-proxy.key \
    --embed-certs=true \
    --kubeconfig=kube-proxy.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:kube-proxy \
    --kubeconfig=kube-proxy.kubeconfig

  kubectl config use-context default --kubeconfig=kube-proxy.kubeconfig
}
```
**Results**
```bash
Cluster "kubernetes-the-hard-way" set.
User "system:kube-proxy" set.
Context "default" created.
Switched to context "default".
```

#### Kube-controller-manager Kubernetes Configuration File
Generate a kubeconfig file for the kube-controller-manager service:
```bash
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.crt \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=kube-controller-manager.kubeconfig

  kubectl config set-credentials system:kube-controller-manager \
    --client-certificate=kube-controller-manager.crt \
    --client-key=kube-controller-manager.key \
    --embed-certs=true \
    --kubeconfig=kube-controller-manager.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:kube-controller-manager \
    --kubeconfig=kube-controller-manager.kubeconfig

  kubectl config use-context default --kubeconfig=kube-controller-manager.kubeconfig
}
```

**Results**
```bash
Cluster "kubernetes-the-hard-way" set.
User "system:kube-controller-manager" set.
Context "default" created.
Switched to context "default".
```
#### The kube-scheduler Kubernetes Configuration File
Generate a kubeconfig file for the kube-scheduler service
```bash
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.crt \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=kube-scheduler.kubeconfig

  kubectl config set-credentials system:kube-scheduler \
    --client-certificate=kube-scheduler.crt \
    --client-key=kube-scheduler.key \
    --embed-certs=true \
    --kubeconfig=kube-scheduler.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:kube-scheduler \
    --kubeconfig=kube-scheduler.kubeconfig

  kubectl config use-context default --kubeconfig=kube-scheduler.kubeconfig
}
```

**Results**
```bash
Cluster "kubernetes-the-hard-way" set.
User "system:kube-scheduler" set.
Context "default" created.
Switched to context "default".
```

#### The admin Kubernetes Configuration File
Generate a kubeconfig file for the admin user:
```bash
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.crt \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=admin.kubeconfig

  kubectl config set-credentials admin \
    --client-certificate=admin.crt \
    --client-key=admin.key \
    --embed-certs=true \
    --kubeconfig=admin.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=admin \
    --kubeconfig=admin.kubeconfig

  kubectl config use-context default --kubeconfig=admin.kubeconfig
}
```

**Results**
```bash
Cluster "kubernetes-the-hard-way" set.
User "admin" set.
Context "default" created.
Switched to context "default".
```

### Distribute the Kubernetes Configuration Files
Copy the appropriate kube-proxy kubeconfig files to each worker instance:
```bash
for instance in worker-1 worker-2; do
  scp kube-proxy.kubeconfig ${instance}:~/
done
```
Copy the appropriate kube-controller-manager and kube-scheduler kubeconfig files to each controller instance:
```bash
for instance in master-1 master-2; do
  scp admin.kubeconfig kube-controller-manager.kubeconfig kube-scheduler.kubeconfig ${instance}:~/
done
```

## Generating the Data Encryption Config and Key
Kubernetes stores a variety of data including cluster state, application configurations, and secrets. Kubernetes supports the ability to encrypt cluster data at rest.

In this lab you will generate an encryption key and an encryption config suitable for encrypting Kubernetes Secrets.
#### Encryption Key
```bash
ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)
```
#### The Encryption Config File
Create the encryption-config.yaml encryption config file:
```bash
cat > encryption-config.yaml <<EOF
kind: EncryptionConfig
apiVersion: v1
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: ${ENCRYPTION_KEY}
      - identity: {}
EOF
```

Copy the encryption-config.yaml encryption config file to each controller instance:
```bash
for instance in master-1 master-2; do
  scp encryption-config.yaml ${instance}:~/
done
```

#### Configure the etcd Server
```bash
{
  sudo mkdir -p /etc/etcd /var/lib/etcd
  sudo cp ca.crt etcd-server.key etcd-server.crt /etc/etcd/
}
```
The instance internal IP address will be used to serve client requests and communicate with etcd cluster peers. Retrieve the internal IP address of the master(etcd) nodes:
```bash 
INTERNAL_IP=$(ip addr show enp0s8 | grep "inet " | awk '{print $2}' | cut -d / -f 1)
```
Each etcd member must have a unique name within an etcd cluster. Set the etcd name to match the hostname of the current compute instance:
```bash
ETCD_NAME=$(hostname -s)
```
Create the etcd.service systemd unit file:
```bash
cat <<EOF | sudo tee /etc/systemd/system/etcd.service
[Unit]
Description=etcd
Documentation=https://github.com/coreos

[Service]
ExecStart=/usr/local/bin/etcd \\
  --name ${ETCD_NAME} \\
  --cert-file=/etc/etcd/etcd-server.crt \\
  --key-file=/etc/etcd/etcd-server.key \\
  --peer-cert-file=/etc/etcd/etcd-server.crt \\
  --peer-key-file=/etc/etcd/etcd-server.key \\
  --trusted-ca-file=/etc/etcd/ca.crt \\
  --peer-trusted-ca-file=/etc/etcd/ca.crt \\
  --peer-client-cert-auth \\
  --client-cert-auth \\
  --initial-advertise-peer-urls https://${INTERNAL_IP}:2380 \\
  --listen-peer-urls https://${INTERNAL_IP}:2380 \\
  --listen-client-urls https://${INTERNAL_IP}:2379,https://127.0.0.1:2379 \\
  --advertise-client-urls https://${INTERNAL_IP}:2379 \\
  --initial-cluster-token etcd-cluster-0 \\
  --initial-cluster master-1=https://192.168.5.11:2380,master-2=https://192.168.5.12:2380 \\
  --initial-cluster-state new \\
  --data-dir=/var/lib/etcd
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```

#### Start the etcd Server
```bash
{
  sudo systemctl daemon-reload
  sudo systemctl enable etcd
  sudo systemctl start etcd
}
```

> Remember to run the above commands on each controller node: master-1, and master-2.

### Verification
List the etcd cluster members:
```bash
sudo ETCDCTL_API=3 etcdctl member list \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/etcd/ca.crt \
  --cert=/etc/etcd/etcd-server.crt \
  --key=/etc/etcd/etcd-server.key
```

**Results**
```bash
45bf9ccad8d8900a, started, master-2, https://192.168.5.12:2380, https://192.168.5.12:2379
54a5796a6803f252, started, master-1, https://192.168.5.11:2380, https://192.168.5.11:2379
```

## Bootstrapping the Kubernetes Control Plane
In this lab you will bootstrap the Kubernetes control plane across 2 compute instances and configure it for high availability. You will also create an external load balancer that exposes the Kubernetes API Servers to remote clients. The following components will be installed on each node: Kubernetes API Server, Scheduler, and Controller Manager.

### Prerequisites

The commands in this lab must be run on each controller instance: master-1, and master-2. Login to each controller instance using SSH Terminal. Example:
#### Running commands in parallel with tmux

tmux can be used to run commands on multiple compute instances at the same time. See the Running commands in parallel with tmux section in the Prerequisites lab.

### Provision the Kubernetes Control Plane

Create the Kubernetes configuration directory:
```bash
sudo mkdir -p /etc/kubernetes/config
```

#### Download and Install the Kubernetes Controller Binaries

Download the official Kubernetes release binaries:
```bash
wget -q --show-progress --https-only --timestamping \
  "https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kube-apiserver" \
  "https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kube-controller-manager" \
  "https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kube-scheduler" \
  "https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kubectl"
```
Reference: https://kubernetes.io/docs/setup/release/#server-binaries

Install the Kubernetes binaries:

```bash
{
  chmod +x kube-apiserver kube-controller-manager kube-scheduler kubectl
  sudo mv kube-apiserver kube-controller-manager kube-scheduler kubectl /usr/local/bin/
}
```

### Configure the Kubernetes API Server

```bash
{
  sudo mkdir -p /var/lib/kubernetes/

  sudo cp ca.crt ca.key kube-apiserver.crt kube-apiserver.key \
    service-account.key service-account.crt \
    etcd-server.key etcd-server.crt \
    encryption-config.yaml /var/lib/kubernetes/
}
```
The instance internal IP address will be used to advertise the API Server to members of the cluster. Retrieve the internal IP address for the current compute instance:
```bash
INTERNAL_IP=$(ip addr show enp0s8 | grep "inet " | awk '{print $2}' | cut -d / -f 1)
```
Verify it is set
```bash
echo $INTERNAL_IP
```

Create the kube-apiserver.service systemd unit file:
```bash
cat <<EOF | sudo tee /etc/systemd/system/kube-apiserver.service
[Unit]
Description=Kubernetes API Server
Documentation=https://github.com/kubernetes/kubernetes

[Service]
ExecStart=/usr/local/bin/kube-apiserver \\
  --advertise-address=${INTERNAL_IP} \\
  --allow-privileged=true \\
  --apiserver-count=3 \\
  --audit-log-maxage=30 \\
  --audit-log-maxbackup=3 \\
  --audit-log-maxsize=100 \\
  --audit-log-path=/var/log/audit.log \\
  --authorization-mode=Node,RBAC \\
  --bind-address=0.0.0.0 \\
  --client-ca-file=/var/lib/kubernetes/ca.crt \\
  --enable-admission-plugins=NodeRestriction,ServiceAccount \\
  --enable-swagger-ui=true \\
  --enable-bootstrap-token-auth=true \\
  --etcd-cafile=/var/lib/kubernetes/ca.crt \\
  --etcd-certfile=/var/lib/kubernetes/etcd-server.crt \\
  --etcd-keyfile=/var/lib/kubernetes/etcd-server.key \\
  --etcd-servers=https://192.168.5.11:2379,https://192.168.5.12:2379 \\
  --event-ttl=1h \\
  --encryption-provider-config=/var/lib/kubernetes/encryption-config.yaml \\
  --kubelet-certificate-authority=/var/lib/kubernetes/ca.crt \\
  --kubelet-client-certificate=/var/lib/kubernetes/kube-apiserver.crt \\
  --kubelet-client-key=/var/lib/kubernetes/kube-apiserver.key \\
  --kubelet-https=true \\
  --runtime-config=api/all \\
  --service-account-key-file=/var/lib/kubernetes/service-account.crt \\
  --service-cluster-ip-range=10.96.0.0/24 \\
  --service-node-port-range=30000-32767 \\
  --tls-cert-file=/var/lib/kubernetes/kube-apiserver.crt \\
  --tls-private-key-file=/var/lib/kubernetes/kube-apiserver.key \\
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```
### Configure the Kubernetes Controller Manager

```bash
sudo mv kube-controller-manager.kubeconfig /var/lib/kubernetes/
```

Create the kube-controller-manager.service systemd unit file:
```bash
cat <<EOF | sudo tee /etc/systemd/system/kube-controller-manager.service
[Unit]
Description=Kubernetes Controller Manager
Documentation=https://github.com/kubernetes/kubernetes

[Service]
ExecStart=/usr/local/bin/kube-controller-manager \\
  --address=0.0.0.0 \\
  --cluster-cidr=192.168.5.0/24 \\
  --cluster-name=kubernetes \\
  --cluster-signing-cert-file=/var/lib/kubernetes/ca.crt \\
  --cluster-signing-key-file=/var/lib/kubernetes/ca.key \\
  --kubeconfig=/var/lib/kubernetes/kube-controller-manager.kubeconfig \\
  --leader-elect=true \\
  --root-ca-file=/var/lib/kubernetes/ca.crt \\
  --service-account-private-key-file=/var/lib/kubernetes/service-account.key \\
  --service-cluster-ip-range=10.96.0.0/24 \\
  --use-service-account-credentials=true \\
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```

### Configure the Kubernetes Scheduler
Move the kube-scheduler kubeconfig into place:
```bash
sudo mv kube-scheduler.kubeconfig /var/lib/kubernetes/
```
Create the kube-scheduler.service systemd unit file:
```bash
cat <<EOF | sudo tee /etc/systemd/system/kube-scheduler.service
[Unit]
Description=Kubernetes Scheduler
Documentation=https://github.com/kubernetes/kubernetes

[Service]
ExecStart=/usr/local/bin/kube-scheduler \\
  --kubeconfig=/var/lib/kubernetes/kube-scheduler.kubeconfig \\
  --address=127.0.0.1 \\
  --leader-elect=true \\
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```
#### Start the Controller Services
```bash
{
  sudo systemctl daemon-reload
  sudo systemctl enable kube-apiserver kube-controller-manager kube-scheduler
  sudo systemctl start kube-apiserver kube-controller-manager kube-scheduler
}
```
> Allow up to 10 seconds for the Kubernetes API Server to fully initialize.

### Verification
```bash
kubectl get componentstatuses --kubeconfig admin.kubeconfig
```

```bash
NAME                 STATUS    MESSAGE              ERROR
controller-manager   Healthy   ok
scheduler            Healthy   ok
etcd-0               Healthy   {"health": "true"}
etcd-1               Healthy   {"health": "true"}
```

## The Kubernetes Frontend Load Balancer
In this section you will provision an external load balancer to front the Kubernetes API Servers. The kubernetes-the-hard-way static IP address will be attached to the resulting load balancer.

Provision a Network Load Balancer
#Install HAProxy
loadbalancer# sudo apt-get update && sudo apt-get install -y haproxy

loadbalancer# cat <<EOF | sudo tee /etc/haproxy/haproxy.cfg 
frontend kubernetes
    bind 192.168.5.30:6443
    option tcplog
    mode tcp
    default_backend kubernetes-master-nodes

backend kubernetes-master-nodes
    mode tcp
    balance roundrobin
    option tcp-check
    server master-1 192.168.5.11:6443 check fall 3 rise 2
    server master-2 192.168.5.12:6443 check fall 3 rise 2
EOF
loadbalancer# sudo service haproxy restart
Verification
Make a HTTP request for the Kubernetes version info:

curl  https://192.168.5.30:6443/version -k
output

{
  "major": "1",
  "minor": "13",
  "gitVersion": "v1.13.0",
  "gitCommit": "ddf47ac13c1a9483ea035a79cd7c10005ff21a6d",
  "gitTreeState": "clean",
  "buildDate": "2018-12-03T20:56:12Z",
  "goVersion": "go1.11.2",
  "compiler": "gc",
  "platform": "linux/amd64"
}