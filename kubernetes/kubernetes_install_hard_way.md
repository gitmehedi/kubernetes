# kubernetes Cluster Installation Hard way



[TOC]



## Document History

```reStructuredText
Document History:
2020-04-05	V1 Arif "Install multi node kubernetes cluster hard way"

```



## Introduction



```bash
Kubernetes 1.13.0
Docker Container Runtime 18.06
CNI Container Networking 0.7.5
Weave Networking
etcd v3.3.9
CoreDNS v1.2.2
```





## Vagrant

### Vagrant status

```bash
arif@ariflindesk1:~/gitRepos/kubernetes-the-hard-way-mmumshad/vagrant$ vagrant global-status
==> vagrant: A new version of Vagrant is available: 2.2.7 (installed version: 2.2.4)!
==> vagrant: To upgrade visit: https://www.vagrantup.com/downloads.html

id       name        provider   state   directory                                               
------------------------------------------------------------------------------------------------
25617d3  p4-tutorial virtualbox running /ext/wdc512/LinuxContent/vagrantVMsRepo/p4_tutorials/vm 
 
The above shows information about all known Vagrant environments
on this machine. This data is cached and may not be completely
up-to-date (use "vagrant global-status --prune" to prune invalid
entries). To interact with any of the machines, you can go to that
directory and run Vagrant, or you can use the ID directly with
Vagrant commands from any directory. For example:
"vagrant destroy 1a2b3c4d"
arif@ariflindesk1:~/gitRepos/kubernetes-the-hard-way-mmumshad/vagrant$ 
```



### Upgrade vagrant 

```bash
$ vagrant -v
Vagrant 2.2.4

wget https://releases.hashicorp.com/vagrant/2.2.7/vagrant_2.2.7_x86_64.deb
double clik on the binary package to install it

$ vagrant -v
Vagrant 2.2.7
```



Setup vagrant environment variable for root & other user to get control config location

```bash
#Final Vagrant Config dir in my linux desktop: 
/ext/wdc512/LinuxContent/vagrantVMsRepo/vagrant.d

#set VAGRANT_HOME dir to find host specific config file
export VAGRANT_HOME=/ext/wdc512/LinuxContent/vagrantVMsRepo/vagrant.d
chown arif:arif -R /ext/wdc512/LinuxContent/vagrantVMsRepo/vagrant.d


#set vagrant path to find prefered config file 
vagMyRepo=/ext/wdc512/LinuxContent/vagrantVMsRepo
export VAGRANT_CWD=$vagMyRepo/kube_hard_way/vagrant

#open virtual box as root user and setup prefered image location
```





## Node Provision



### Provision node

```bash
mkdir -p /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way
cd /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way
cp -rfp ~/gitRepos/kubernetes-the-hard-way-mmumshad/vagrant /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way

/ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant$ sudo vagrant up --provider=virtualbox

Below command is working after upgrading vagrant to 2.2.7
$ sudo vagrant up --provider=virtualbox


arif@ariflindesk1:/ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant$ sudo vagrant status
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
arif@ariflindesk1:/ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant$ 

/ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant# vagrant status


#current directory mount as /vagrant

vagrant destroy 1a2b3c4d

Final Vagrant Config dir in my linux desktop: 
/ext/wdc512/LinuxContent/vagrantVMsRepo/vagrant.d
mv /root/.vagrant.d/ /root/.vagrant.d/

vi /home/arif/.bashrc
export VAGRANT_HOME=/ext/wdc512/LinuxContent/vagrantVMsRepo/vagrant.d
vagMyRepo=/ext/wdc512/LinuxContent/vagrantVMsRepo
export VAGRANT_CWD=$vagMyRepo/kube_hard_way/vagrant

vi /root/.bashrc
export VAGRANT_HOME=/ext/wdc512/LinuxContent/vagrantVMsRepo/vagrant.d
vagMyRepo=/ext/wdc512/LinuxContent/vagrantVMsRepo
export VAGRANT_CWD=$vagMyRepo/kube_hard_way/vagrant

vagrant up

arif@ariflindesk1:/ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant$ vagrant status
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
arif@ariflindesk1:/ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant$ vagrant global-status
id       name         provider   state    directory                                                     
--------------------------------------------------------------------------------------------------------
25617d3  p4-tutorial  virtualbox poweroff /ext/wdc512/LinuxContent/vagrantVMsRepo/p4_tutorials/vm       
298f0ca  master-1     virtualbox running  /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant 
b500b68  master-2     virtualbox running  /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant 
b1648ef  master-3     virtualbox running  /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant 
ecac746  loadbalancer virtualbox running  /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant 
3d24c00  worker-1     virtualbox running  /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant 
85a4d2e  worker-2     virtualbox running  /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant 
7f9ca91  worker-3     virtualbox running  /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant 
4eea07a  worker-4     virtualbox running  /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant 
 
The above shows information about all known Vagrant environments
on this machine. This data is cached and may not be completely
up-to-date (use "vagrant global-status --prune" to prune invalid
entries). To interact with any of the machines, you can go to that
directory and run Vagrant, or you can use the ID directly with
Vagrant commands from any directory. For example:
"vagrant destroy 1a2b3c4d"
arif@ariflindesk1:/ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant$ 

```



<br>

## Installing the Client Tools

login to master-1 node as vagrant and generate private/public keys

```bash
ssh-keygen
```

```bash
vagrant@master-1:~$ cat .ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8flC9WztSF3K0s5oATgeP9ZiASnP/qnKaP4gkK5XEYeiyy8vIpiWtNT67dPqDnUuE4yBJIAni50YnXJKPrsSdubMUs/k1y/M/iRosd9NJS7YZbanlfrt1AcqvyLgzfcXX0Xm/RxgXYmHN9kW1LJTSJrD2IA39ceT3oUHPJnb62vxXE8ZsnLlwjcVYwylwWsL8QVlvFX+5dXGryJnLRnd56562YX2AShEm8oapamMo2Lw7B1YqYx4AGc8WFDi2LlHC2qUO0nAOK9XGVyo+VjEuZUD8+EQ9ohC6N0SPnWNOBlbXjRL29N68AvTtPeXPDRg6Mu4eBM/oVDFTQNAwwLm5 vagrant@master-1
vagrant@master-1:~$ 
```

```bash
cat >> ~/.ssh/authorized_keys <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8flC9WztSF3K0s5oATgeP9ZiASnP/qnKaP4gkK5XEYeiyy8vIpiWtNT67dPqDnUuE4yBJIAni50YnXJKPrsSdubMUs/k1y/M/iRosd9NJS7YZbanlfrt1AcqvyLgzfcXX0Xm/RxgXYmHN9kW1LJTSJrD2IA39ceT3oUHPJnb62vxXE8ZsnLlwjcVYwylwWsL8QVlvFX+5dXGryJnLRnd56562YX2AShEm8oapamMo2Lw7B1YqYx4AGc8WFDi2LlHC2qUO0nAOK9XGVyo+VjEuZUD8+EQ9ohC6N0SPnWNOBlbXjRL29N68AvTtPeXPDRg6Mu4eBM/oVDFTQNAwwLm5 vagrant@master-1
EOF
```



