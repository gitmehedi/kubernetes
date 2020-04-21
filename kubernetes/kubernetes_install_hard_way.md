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
      * [TLS Certificates](#tls-certificate) 

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
1. [Admin Client Certificate](#Admin-Client-Certificate)
2. [Kube API Server Client Certificate](#Kube API Server Client Certificate)
3. [ETCD Server Client Certificate](#ETCD Server Client Certificate)
4. [Scheduler Client Certificate](#Scheduler Client Certificate)
5. [Controller Manager Client Certificate](#Controller Manager Client Certificate)
6. [Kube Proxy Client Certificate](#Kube Proxy Client Certificate)
7. [Service Account Client Certificate](#Service Account Client Certificate)

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
First of all create a openssl.conf file in ```etcd``` server
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
openssl req -new -key etcd-server.key -subj "/CN=etcd-server" -out etcd-server.csr -config openssl-etcd.cnf
```
* Self sign the CSR using it's own private key and generate a certificate for admin user (**etcd-server.crt**)
```bash
vagrant@master-1:~/pki$ openssl x509 -req -in etcd-server.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out etcd-server.crt -extensions v3_req -extfile openssl-etcd.cnf -days 10000
Signature ok
subject=CN = admin, O = system:masters
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
openssl req -new -key etcd-server.key -subj "/CN=etcd-server" -out etcd-server.csr -config openssl-etcd.cnf
```
* Self sign the CSR using it's own private key and generate a certificate for admin user (**etcd-server.crt**)
```bash
vagrant@master-1:~/pki$ openssl x509 -req -in etcd-server.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out etcd-server.crt -extensions v3_req -extfile openssl-etcd.cnf -days 10000
Signature ok
subject=CN = admin, O = system:masters
Getting CA Private Key
```
#### 4. Scheduler Client Certificate
#### 5. Controller Manager Client Certificate
#### 6. Kube Proxy Client Certificate
#### 7. Service Account Client Certificate