Get stable version information

```bash
vagrant@master-1:~$ curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt
v1.18.0

```



Get latest kubectl -

```bash
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

$ kubectl version --client
Client Version: version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.0", GitCommit:"9e991415386e4cf155a24b1da15becaa390438d8", GitTreeState:"clean", BuildDate:"2020-03-25T14:58:59Z", GoVersion:"go1.13.8", Compiler:"gc", Platform:"linux/amd64"}
```



<br>



## Certificate Authority and TLS Certificates



```bash
- CA
- TLS Certificate

Componet: etcd, kube-apiserver, kube-controller-manager, kube-scheduler, kubelet, and kube-proxy
```



#### Certificate Authority

Create a directory to keep all the certificate -

```bash
mkdir -p ~/pki
cd ~/pki
```



Generate CA certificate and key -

```bash
#Create blank file otherwise openssl will generate error
touch ~/.rnd

# Create private key for CA
openssl genrsa -out ca.key 2048

# Create CSR using the private key
openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr

# Self sign the csr using its own private key
openssl x509 -req -in ca.csr -signkey ca.key -CAcreateserial  -out ca.crt -days 10000
```



#### Admin client Certificate

```bash
# Generate private key for admin user
openssl genrsa -out admin.key 2048

# Generate CSR for admin user. Note the OU.
openssl req -new -key admin.key -subj "/CN=admin/O=system:masters" -out admin.csr

# Sign certificate for admin user using CA servers private key
openssl x509 -req -in admin.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out admin.crt -days 10000
```



#### The Controller Manager Client Certificate

```bash
openssl genrsa -out kube-controller-manager.key 2048
openssl req -new -key kube-controller-manager.key -subj "/CN=system:kube-controller-manager" -out kube-controller-manager.csr
openssl x509 -req -in kube-controller-manager.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out kube-controller-manager.crt -days 10000
```



#### The Kube Proxy Client Certificate

```bash
openssl genrsa -out kube-proxy.key 2048
openssl req -new -key kube-proxy.key -subj "/CN=system:kube-proxy" -out kube-proxy.csr
openssl x509 -req -in kube-proxy.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out kube-proxy.crt -days 10000
```



#### The Scheduler Client Certificate

```bash
openssl genrsa -out kube-scheduler.key 2048
openssl req -new -key kube-scheduler.key -subj "/CN=system:kube-scheduler" -out kube-scheduler.csr
openssl x509 -req -in kube-scheduler.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out kube-scheduler.crt -days 10000
```



#### The Kubernetes API Server Certificate

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



```bash
openssl genrsa -out kube-apiserver.key 2048
openssl req -new -key kube-apiserver.key -subj "/CN=kube-apiserver" -out kube-apiserver.csr -config openssl.cnf
openssl x509 -req -in kube-apiserver.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out kube-apiserver.crt -extensions v3_req -extfile openssl.cnf -days 10000
```



#### The ETCD Server Certificate

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



```bash
openssl genrsa -out etcd-server.key 2048
openssl req -new -key etcd-server.key -subj "/CN=etcd-server" -out etcd-server.csr -config openssl-etcd.cnf
openssl x509 -req -in etcd-server.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out etcd-server.crt -extensions v3_req -extfile openssl-etcd.cnf -days 10000
```



#### The Service Account Key Pair

```bash
openssl genrsa -out service-account.key 2048
openssl req -new -key service-account.key -subj "/CN=service-accounts" -out service-account.csr
openssl x509 -req -in service-account.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out service-account.crt -days 10000
```



#### Distribute the Certificates

```bash
cd ~/pki
for instance in master-1 master-2 master-3; do
  scp ca.crt ca.key kube-apiserver.key kube-apiserver.crt \
    service-account.key service-account.crt \
    etcd-server.key etcd-server.crt \
    ${instance}:~/
done
```



<br>





## Generating Kubernetes Configuration Files for Authentication



We will generate kubeconfig files for the `controller manager`, `kubelet`, `kube-proxy`, and `scheduler` clients and the `admin` user.



#### Kubernetes Public IP Address

```bash
LOADBALANCER_ADDRESS=192.168.57.30
```



#### The kube-proxy Kubernetes Configuration File

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



```bash
vagrant@master-1:~/pki$ {
>   kubectl config set-cluster kubernetes-the-hard-way \
>     --certificate-authority=ca.crt \
>     --embed-certs=true \
>     --server=https://${LOADBALANCER_ADDRESS}:6443 \
>     --kubeconfig=kube-proxy.kubeconfig
> 
>   kubectl config set-credentials system:kube-proxy \
>     --client-certificate=kube-proxy.crt \
>     --client-key=kube-proxy.key \
>     --embed-certs=true \
>     --kubeconfig=kube-proxy.kubeconfig
> 
>   kubectl config set-context default \
>     --cluster=kubernetes-the-hard-way \
>     --user=system:kube-proxy \
>     --kubeconfig=kube-proxy.kubeconfig
> 
>   kubectl config use-context default --kubeconfig=kube-proxy.kubeconfig
> }
Cluster "kubernetes-the-hard-way" set.
User "system:kube-proxy" set.
Context "default" created.
Switched to context "default".
vagrant@master-1:~/pki$ 

```



#### The kube-controller-manager Kubernetes Configuration File

```bash
cd ~/pki
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



#### The kube-scheduler Kubernetes Configuration File

```bash
cd ~/pki
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



#### The admin Kubernetes Configuration File

```bash
cd ~/pki
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



```bash
vagrant@master-1:~/pki$ ls *.kubeconfig
admin.kubeconfig  kube-controller-manager.kubeconfig  kube-proxy.kubeconfig  kube-scheduler.kubeconfig
vagrant@master-1:~/pki$ 
```



#### Distribute the Kubernetes Configuration Files

Copy the appropriate `kube-proxy` kubeconfig files to each worker instance:

```bash
for instance in worker-1 worker-2; do
  scp kube-proxy.kubeconfig ${instance}:~/
done
```



Copy the appropriate `kube-controller-manager` and `kube-scheduler` kubeconfig files to each controller instance:

```bash
for instance in master-1 master-2 master-3; do
  scp admin.kubeconfig kube-controller-manager.kubeconfig kube-scheduler.kubeconfig ${instance}:~/
done
```

<br>





## Generating the Data Encryption Config and Key

### The Encryption Key

```bash
ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)
```

### The Encryption Config File

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

Copy the `encryption-config.yaml` encryption config file to each controller instance:

```bash
for instance in master-1 master-2 master-3; do
  scp encryption-config.yaml ${instance}:~/
done
```

<br>



## Bootstrapping the etcd Cluster

Check latest release of etcd binary`https://github.com/etcd-io/etcd/releases`.

### Download and Install etcd

Download `etcd` software:

```bash
ETCD_VER=v3.4.7
# choose either URL
GOOGLE_URL=https://storage.googleapis.com/etcd
GITHUB_URL=https://github.com/etcd-io/etcd/releases/download
DOWNLOAD_URL=${GOOGLE_URL}

curl -L ${DOWNLOAD_URL}/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz -o ~/etcd-${ETCD_VER}-linux-amd64.tar.gz
```



Extract and install the `etcd` server and the `etcdctl` command line utility:

```bash
ETCD_VER=v3.4.7
{
  tar -xf etcd-${ETCD_VER}-linux-amd64.tar.gz
  sudo mv etcd-${ETCD_VER}-linux-amd64/etcd* /usr/local/bin/
}

{
/usr/local/bin/etcd --version
/usr/local/bin/etcdctl version
}
```



### Configure the etcd Server

```bash
{
  sudo mkdir -p /etc/etcd /var/lib/etcd
  sudo cp ca.crt etcd-server.key etcd-server.crt /etc/etcd/
}
```



```bash
INTERNAL_IP=$(ip addr show enp0s8 | grep "inet " | awk '{print $2}' | cut -d / -f 1)
ETCD_NAME=$(hostname -s)
```

Create the `etcd.service` systemd unit file:

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
  --initial-cluster master-1=https://192.168.57.11:2380,master-2=https://192.168.57.12:2380,master-3=https://192.168.57.13:2380 \\
  --initial-cluster-state new \\
  --data-dir=/var/lib/etcd
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```

### Start the etcd Server

```bash
{
  sudo systemctl daemon-reload
  sudo systemctl enable etcd
  sudo systemctl start etcd
  sudo systemctl status etcd
}
```



### etcd server verification

```bash
sudo ETCDCTL_API=3 etcdctl member list \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/etcd/ca.crt \
  --cert=/etc/etcd/etcd-server.crt \
  --key=/etc/etcd/etcd-server.key
```



```bash
4357819c96acc3ce, started, master-1, https://192.168.57.11:2380, https://192.168.57.11:2379, false
5140aead4f7edcf3, started, master-3, https://192.168.57.13:2380, , false
ab0f9bf91eb36640, started, master-2, https://192.168.57.12:2380, https://192.168.57.12:2379, false
```

```bash
4357819c96acc3ce, started, master-1, https://192.168.57.11:2380, https://192.168.57.11:2379, false
5140aead4f7edcf3, started, master-3, https://192.168.57.13:2380, https://192.168.57.13:2379, false
ab0f9bf91eb36640, started, master-2, https://192.168.57.12:2380, https://192.168.57.12:2379, false
```



<br>



## Bootstrapping the Kubernetes Control Plane







## References

1. https://github.com/mmumshad/kubernetes-the-hard-way
2. 



## Appendix

```bash
arif@ariflindesk1:/ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant$ rm -rf .vagrant/
arif@ariflindesk1:/ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant$ vagrant status
Current machine states:

master-1                  not created (virtualbox)
master-2                  not created (virtualbox)
master-3                  not created (virtualbox)
loadbalancer              not created (virtualbox)
worker-1                  not created (virtualbox)
worker-2                  not created (virtualbox)
worker-3                  not created (virtualbox)
worker-4                  not created (virtualbox)

This environment represents multiple VMs. The VMs are all listed
above with their current state. For more information about a specific
VM, run `vagrant status NAME`.
arif@ariflindesk1:/ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant$ vagrant up
Bringing machine 'master-1' up with 'virtualbox' provider...
Bringing machine 'master-2' up with 'virtualbox' provider...
Bringing machine 'master-3' up with 'virtualbox' provider...
Bringing machine 'loadbalancer' up with 'virtualbox' provider...
Bringing machine 'worker-1' up with 'virtualbox' provider...
Bringing machine 'worker-2' up with 'virtualbox' provider...
Bringing machine 'worker-3' up with 'virtualbox' provider...
Bringing machine 'worker-4' up with 'virtualbox' provider...
==> master-1: Box 'ubuntu/bionic64' could not be found. Attempting to find and install...
    master-1: Box Provider: virtualbox
    master-1: Box Version: >= 0
==> master-1: Loading metadata for box 'ubuntu/bionic64'
    master-1: URL: https://vagrantcloud.com/ubuntu/bionic64
==> master-1: Adding box 'ubuntu/bionic64' (v20200402.0.0) for provider: virtualbox
    master-1: Downloading: https://vagrantcloud.com/ubuntu/boxes/bionic64/versions/20200402.0.0/providers/virtualbox.box
    master-1: Download redirected to host: cloud-images.ubuntu.com
==> master-1: Successfully added box 'ubuntu/bionic64' (v20200402.0.0) for 'virtualbox'!
==> master-1: Importing base box 'ubuntu/bionic64'...
==> master-1: Matching MAC address for NAT networking...
==> master-1: Setting the name of the VM: kubernetes-ha-master-1
Vagrant is currently configured to create VirtualBox synced folders with
the `SharedFoldersEnableSymlinksCreate` option enabled. If the Vagrant
guest is not trusted, you may want to disable this option. For more
information on this option, please refer to the VirtualBox manual:

  https://www.virtualbox.org/manual/ch04.html#sharedfolders

This option can be disabled globally with an environment variable:

  VAGRANT_DISABLE_VBOXSYMLINKCREATE=1

or on a per folder basis within the Vagrantfile:

  config.vm.synced_folder '/host/path', '/guest/path', SharedFoldersEnableSymlinksCreate: false
==> master-1: Clearing any previously set network interfaces...
==> master-1: Preparing network interfaces based on configuration...
    master-1: Adapter 1: nat
    master-1: Adapter 2: hostonly
==> master-1: Forwarding ports...
    master-1: 22 (guest) => 2711 (host) (adapter 1)
    master-1: 22 (guest) => 2222 (host) (adapter 1)
==> master-1: Running 'pre-boot' VM customizations...
==> master-1: Booting VM...
==> master-1: Waiting for machine to boot. This may take a few minutes...
    master-1: SSH address: 127.0.0.1:2222
    master-1: SSH username: vagrant
    master-1: SSH auth method: private key
    master-1: 
    master-1: Vagrant insecure key detected. Vagrant will automatically replace
    master-1: this with a newly generated keypair for better security.
    master-1: 
    master-1: Inserting generated public key within guest...
    master-1: Removing insecure key from the guest if it's present...
    master-1: Key inserted! Disconnecting and reconnecting using new SSH key...
==> master-1: Machine booted and ready!
==> master-1: Checking for guest additions in VM...
    master-1: The guest additions on this VM do not match the installed version of
    master-1: VirtualBox! In most cases this is fine, but in rare cases it can
    master-1: prevent things such as shared folders from working properly. If you see
    master-1: shared folder errors, please make sure the guest additions within the
    master-1: virtual machine match the version of VirtualBox you have installed on
    master-1: your host and reload your VM.
    master-1: 
    master-1: Guest Additions Version: 5.2.34
    master-1: VirtualBox Version: 6.1
==> master-1: Setting hostname...
==> master-1: Configuring and enabling network interfaces...
==> master-1: Mounting shared folders...
    master-1: /vagrant => /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant
==> master-1: Running provisioner: setup-hosts (shell)...
    master-1: Running: /tmp/vagrant-shell20200406-8383-1meyzbs.sh
==> master-1: Running provisioner: setup-dns (shell)...
    master-1: Running: /tmp/vagrant-shell20200406-8383-1xc79og.sh
==> master-2: Box 'ubuntu/bionic64' could not be found. Attempting to find and install...
    master-2: Box Provider: virtualbox
    master-2: Box Version: >= 0
==> master-2: Loading metadata for box 'ubuntu/bionic64'
    master-2: URL: https://vagrantcloud.com/ubuntu/bionic64
==> master-2: Adding box 'ubuntu/bionic64' (v20200402.0.0) for provider: virtualbox
==> master-2: Importing base box 'ubuntu/bionic64'...
==> master-2: Matching MAC address for NAT networking...
==> master-2: Setting the name of the VM: kubernetes-ha-master-2
==> master-2: Fixed port collision for 22 => 2222. Now on port 2200.
==> master-2: Clearing any previously set network interfaces...
==> master-2: Preparing network interfaces based on configuration...
    master-2: Adapter 1: nat
    master-2: Adapter 2: hostonly
==> master-2: Forwarding ports...
    master-2: 22 (guest) => 2712 (host) (adapter 1)
    master-2: 22 (guest) => 2200 (host) (adapter 1)
==> master-2: Running 'pre-boot' VM customizations...
==> master-2: Booting VM...
==> master-2: Waiting for machine to boot. This may take a few minutes...
    master-2: SSH address: 127.0.0.1:2200
    master-2: SSH username: vagrant
    master-2: SSH auth method: private key
    master-2: 
    master-2: Vagrant insecure key detected. Vagrant will automatically replace
    master-2: this with a newly generated keypair for better security.
    master-2: 
    master-2: Inserting generated public key within guest...
    master-2: Removing insecure key from the guest if it's present...
    master-2: Key inserted! Disconnecting and reconnecting using new SSH key...
==> master-2: Machine booted and ready!
==> master-2: Checking for guest additions in VM...
    master-2: The guest additions on this VM do not match the installed version of
    master-2: VirtualBox! In most cases this is fine, but in rare cases it can
    master-2: prevent things such as shared folders from working properly. If you see
    master-2: shared folder errors, please make sure the guest additions within the
    master-2: virtual machine match the version of VirtualBox you have installed on
    master-2: your host and reload your VM.
    master-2: 
    master-2: Guest Additions Version: 5.2.34
    master-2: VirtualBox Version: 6.1
==> master-2: Setting hostname...
==> master-2: Configuring and enabling network interfaces...
==> master-2: Mounting shared folders...
    master-2: /vagrant => /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant
==> master-2: Running provisioner: setup-hosts (shell)...
    master-2: Running: /tmp/vagrant-shell20200406-8383-8dwgi5.sh
==> master-2: Running provisioner: setup-dns (shell)...
    master-2: Running: /tmp/vagrant-shell20200406-8383-7luyc6.sh
==> master-3: Box 'ubuntu/bionic64' could not be found. Attempting to find and install...
    master-3: Box Provider: virtualbox
    master-3: Box Version: >= 0
==> master-3: Loading metadata for box 'ubuntu/bionic64'
    master-3: URL: https://vagrantcloud.com/ubuntu/bionic64
==> master-3: Adding box 'ubuntu/bionic64' (v20200402.0.0) for provider: virtualbox
==> master-3: Importing base box 'ubuntu/bionic64'...
==> master-3: Matching MAC address for NAT networking...
==> master-3: Setting the name of the VM: kubernetes-ha-master-3
==> master-3: Fixed port collision for 22 => 2222. Now on port 2201.
==> master-3: Clearing any previously set network interfaces...
==> master-3: Preparing network interfaces based on configuration...
    master-3: Adapter 1: nat
    master-3: Adapter 2: hostonly
==> master-3: Forwarding ports...
    master-3: 22 (guest) => 2713 (host) (adapter 1)
    master-3: 22 (guest) => 2201 (host) (adapter 1)
==> master-3: Running 'pre-boot' VM customizations...
==> master-3: Booting VM...
==> master-3: Waiting for machine to boot. This may take a few minutes...
    master-3: SSH address: 127.0.0.1:2201
    master-3: SSH username: vagrant
    master-3: SSH auth method: private key
    master-3: 
    master-3: Vagrant insecure key detected. Vagrant will automatically replace
    master-3: this with a newly generated keypair for better security.
    master-3: 
    master-3: Inserting generated public key within guest...
    master-3: Removing insecure key from the guest if it's present...
    master-3: Key inserted! Disconnecting and reconnecting using new SSH key...
==> master-3: Machine booted and ready!
==> master-3: Checking for guest additions in VM...
    master-3: The guest additions on this VM do not match the installed version of
    master-3: VirtualBox! In most cases this is fine, but in rare cases it can
    master-3: prevent things such as shared folders from working properly. If you see
    master-3: shared folder errors, please make sure the guest additions within the
    master-3: virtual machine match the version of VirtualBox you have installed on
    master-3: your host and reload your VM.
    master-3: 
    master-3: Guest Additions Version: 5.2.34
    master-3: VirtualBox Version: 6.1
==> master-3: Setting hostname...
==> master-3: Configuring and enabling network interfaces...
==> master-3: Mounting shared folders...
    master-3: /vagrant => /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant
==> master-3: Running provisioner: setup-hosts (shell)...
    master-3: Running: /tmp/vagrant-shell20200406-8383-fx114p.sh
==> master-3: Running provisioner: setup-dns (shell)...
    master-3: Running: /tmp/vagrant-shell20200406-8383-adeslk.sh
==> loadbalancer: Box 'ubuntu/bionic64' could not be found. Attempting to find and install...
    loadbalancer: Box Provider: virtualbox
    loadbalancer: Box Version: >= 0
==> loadbalancer: Loading metadata for box 'ubuntu/bionic64'
    loadbalancer: URL: https://vagrantcloud.com/ubuntu/bionic64
==> loadbalancer: Adding box 'ubuntu/bionic64' (v20200402.0.0) for provider: virtualbox
==> loadbalancer: Importing base box 'ubuntu/bionic64'...
==> loadbalancer: Matching MAC address for NAT networking...
==> loadbalancer: Setting the name of the VM: kubernetes-ha-lb
==> loadbalancer: Fixed port collision for 22 => 2222. Now on port 2202.
==> loadbalancer: Clearing any previously set network interfaces...
==> loadbalancer: Preparing network interfaces based on configuration...
    loadbalancer: Adapter 1: nat
    loadbalancer: Adapter 2: hostonly
==> loadbalancer: Forwarding ports...
    loadbalancer: 22 (guest) => 2730 (host) (adapter 1)
    loadbalancer: 22 (guest) => 2202 (host) (adapter 1)
==> loadbalancer: Running 'pre-boot' VM customizations...
==> loadbalancer: Booting VM...
==> loadbalancer: Waiting for machine to boot. This may take a few minutes...
    loadbalancer: SSH address: 127.0.0.1:2202
    loadbalancer: SSH username: vagrant
    loadbalancer: SSH auth method: private key
    loadbalancer: 
    loadbalancer: Vagrant insecure key detected. Vagrant will automatically replace
    loadbalancer: this with a newly generated keypair for better security.
    loadbalancer: 
    loadbalancer: Inserting generated public key within guest...
    loadbalancer: Removing insecure key from the guest if it's present...
    loadbalancer: Key inserted! Disconnecting and reconnecting using new SSH key...
==> loadbalancer: Machine booted and ready!
==> loadbalancer: Checking for guest additions in VM...
    loadbalancer: The guest additions on this VM do not match the installed version of
    loadbalancer: VirtualBox! In most cases this is fine, but in rare cases it can
    loadbalancer: prevent things such as shared folders from working properly. If you see
    loadbalancer: shared folder errors, please make sure the guest additions within the
    loadbalancer: virtual machine match the version of VirtualBox you have installed on
    loadbalancer: your host and reload your VM.
    loadbalancer: 
    loadbalancer: Guest Additions Version: 5.2.34
    loadbalancer: VirtualBox Version: 6.1
==> loadbalancer: Setting hostname...
==> loadbalancer: Configuring and enabling network interfaces...
==> loadbalancer: Mounting shared folders...
    loadbalancer: /vagrant => /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant
==> loadbalancer: Running provisioner: setup-hosts (shell)...
    loadbalancer: Running: /tmp/vagrant-shell20200406-8383-1eqmld1.sh
==> loadbalancer: Running provisioner: setup-dns (shell)...
    loadbalancer: Running: /tmp/vagrant-shell20200406-8383-1vfeg4x.sh
==> worker-1: Box 'ubuntu/bionic64' could not be found. Attempting to find and install...
    worker-1: Box Provider: virtualbox
    worker-1: Box Version: >= 0
==> worker-1: Loading metadata for box 'ubuntu/bionic64'
    worker-1: URL: https://vagrantcloud.com/ubuntu/bionic64
==> worker-1: Adding box 'ubuntu/bionic64' (v20200402.0.0) for provider: virtualbox
==> worker-1: Importing base box 'ubuntu/bionic64'...
==> worker-1: Matching MAC address for NAT networking...
==> worker-1: Setting the name of the VM: kubernetes-ha-worker-1
==> worker-1: Fixed port collision for 22 => 2222. Now on port 2203.
==> worker-1: Clearing any previously set network interfaces...
==> worker-1: Preparing network interfaces based on configuration...
    worker-1: Adapter 1: nat
    worker-1: Adapter 2: hostonly
==> worker-1: Forwarding ports...
    worker-1: 22 (guest) => 2721 (host) (adapter 1)
    worker-1: 22 (guest) => 2203 (host) (adapter 1)
==> worker-1: Running 'pre-boot' VM customizations...
==> worker-1: Booting VM...
==> worker-1: Waiting for machine to boot. This may take a few minutes...
    worker-1: SSH address: 127.0.0.1:2203
    worker-1: SSH username: vagrant
    worker-1: SSH auth method: private key
    worker-1: 
    worker-1: Vagrant insecure key detected. Vagrant will automatically replace
    worker-1: this with a newly generated keypair for better security.
    worker-1: 
    worker-1: Inserting generated public key within guest...
    worker-1: Removing insecure key from the guest if it's present...
    worker-1: Key inserted! Disconnecting and reconnecting using new SSH key...
==> worker-1: Machine booted and ready!
==> worker-1: Checking for guest additions in VM...
    worker-1: The guest additions on this VM do not match the installed version of
    worker-1: VirtualBox! In most cases this is fine, but in rare cases it can
    worker-1: prevent things such as shared folders from working properly. If you see
    worker-1: shared folder errors, please make sure the guest additions within the
    worker-1: virtual machine match the version of VirtualBox you have installed on
    worker-1: your host and reload your VM.
    worker-1: 
    worker-1: Guest Additions Version: 5.2.34
    worker-1: VirtualBox Version: 6.1
==> worker-1: Setting hostname...
==> worker-1: Configuring and enabling network interfaces...
==> worker-1: Mounting shared folders...
    worker-1: /vagrant => /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant
==> worker-1: Running provisioner: setup-hosts (shell)...
    worker-1: Running: /tmp/vagrant-shell20200406-8383-13rzppp.sh
==> worker-1: Running provisioner: setup-dns (shell)...
    worker-1: Running: /tmp/vagrant-shell20200406-8383-hmgbi4.sh
==> worker-1: Running provisioner: install-docker (shell)...
    worker-1: Running: /tmp/vagrant-shell20200406-8383-18u8o2u.sh
    worker-1: # Executing docker install script, commit: 442e66405c304fa92af8aadaa1d9b31bf4b0ad94
    worker-1: + 
    worker-1: sh
    worker-1:  -c
    worker-1:  apt-get update -qq >/dev/null
    worker-1: + sh -c DEBIAN_FRONTEND=noninteractive apt-get install -y -qq apt-transport-https ca-certificates curl >/dev/null
    worker-1: + sh -c curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | apt-key add -qq - >/dev/null
    worker-1: Warning: apt-key output should not be parsed (stdout is not a terminal)
    worker-1: + sh -c echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" > /etc/apt/sources.list.d/docker.list
    worker-1: + sh -c apt-get update -qq >/dev/null
    worker-1: + 
    worker-1: [
    worker-1:  -n
    worker-1:  
    worker-1:  ]
    worker-1: + 
    worker-1: sh
    worker-1:  -c
    worker-1:  apt-get install -y -qq --no-install-recommends docker-ce >/dev/null
    worker-1: dpkg-preconfigure: unable to re-open stdin: No such file or directory
    worker-1: + 
    worker-1: sh
    worker-1:  -c
    worker-1:  docker version
    worker-1: Client: Docker Engine - Community
    worker-1:  Version:
    worker-1:         
    worker-1:    
    worker-1: 19.03.8
    worker-1:  API version:
    worker-1:        
    worker-1: 1.40
    worker-1:  Go version:
    worker-1:         
    worker-1: go1.12.17
    worker-1:  Git commit:
    worker-1:         
    worker-1: afacb8b7f0
    worker-1:  Built:
    worker-1:         
    worker-1:      
    worker-1: Wed Mar 11 01:25:46 2020
    worker-1:  OS/Arch:
    worker-1:         
    worker-1:    
    worker-1: linux/amd64
    worker-1:  Experimental:
    worker-1:       
    worker-1: false
    worker-1: Server: Docker Engine - Community
    worker-1:  Engine:
    worker-1:   Version:
    worker-1:         
    worker-1:   
    worker-1: 19.03.8
    worker-1:   API version:
    worker-1:       
    worker-1: 1.40 (minimum version 1.12)
    worker-1:   Go version:       go1.12.17
    worker-1:   Git commit:       afacb8b7f0
    worker-1:   Built:            Wed Mar 11 01:24:19 2020
    worker-1:   OS/Arch:          linux/amd64
    worker-1:   Experimental:     false
    worker-1:  containerd:
    worker-1:   Version:          1.2.13
    worker-1:   GitCommit:        7ad184331fa3e55e52b890ea95e65ba581ae3429
    worker-1:  runc:
    worker-1:   Version:
    worker-1:           1.0.0-rc10
    worker-1:   GitCommit:        dc9208a3303feef5b3839f4323d9beb36df0a9dd
    worker-1:  docker-init:
    worker-1:   Version:        
    worker-1:   
    worker-1: 0.18.0
    worker-1:   GitCommit:
    worker-1:         fec3683
    worker-1: If you would like to use Docker as a non-root user, you should now consider
    worker-1: adding your user to the "docker" group with something like:
    worker-1: 
    worker-1:   sudo usermod -aG docker your-user
    worker-1: 
    worker-1: Remember that you will have to log out and back in for this to take effect!
    worker-1: 
    worker-1: WARNING: Adding a user to the "docker" group will grant the ability to run
    worker-1:          containers which can be used to obtain root privileges on the
    worker-1:          docker host.
    worker-1:          Refer to https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface
    worker-1:          for more information.
==> worker-1: Running provisioner: allow-bridge-nf-traffic (shell)...
    worker-1: Running: /tmp/vagrant-shell20200406-8383-bbuw85.sh
    worker-1: net.bridge.bridge-nf-call-iptables = 1
==> worker-2: Box 'ubuntu/bionic64' could not be found. Attempting to find and install...
    worker-2: Box Provider: virtualbox
    worker-2: Box Version: >= 0
==> worker-2: Loading metadata for box 'ubuntu/bionic64'
    worker-2: URL: https://vagrantcloud.com/ubuntu/bionic64
==> worker-2: Adding box 'ubuntu/bionic64' (v20200402.0.0) for provider: virtualbox
==> worker-2: Importing base box 'ubuntu/bionic64'...
==> worker-2: Matching MAC address for NAT networking...
==> worker-2: Setting the name of the VM: kubernetes-ha-worker-2
==> worker-2: Fixed port collision for 22 => 2222. Now on port 2204.
==> worker-2: Clearing any previously set network interfaces...
==> worker-2: Preparing network interfaces based on configuration...
    worker-2: Adapter 1: nat
    worker-2: Adapter 2: hostonly
==> worker-2: Forwarding ports...
    worker-2: 22 (guest) => 2722 (host) (adapter 1)
    worker-2: 22 (guest) => 2204 (host) (adapter 1)
==> worker-2: Running 'pre-boot' VM customizations...
==> worker-2: Booting VM...
==> worker-2: Waiting for machine to boot. This may take a few minutes...
    worker-2: SSH address: 127.0.0.1:2204
    worker-2: SSH username: vagrant
    worker-2: SSH auth method: private key
    worker-2: 
    worker-2: Vagrant insecure key detected. Vagrant will automatically replace
    worker-2: this with a newly generated keypair for better security.
    worker-2: 
    worker-2: Inserting generated public key within guest...
    worker-2: Removing insecure key from the guest if it's present...
    worker-2: Key inserted! Disconnecting and reconnecting using new SSH key...
==> worker-2: Machine booted and ready!
==> worker-2: Checking for guest additions in VM...
    worker-2: The guest additions on this VM do not match the installed version of
    worker-2: VirtualBox! In most cases this is fine, but in rare cases it can
    worker-2: prevent things such as shared folders from working properly. If you see
    worker-2: shared folder errors, please make sure the guest additions within the
    worker-2: virtual machine match the version of VirtualBox you have installed on
    worker-2: your host and reload your VM.
    worker-2: 
    worker-2: Guest Additions Version: 5.2.34
    worker-2: VirtualBox Version: 6.1
==> worker-2: Setting hostname...
==> worker-2: Configuring and enabling network interfaces...
==> worker-2: Mounting shared folders...
    worker-2: /vagrant => /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant
==> worker-2: Running provisioner: setup-hosts (shell)...
    worker-2: Running: /tmp/vagrant-shell20200406-8383-16avt4b.sh
==> worker-2: Running provisioner: setup-dns (shell)...
    worker-2: Running: /tmp/vagrant-shell20200406-8383-eem6md.sh
==> worker-2: Running provisioner: install-docker (shell)...
    worker-2: Running: /tmp/vagrant-shell20200406-8383-1dv38pf.sh
    worker-2: # Executing docker install script, commit: 442e66405c304fa92af8aadaa1d9b31bf4b0ad94
    worker-2: + 
    worker-2: sh
    worker-2:  -c
    worker-2:  apt-get update -qq >/dev/null
    worker-2: + sh -c DEBIAN_FRONTEND=noninteractive apt-get install -y -qq apt-transport-https ca-certificates curl >/dev/null
    worker-2: + sh -c curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | apt-key add -qq - >/dev/null
    worker-2: Warning: apt-key output should not be parsed (stdout is not a terminal)
    worker-2: + sh -c echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" > /etc/apt/sources.list.d/docker.list
    worker-2: + sh -c apt-get update -qq >/dev/null
    worker-2: + 
    worker-2: [
    worker-2:  -n
    worker-2:  
    worker-2:  ]
    worker-2: + 
    worker-2: sh
    worker-2:  -c
    worker-2:  apt-get install -y -qq --no-install-recommends docker-ce >/dev/null
    worker-2: dpkg-preconfigure: unable to re-open stdin: No such file or directory
    worker-2: + 
    worker-2: sh
    worker-2:  -c
    worker-2:  docker version
    worker-2: Client: Docker Engine - Community
    worker-2:  Version:
    worker-2:         
    worker-2:    
    worker-2: 19.03.8
    worker-2:  API version:
    worker-2:        
    worker-2: 1.40
    worker-2:  Go version:
    worker-2:         
    worker-2: go1.12.17
    worker-2:  Git commit:
    worker-2:         
    worker-2: afacb8b7f0
    worker-2:  Built:
    worker-2:         
    worker-2:      
    worker-2: Wed Mar 11 01:25:46 2020
    worker-2:  OS/Arch:
    worker-2:         
    worker-2:    
    worker-2: linux/amd64
    worker-2:  Experimental:
    worker-2:       
    worker-2: false
    worker-2: Server: Docker Engine - Community
    worker-2:  Engine:
    worker-2:   Version:
    worker-2:         
    worker-2:   
    worker-2: 19.03.8
    worker-2:   API version:      1.40 (minimum version 1.12)
    worker-2:   Go version:       go1.12.17
    worker-2:   Git commit:       afacb8b7f0
    worker-2:   Built:            Wed Mar 11 01:24:19 2020
    worker-2:   OS/Arch:          linux/amd64
    worker-2:   Experimental:     false
    worker-2:  containerd:
    worker-2:   Version:          1.2.13
    worker-2:   GitCommit:        7ad184331fa3e55e52b890ea95e65ba581ae3429
    worker-2:  runc:
    worker-2:   Version:          1.0.0-rc10
    worker-2:   GitCommit:        dc9208a3303feef5b3839f4323d9beb36df0a9dd
    worker-2:  docker-init:
    worker-2:   Version:          0.18.0
    worker-2:   GitCommit:        fec3683
    worker-2: If you would like to use Docker as a non-root user, you should now consider
    worker-2: adding your user to the "docker" group with something like:
    worker-2: 
    worker-2:   sudo usermod -aG docker your-user
    worker-2: 
    worker-2: Remember that you will have to log out and back in for this to take effect!
    worker-2: 
    worker-2: WARNING: Adding a user to the "docker" group will grant the ability to run
    worker-2:          containers which can be used to obtain root privileges on the
    worker-2:          docker host.
    worker-2:          Refer to https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface
    worker-2:          for more information.
==> worker-2: Running provisioner: allow-bridge-nf-traffic (shell)...
    worker-2: Running: /tmp/vagrant-shell20200406-8383-jvtzjp.sh
    worker-2: net.bridge.bridge-nf-call-iptables = 1
==> worker-3: Box 'ubuntu/bionic64' could not be found. Attempting to find and install...
    worker-3: Box Provider: virtualbox
    worker-3: Box Version: >= 0
==> worker-3: Loading metadata for box 'ubuntu/bionic64'
    worker-3: URL: https://vagrantcloud.com/ubuntu/bionic64
==> worker-3: Adding box 'ubuntu/bionic64' (v20200402.0.0) for provider: virtualbox
==> worker-3: Importing base box 'ubuntu/bionic64'...
==> worker-3: Matching MAC address for NAT networking...
==> worker-3: Setting the name of the VM: kubernetes-ha-worker-3
==> worker-3: Fixed port collision for 22 => 2222. Now on port 2205.
==> worker-3: Clearing any previously set network interfaces...
==> worker-3: Preparing network interfaces based on configuration...
    worker-3: Adapter 1: nat
    worker-3: Adapter 2: hostonly
==> worker-3: Forwarding ports...
    worker-3: 22 (guest) => 2723 (host) (adapter 1)
    worker-3: 22 (guest) => 2205 (host) (adapter 1)
==> worker-3: Running 'pre-boot' VM customizations...
==> worker-3: Booting VM...
==> worker-3: Waiting for machine to boot. This may take a few minutes...
    worker-3: SSH address: 127.0.0.1:2205
    worker-3: SSH username: vagrant
    worker-3: SSH auth method: private key
    worker-3: 
    worker-3: Vagrant insecure key detected. Vagrant will automatically replace
    worker-3: this with a newly generated keypair for better security.
    worker-3: 
    worker-3: Inserting generated public key within guest...
    worker-3: Removing insecure key from the guest if it's present...
    worker-3: Key inserted! Disconnecting and reconnecting using new SSH key...
==> worker-3: Machine booted and ready!
==> worker-3: Checking for guest additions in VM...
    worker-3: The guest additions on this VM do not match the installed version of
    worker-3: VirtualBox! In most cases this is fine, but in rare cases it can
    worker-3: prevent things such as shared folders from working properly. If you see
    worker-3: shared folder errors, please make sure the guest additions within the
    worker-3: virtual machine match the version of VirtualBox you have installed on
    worker-3: your host and reload your VM.
    worker-3: 
    worker-3: Guest Additions Version: 5.2.34
    worker-3: VirtualBox Version: 6.1
==> worker-3: Setting hostname...
==> worker-3: Configuring and enabling network interfaces...
==> worker-3: Mounting shared folders...
    worker-3: /vagrant => /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant
==> worker-3: Running provisioner: setup-hosts (shell)...
    worker-3: Running: /tmp/vagrant-shell20200406-8383-36hufq.sh
==> worker-3: Running provisioner: setup-dns (shell)...
    worker-3: Running: /tmp/vagrant-shell20200406-8383-1u2f6le.sh
==> worker-3: Running provisioner: install-docker (shell)...
    worker-3: Running: /tmp/vagrant-shell20200406-8383-1yd5ebj.sh
    worker-3: # Executing docker install script, commit: 442e66405c304fa92af8aadaa1d9b31bf4b0ad94
    worker-3: + 
    worker-3: sh
    worker-3:  -c
    worker-3:  apt-get update -qq >/dev/null
    worker-3: + sh -c DEBIAN_FRONTEND=noninteractive apt-get install -y -qq apt-transport-https ca-certificates curl >/dev/null
    worker-3: + sh -c curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | apt-key add -qq - >/dev/null
    worker-3: Warning: apt-key output should not be parsed (stdout is not a terminal)
    worker-3: + sh -c echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" > /etc/apt/sources.list.d/docker.list
    worker-3: + sh -c apt-get update -qq >/dev/null
    worker-3: + 
    worker-3: [
    worker-3:  -n
    worker-3:  
    worker-3:  ]
    worker-3: + 
    worker-3: sh
    worker-3:  -c
    worker-3:  apt-get install -y -qq --no-install-recommends docker-ce >/dev/null
    worker-3: dpkg-preconfigure: unable to re-open stdin: No such file or directory
    worker-3: + 
    worker-3: sh
    worker-3:  -c
    worker-3:  docker version
    worker-3: Client: Docker Engine - Community
    worker-3:  Version:
    worker-3:         
    worker-3:    
    worker-3: 19.03.8
    worker-3:  API version:
    worker-3:        
    worker-3: 1.40
    worker-3:  Go version:
    worker-3:         
    worker-3: go1.12.17
    worker-3:  Git commit:
    worker-3:         
    worker-3: afacb8b7f0
    worker-3: 
    worker-3:  Built:             Wed Mar 11 01:25:46 2020
    worker-3:  OS/Arch:           linux/amd64
    worker-3:  Experimental:      false
    worker-3: 
    worker-3: Server: Docker Engine - Community
    worker-3:  Engine:
    worker-3:   Version:          19.03.8
    worker-3:   API version:      1.40 (minimum version 1.12)
    worker-3:   Go version:       go1.12.17
    worker-3:   Git commit:       afacb8b7f0
    worker-3:   Built:            Wed Mar 11 01:24:19 2020
    worker-3:   OS/Arch:          linux/amd64
    worker-3:   Experimental:     false
    worker-3:  containerd:
    worker-3:   Version:          1.2.13
    worker-3:   GitCommit:        7ad184331fa3e55e52b890ea95e65ba581ae3429
    worker-3:  runc:
    worker-3:   Version:          1.0.0-rc10
    worker-3:   GitCommit:        dc9208a3303feef5b3839f4323d9beb36df0a9dd
    worker-3:  docker-init:
    worker-3:   Version:          0.18.0
    worker-3:   GitCommit:        fec3683
    worker-3: If you would like to use Docker as a non-root user, you should now consider
    worker-3: adding your user to the "docker" group with something like:
    worker-3: 
    worker-3:   sudo usermod -aG docker your-user
    worker-3: 
    worker-3: Remember that you will have to log out and back in for this to take effect!
    worker-3: 
    worker-3: WARNING: Adding a user to the "docker" group will grant the ability to run
    worker-3:          containers which can be used to obtain root privileges on the
    worker-3:          docker host.
    worker-3:          Refer to https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface
    worker-3:          for more information.
==> worker-3: Running provisioner: allow-bridge-nf-traffic (shell)...
    worker-3: Running: /tmp/vagrant-shell20200406-8383-egl3qk.sh
    worker-3: net.bridge.bridge-nf-call-iptables = 1
==> worker-4: Box 'ubuntu/bionic64' could not be found. Attempting to find and install...
    worker-4: Box Provider: virtualbox
    worker-4: Box Version: >= 0
==> worker-4: Loading metadata for box 'ubuntu/bionic64'
    worker-4: URL: https://vagrantcloud.com/ubuntu/bionic64
==> worker-4: Adding box 'ubuntu/bionic64' (v20200402.0.0) for provider: virtualbox
==> worker-4: Importing base box 'ubuntu/bionic64'...
==> worker-4: Matching MAC address for NAT networking...
==> worker-4: Setting the name of the VM: kubernetes-ha-worker-4
==> worker-4: Fixed port collision for 22 => 2222. Now on port 2206.
==> worker-4: Clearing any previously set network interfaces...
==> worker-4: Preparing network interfaces based on configuration...
    worker-4: Adapter 1: nat
    worker-4: Adapter 2: hostonly
==> worker-4: Forwarding ports...
    worker-4: 22 (guest) => 2724 (host) (adapter 1)
    worker-4: 22 (guest) => 2206 (host) (adapter 1)
==> worker-4: Running 'pre-boot' VM customizations...
==> worker-4: Booting VM...
==> worker-4: Waiting for machine to boot. This may take a few minutes...
    worker-4: SSH address: 127.0.0.1:2206
    worker-4: SSH username: vagrant
    worker-4: SSH auth method: private key
    worker-4: 
    worker-4: Vagrant insecure key detected. Vagrant will automatically replace
    worker-4: this with a newly generated keypair for better security.
    worker-4: 
    worker-4: Inserting generated public key within guest...
    worker-4: Removing insecure key from the guest if it's present...
    worker-4: Key inserted! Disconnecting and reconnecting using new SSH key...
==> worker-4: Machine booted and ready!
==> worker-4: Checking for guest additions in VM...
    worker-4: The guest additions on this VM do not match the installed version of
    worker-4: VirtualBox! In most cases this is fine, but in rare cases it can
    worker-4: prevent things such as shared folders from working properly. If you see
    worker-4: shared folder errors, please make sure the guest additions within the
    worker-4: virtual machine match the version of VirtualBox you have installed on
    worker-4: your host and reload your VM.
    worker-4: 
    worker-4: Guest Additions Version: 5.2.34
    worker-4: VirtualBox Version: 6.1
==> worker-4: Setting hostname...
==> worker-4: Configuring and enabling network interfaces...
==> worker-4: Mounting shared folders...
    worker-4: /vagrant => /ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant
==> worker-4: Running provisioner: setup-hosts (shell)...
    worker-4: Running: /tmp/vagrant-shell20200406-8383-157gkby.sh
==> worker-4: Running provisioner: setup-dns (shell)...
    worker-4: Running: /tmp/vagrant-shell20200406-8383-ifnoyd.sh
==> worker-4: Running provisioner: install-docker (shell)...
    worker-4: Running: /tmp/vagrant-shell20200406-8383-1vgx65j.sh
    worker-4: # Executing docker install script, commit: 442e66405c304fa92af8aadaa1d9b31bf4b0ad94
    worker-4: + 
    worker-4: sh
    worker-4:  -c
    worker-4:  apt-get update -qq >/dev/null
    worker-4: + sh -c DEBIAN_FRONTEND=noninteractive apt-get install -y -qq apt-transport-https ca-certificates curl >/dev/null
    worker-4: + sh -c curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | apt-key add -qq - >/dev/null
    worker-4: Warning: apt-key output should not be parsed (stdout is not a terminal)
    worker-4: + sh -c echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" > /etc/apt/sources.list.d/docker.list
    worker-4: + sh -c apt-get update -qq >/dev/null
    worker-4: + 
    worker-4: [
    worker-4:  -n
    worker-4:  
    worker-4:  ]
    worker-4: + 
    worker-4: sh
    worker-4:  -c
    worker-4:  apt-get install -y -qq --no-install-recommends docker-ce >/dev/null
    worker-4: dpkg-preconfigure: unable to re-open stdin: No such file or directory
    worker-4: + 
    worker-4: sh -c docker version
    worker-4: Client: Docker Engine - Community
    worker-4:  Version:
    worker-4:         
    worker-4:    
    worker-4: 19.03.8
    worker-4:  API version:
    worker-4:        
    worker-4: 1.40
    worker-4:  Go version:
    worker-4:         
    worker-4: go1.12.17
    worker-4:  Git commit:
    worker-4:         
    worker-4: afacb8b7f0
    worker-4:  Built:
    worker-4:         
    worker-4:      
    worker-4: Wed Mar 11 01:25:46 2020
    worker-4:  OS/Arch:
    worker-4:         
    worker-4:    
    worker-4: linux/amd64
    worker-4:  Experimental:
    worker-4:       
    worker-4: false
    worker-4: Server: Docker Engine - Community
    worker-4:  Engine:
    worker-4:   Version:
    worker-4:         
    worker-4:   
    worker-4: 19.03.8
    worker-4:   API version:
    worker-4:       
    worker-4: 1.40 (minimum version 1.12)
    worker-4:   Go version:
    worker-4:        
    worker-4: go1.12.17
    worker-4:   Git commit:
    worker-4:        
    worker-4: afacb8b7f0
    worker-4:   Built:
    worker-4:             Wed Mar 11 01:24:19 2020
    worker-4:   OS/Arch:
    worker-4:         
    worker-4:   
    worker-4: linux/amd64
    worker-4:   Experimental:
    worker-4:      
    worker-4: false
    worker-4:  containerd:
    worker-4:   Version:
    worker-4:         
    worker-4:   
    worker-4: 1.2.13
    worker-4:   GitCommit:
    worker-4:         
    worker-4: 7ad184331fa3e55e52b890ea95e65ba581ae3429
    worker-4:  runc:
    worker-4:   Version:
    worker-4:         
    worker-4:   
    worker-4: 1.0.0-rc10
    worker-4:   GitCommit:
    worker-4:         
    worker-4: dc9208a3303feef5b3839f4323d9beb36df0a9dd
    worker-4:  docker-init:
    worker-4:   Version:
    worker-4:         
    worker-4:   
    worker-4: 0.18.0
    worker-4:   GitCommit:
    worker-4:         
    worker-4: fec3683
    worker-4: If you would like to use Docker as a non-root user, you should now consider
    worker-4: adding your user to the "docker" group with something like:
    worker-4: 
    worker-4:   sudo usermod -aG docker your-user
    worker-4: 
    worker-4: Remember that you will have to log out and back in for this to take effect!
    worker-4: 
    worker-4: WARNING: Adding a user to the "docker" group will grant the ability to run
    worker-4:          containers which can be used to obtain root privileges on the
    worker-4:          docker host.
    worker-4:          Refer to https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface
    worker-4:          for more information.
==> worker-4: Running provisioner: allow-bridge-nf-traffic (shell)...
    worker-4: Running: /tmp/vagrant-shell20200406-8383-vu92ho.sh
    worker-4: net.bridge.bridge-nf-call-iptables = 1
arif@ariflindesk1:/ext/wdc512/LinuxContent/vagrantVMsRepo/kube_hard_way/vagrant$ v
```

