# kubernetes Cluster Installation using Vagrant + VirtualBox

- [kubernetes Cluster Installation using Vagrant + VirtualBox](#kubernetes-cluster-installation-using-vagrant--virtualbox)
  - [Document History](#document-history)
  - [Introduction](#introduction)
  - [Architecture](#architecture)
  - [Provison node using vagrant](#provison-node-using-vagrant)
  - [Kubernetes Cluster Initialization](#kubernetes-cluster-initialization)
    - [Follow below procedure in k18master node if you are using Calico based CNI](#follow-below-procedure-in-k18master-node-if-you-are-using-calico-based-cni)
    - [Follow below procedure in k18master node if you are using Flannel based CNI](#follow-below-procedure-in-k18master-node-if-you-are-using-flannel-based-cni)
    - [Worker node 1](#worker-node-1)
    - [Worker node 2](#worker-node-2)
    - [Basic Verification of kubernetes cluster](#basic-verification-of-kubernetes-cluster)
  - [References](#references)
  - [Further Reading](#further-reading)
  - [Book](#book)
  - [Appendix](#appendix)
    - [Kubernetes cluster initialization log](#kubernetes-cluster-initialization-log)
    - [Kubernetes cluster joining logs for k18worker1](#kubernetes-cluster-joining-logs-for-k18worker1)
    - [Provision logs for k18worker2](#provision-logs-for-k18worker2)
    
    * [Kubernetes cluster joining logs for k18worker1](#kubernetes-cluster-joining-logs-for-k18worker1)
    
    * [Provision logs for k18worker2](#provision-logs-for-k18worker2)
    
      


## Document History

```
Document History:
2022-10-03	V1 Md Mehedi Hasan "Install multi node kubernetes cluster using vagrant"
```



## Introduction

This document provides the procedure to install 3 nodes Kubernetes cluster in Ubuntu 18.04 LTS VM. VMs are provision using vagrant utility, which eventually used virtualbox environment. Download and install [Vagrant](https://www.vagrantup.com/downloads.html)  and [VirtualBox](https://www.virtualbox.org/wiki/Downloads).



## Architecture

Three VMs are taken for the kubernetes cluster setup and assigned fixed IP address from network 192.168.56.0/24 using vagrant.

```bash
#ip plan for kube cluster
k18master		192.168.56.53/24
k18worker1		192.168.56.54/24
k18worker2		192.168.56.55/24
```



As VMs are required internet access to setup necessary package, so added NAT rule in host system using ipables command if you are using linux based host.

```bash
iptables -t nat  -A POSTROUTING -s 192.168.56.0/24 -j MASQUERADE
```



## Provison node using vagrant

Clone repository for provisioning VMs using [Vagrant config file](https://github.com/arif332/KBs.Pub/blob/master/kubernetes/vagrant-k18/Vagrantfile) and [Scripts](https://github.com/arif332/KBs.Pub/blob/master/kubernetes/vagrant-k18). 

```bash
$ git clone https://github.com/arif332/KBs.Pub
$ cd KBs.Pub/kubernetes/vagrant-k18
```

Check VMs status which is 

```bash
$ vagrant status
Current machine states:
k18master                 not created (virtualbox)
k18worker1                not created (virtualbox)
k18worker2                not created (virtualbox)
$
```

Now, provision/initiate VMs as per below commands 

```bash
$ vagrant up k18master
$ vagrant up k18worker1
$ vagrant up k18worker2
```



After node provision, verify that each node can reach other node using IP address and name. Also check default gw, which should be configured using 192.168.56.1 as per information in Vagrantfile.



## Kubernetes Cluster Initialization

### Follow below procedure in k18master node if you are using Calico based CNI

```bash
$ vagrant ssh k18master

$ cat <<EOF | sudo tee kubeadm-config.yaml
apiVersion: kubeadm.k8s.io/v1beta2
kind: ClusterConfiguration
EOF

# initiate kubernetes cluster
$ sudo kubeadm init --config kubeadm-config.yaml

#below procedure to add cluster authentication information in home direcotry
$ mkdir -p $HOME/.kube
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config

# for calico CNI
$ sudo kubectl apply -f https://docs.projectcalico.org/v3.14/manifests/calico.yaml
```



### Follow below procedure in k18master node if you are using Flannel based CNI 

```bash
$ vagrant ssh k18master

$ sudo kubeadm init --pod-network-cidr=10.244.0.0/16

#below procedure to add cluster authentication information in home direcotry
$ mkdir -p $HOME/.kube
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config

# for flanel CNI 
$ sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```



Check node status 

```bash
$ kubectl get nodes
```





### Worker node 1

```bash
$ vagrant ssh k18worker1

#join kubernetes cluster
$ sudo kubeadm join 192.168.56.53:6443 --token jxfu9k.axqd31pqhc72fcfk \
    --discovery-token-ca-cert-hash sha256:fcd8cb0a8020e11a40282a3290228c8c7800b7cb5105fa774c038bce17929698 

```



### Worker node 2

```bash
$ vagrant ssh k18worker1

#join kubernetes cluster
$ sudo kubeadm join 192.168.56.53:6443 --token jxfu9k.axqd31pqhc72fcfk \
    --discovery-token-ca-cert-hash sha256:fcd8cb0a8020e11a40282a3290228c8c7800b7cb5105fa774c038bce17929698 
```



### Basic Verification of kubernetes cluster

```bash
$ vagrant ssh k18worker1

$ kubectl get nodes
$ kubectl get pods --all-namespaces

#create a pod in kubernetes
$ kubectl run nginx --image nginx
$ kubectl expose pod nginx --port=80 --type NodePort
$ kubectl get svc
$ curl -I Worker_Node_IP:NodePort
```

<br><br>



## References

1. https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

2. https://kubernetes.io/docs/setup/production-environment/container-runtimes/

3. https://docs.projectcalico.org/v3.14/manifests/calico.yaml

4. https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

5. https://kubernetes.io/docs/reference/kubectl/cheatsheet/

   



## Further Reading

1. https://github.com/kubernetes/kops/blob/master/docs/getting_started/aws.md
2. https://github.com/kubernetes/kops/blob/master/docs/getting_started/openstack.md
3. https://github.com/arif332/kubernetes-the-hard-way
4. https://kubernetes.io/docs/concepts/cluster-administration/cluster-administration-overview/
5. https://kubernetes.io/docs/reference/kubectl/



## Book

1. https://itjumpstart.files.wordpress.com/2019/09/kubernetes.pdf
2. [https://github.com/indrabasak/Books/blob/master/Kubernetes%20in%20Action.pdf](https://github.com/indrabasak/Books/blob/master/Kubernetes in Action.pdf)
3. https://assets.digitalocean.com/books/kubernetes-for-full-stack-developers.pdf
4. https://www.redhat.com/cms/managed-files/cl-oreilly-kubernetes-operators-ebook-f21452-202001-en_2.pdf
5. https://assets.openshift.com/hubfs/pdfs/Kubernetes_OpenShift.pdf?hsLang=en-us&extIdCarryOver=true&sc_cid=701f2000001OH7iAAG
6. https://github.com/KeKe-Li/book/blob/master/kubernetes/kubernetes.pdf



## Appendix



### Kubernetes cluster initialization log 

```bash

vagrant@k18master:~$ sudo kubeadm config images pull
W0803 16:50:33.204752   16219 configset.go:202] WARNING: kubeadm cannot validate component configs for API groups [kubelet.config.k8s.io kubeproxy.config.k8s.io]
[config/images] Pulled k8s.gcr.io/kube-apiserver:v1.18.6
[config/images] Pulled k8s.gcr.io/kube-controller-manager:v1.18.6
[config/images] Pulled k8s.gcr.io/kube-scheduler:v1.18.6
[config/images] Pulled k8s.gcr.io/kube-proxy:v1.18.6
[config/images] Pulled k8s.gcr.io/pause:3.2
[config/images] Pulled k8s.gcr.io/etcd:3.4.3-0
[config/images] Pulled k8s.gcr.io/coredns:1.6.7
vagrant@k18master:~$
vagrant@k18master:~$

vagrant@k18master:~$ kubeadm config images list
W0803 18:11:02.592018   31299 configset.go:202] WARNING: kubeadm cannot validate component configs for API groups [kubelet.config.k8s.io kubeproxy.config.k8s.io]
k8s.gcr.io/kube-apiserver:v1.18.6
k8s.gcr.io/kube-controller-manager:v1.18.6
k8s.gcr.io/kube-scheduler:v1.18.6
k8s.gcr.io/kube-proxy:v1.18.6
k8s.gcr.io/pause:3.2
k8s.gcr.io/etcd:3.4.3-0
k8s.gcr.io/coredns:1.6.7
vagrant@k18master:~$ sudo docker images
REPOSITORY                           TAG                 IMAGE ID            CREATED             SIZE
k8s.gcr.io/kube-proxy                v1.18.6             c3d62d6fe412        2 weeks ago         117MB
k8s.gcr.io/kube-apiserver            v1.18.6             56acd67ea15a        2 weeks ago         173MB
k8s.gcr.io/kube-controller-manager   v1.18.6             ffce5e64d915        2 weeks ago         162MB
k8s.gcr.io/kube-scheduler            v1.18.6             0e0972b2b5d1        2 weeks ago         95.3MB
k8s.gcr.io/pause                     3.2                 80d28bedfe5d        5 months ago        683kB
k8s.gcr.io/coredns                   1.6.7               67da37a9a360        6 months ago        43.8MB
k8s.gcr.io/etcd                      3.4.3-0             303ce5db0e90        9 months ago        288MB
vagrant@k18master:~$


vagrant@k18master:~$ sudo kubeadm init --config kubeadm-config.yaml
W0803 20:09:40.013947    2299 configset.go:202] WARNING: kubeadm cannot validate component configs for API groups [kubelet.config.k8s.io kubeproxy.config.k8s.io]
[init] Using Kubernetes version: v1.18.6
[preflight] Running pre-flight checks
[preflight] Pulling images required for setting up a Kubernetes cluster
[preflight] This might take a minute or two, depending on the speed of your internet connection
[preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Starting the kubelet
[certs] Using certificateDir folder "/etc/kubernetes/pki"
[certs] Generating "ca" certificate and key
[certs] Generating "apiserver" certificate and key
[certs] apiserver serving cert is signed for DNS names [k18master kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 192.168.56.53]
[certs] Generating "apiserver-kubelet-client" certificate and key
[certs] Generating "front-proxy-ca" certificate and key
[certs] Generating "front-proxy-client" certificate and key
[certs] Generating "etcd/ca" certificate and key
[certs] Generating "etcd/server" certificate and key
[certs] etcd/server serving cert is signed for DNS names [k18master localhost] and IPs [192.168.56.53 127.0.0.1 ::1]
[certs] Generating "etcd/peer" certificate and key
[certs] etcd/peer serving cert is signed for DNS names [k18master localhost] and IPs [192.168.56.53 127.0.0.1 ::1]
[certs] Generating "etcd/healthcheck-client" certificate and key
[certs] Generating "apiserver-etcd-client" certificate and key
[certs] Generating "sa" key and public key
[kubeconfig] Using kubeconfig folder "/etc/kubernetes"
[kubeconfig] Writing "admin.conf" kubeconfig file
[kubeconfig] Writing "kubelet.conf" kubeconfig file
[kubeconfig] Writing "controller-manager.conf" kubeconfig file
[kubeconfig] Writing "scheduler.conf" kubeconfig file
[control-plane] Using manifest folder "/etc/kubernetes/manifests"
[control-plane] Creating static Pod manifest for "kube-apiserver"
[control-plane] Creating static Pod manifest for "kube-controller-manager"
W0803 20:09:44.749155    2299 manifests.go:225] the default kube-apiserver authorization-mode is "Node,RBAC"; using "Node,RBAC"
[control-plane] Creating static Pod manifest for "kube-scheduler"
W0803 20:09:44.749781    2299 manifests.go:225] the default kube-apiserver authorization-mode is "Node,RBAC"; using "Node,RBAC"
[etcd] Creating static Pod manifest for local etcd in "/etc/kubernetes/manifests"
[wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests". This can take up to 4m0s
[apiclient] All control plane components are healthy after 17.010423 seconds
[upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[kubelet] Creating a ConfigMap "kubelet-config-1.18" in namespace kube-system with the configuration for the kubelets in the cluster
[upload-certs] Skipping phase. Please see --upload-certs
[mark-control-plane] Marking the node k18master as control-plane by adding the label "node-role.kubernetes.io/master=''"
[mark-control-plane] Marking the node k18master as control-plane by adding the taints [node-role.kubernetes.io/master:NoSchedule]
[bootstrap-token] Using token: jxfu9k.axqd31pqhc72fcfk
[bootstrap-token] Configuring bootstrap tokens, cluster-info ConfigMap, RBAC Roles
[bootstrap-token] configured RBAC rules to allow Node Bootstrap tokens to get nodes
[bootstrap-token] configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
[bootstrap-token] configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
[bootstrap-token] configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
[bootstrap-token] Creating the "cluster-info" ConfigMap in the "kube-public" namespace
[kubelet-finalize] Updating "/etc/kubernetes/kubelet.conf" to point to a rotatable kubelet client certificate and key
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.56.53:6443 --token jxfu9k.axqd31pqhc72fcfk \
    --discovery-token-ca-cert-hash sha256:fcd8cb0a8020e11a40282a3290228c8c7800b7cb5105fa774c038bce17929698
vagrant@k18master:~$


vagrant@k18master:~$ kubectl apply -f https://docs.projectcalico.org/v3.14/manifests/calico.yaml
configmap/calico-config created
customresourcedefinition.apiextensions.k8s.io/bgpconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/bgppeers.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/blockaffinities.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/clusterinformations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/felixconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/globalnetworkpolicies.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/globalnetworksets.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/hostendpoints.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipamblocks.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipamconfigs.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ipamhandles.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/ippools.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/kubecontrollersconfigurations.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/networkpolicies.crd.projectcalico.org created
customresourcedefinition.apiextensions.k8s.io/networksets.crd.projectcalico.org created
clusterrole.rbac.authorization.k8s.io/calico-kube-controllers created
clusterrolebinding.rbac.authorization.k8s.io/calico-kube-controllers created
clusterrole.rbac.authorization.k8s.io/calico-node created
clusterrolebinding.rbac.authorization.k8s.io/calico-node created
daemonset.apps/calico-node created
serviceaccount/calico-node created
deployment.apps/calico-kube-controllers created
serviceaccount/calico-kube-controllers created
vagrant@k18master:~$


vagrant@k18master:~$ kubectl get nodes
NAME        STATUS   ROLES    AGE    VERSION
k18master   Ready    master   3m2s   v1.18.6
vagrant@k18master:~$ kubectl get nodes -o wide
NAME        STATUS   ROLES    AGE    VERSION   INTERNAL-IP     EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
k18master   Ready    master   3m8s   v1.18.6   192.168.56.53   <none>        Ubuntu 18.04.4 LTS   4.15.0-91-generic   docker://19.3.11
vagrant@k18master:~$


```



### Kubernetes cluster joining logs for k18worker1

```bash

vagrant@k18worker1:~$ sudo kubeadm join 192.168.56.53:6443 --token jxfu9k.axqd31pqhc72fcfk \
>     --discovery-token-ca-cert-hash sha256:fcd8cb0a8020e11a40282a3290228c8c7800b7cb5105fa774c038bce17929698
W0803 20:18:34.971276    2213 join.go:346] [preflight] WARNING: JoinControlPane.controlPlane settings will be ignored when control-plane flag is not set.
[preflight] Running pre-flight checks
[preflight] Reading configuration from the cluster...
[preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
[kubelet-start] Downloading configuration for the kubelet from the "kubelet-config-1.18" ConfigMap in the kube-system namespace
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Starting the kubelet
[kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...

This node has joined the cluster:
* Certificate signing request was sent to apiserver and a response was received.
* The Kubelet was informed of the new secure connection details.

Run 'kubectl get nodes' on the control-plane to see this node join the cluster.

vagrant@k18worker1:~$

vagrant@k18master:~$ kubectl get pods -n kube-system -o wide
NAME                                       READY   STATUS    RESTARTS   AGE   IP              NODE         NOMINATED NODE   READINESS GATES
calico-kube-controllers-65f8bc95db-kt2cb   1/1     Running   0          22m   172.16.101.3    k18master    <none>           <none>
calico-node-d2fql                          1/1     Running   0          22m   192.168.56.53   k18master    <none>           <none>
calico-node-m6wzg                          1/1     Running   0          16m   192.168.56.54   k18worker1   <none>           <none>
coredns-66bff467f8-mj4pj                   1/1     Running   0          24m   172.16.101.1    k18master    <none>           <none>
coredns-66bff467f8-rkcgv                   1/1     Running   0          24m   172.16.101.2    k18master    <none>           <none>
etcd-k18master                             1/1     Running   0          24m   192.168.56.53   k18master    <none>           <none>
kube-apiserver-k18master                   1/1     Running   0          24m   192.168.56.53   k18master    <none>           <none>
kube-controller-manager-k18master          1/1     Running   0          24m   192.168.56.53   k18master    <none>           <none>
kube-proxy-mwtkt                           1/1     Running   0          16m   192.168.56.54   k18worker1   <none>           <none>
kube-proxy-pzjpv                           1/1     Running   0          24m   192.168.56.53   k18master    <none>           <none>
kube-scheduler-k18master                   1/1     Running   0          24m   192.168.56.53   k18master    <none>           <none>
vagrant@k18master:~$

vagrant@k18master:~$ kubectl get nodes -o wide
NAME         STATUS   ROLES    AGE   VERSION   INTERNAL-IP     EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
k18master    Ready    master   26m   v1.18.6   192.168.56.53   <none>        Ubuntu 18.04.4 LTS   4.15.0-91-generic   docker://19.3.11
k18worker1   Ready    <none>   17m   v1.18.1   192.168.56.54   <none>        Ubuntu 18.04.4 LTS   4.15.0-91-generic   docker://19.3.11
vagrant@k18master:~$
```





### Provision logs for k18worker2 

```bash
arif@ariflindesk1:~/gitRepos/KBs/kubernetes/vagrant-k18$ ls
Vagrantfile  k18-docker-install.sh  k18-kube-software-install.sh  setup_hosts.sh  ubuntu-bionic-18.04-cloudimg-console.log
arif@ariflindesk1:~/gitRepos/KBs/kubernetes/vagrant-k18$ vagrant up k18worker2
Bringing machine 'k18worker2' up with 'virtualbox' provider...
==> k18worker2: Importing base box 'ubuntu/bionic64'...
==> k18worker2: Matching MAC address for NAT networking...
==> k18worker2: Setting the name of the VM: k18worker2
==> k18worker2: Fixed port collision for 22 => 2222. Now on port 2202.
==> k18worker2: Clearing any previously set network interfaces...
==> k18worker2: Preparing network interfaces based on configuration...
    k18worker2: Adapter 1: nat
    k18worker2: Adapter 2: hostonly
==> k18worker2: Forwarding ports...
    k18worker2: 22 (guest) => 5522 (host) (adapter 1)
    k18worker2: 22 (guest) => 2202 (host) (adapter 1)
==> k18worker2: Running 'pre-boot' VM customizations...
==> k18worker2: Booting VM...
==> k18worker2: Waiting for machine to boot. This may take a few minutes...
    k18worker2: SSH address: 127.0.0.1:2202
    k18worker2: SSH username: vagrant
    k18worker2: SSH auth method: private key
    k18worker2: Warning: Remote connection disconnect. Retrying...
    k18worker2: Warning: Connection reset. Retrying...
    k18worker2:
    k18worker2: Vagrant insecure key detected. Vagrant will automatically replace
    k18worker2: this with a newly generated keypair for better security.
    k18worker2:
    k18worker2: Inserting generated public key within guest...
    k18worker2: Removing insecure key from the guest if it's present...
    k18worker2: Key inserted! Disconnecting and reconnecting using new SSH key...
==> k18worker2: Machine booted and ready!
==> k18worker2: Checking for guest additions in VM...
    k18worker2: The guest additions on this VM do not match the installed version of
    k18worker2: VirtualBox! In most cases this is fine, but in rare cases it can
    k18worker2: prevent things such as shared folders from working properly. If you see
    k18worker2: shared folder errors, please make sure the guest additions within the
    k18worker2: virtual machine match the version of VirtualBox you have installed on
    k18worker2: your host and reload your VM.
    k18worker2:
    k18worker2: Guest Additions Version: 5.2.34
    k18worker2: VirtualBox Version: 6.1
==> k18worker2: Setting hostname...
==> k18worker2: Configuring and enabling network interfaces...
==> k18worker2: Mounting shared folders...
    k18worker2: /vagrant => /home/arif/gitRepos/KBs/kubernetes/vagrant-k18
==> k18worker2: Running provisioner: shell...
    k18worker2: Running: inline script
==> k18worker2: Running provisioner: shell...
    k18worker2: Running: /tmp/vagrant-shell20200803-73562-cfan5j.sh
==> k18worker2: Running provisioner: shell...
    k18worker2: Running: /tmp/vagrant-shell20200803-73562-1o4x76v.sh
    k18worker2: Hit:1 http://archive.ubuntu.com/ubuntu bionic InRelease
    k18worker2: Get:2 http://security.ubuntu.com/ubuntu bionic-security InRelease [88.7 kB]
    k18worker2: Get:3 http://archive.ubuntu.com/ubuntu bionic-updates InRelease [88.7 kB]
    k18worker2: Get:4 http://archive.ubuntu.com/ubuntu bionic-backports InRelease [74.6 kB]
    k18worker2: Get:5 http://archive.ubuntu.com/ubuntu bionic/universe amd64 Packages [8570 kB]
    k18worker2: Get:6 http://security.ubuntu.com/ubuntu bionic-security/main amd64 Packages [805 kB]
    k18worker2: Get:7 http://security.ubuntu.com/ubuntu bionic-security/main Translation-en [252 kB]
    k18worker2: Get:8 http://security.ubuntu.com/ubuntu bionic-security/restricted amd64 Packages [75.6 kB]
    k18worker2: Get:9 http://security.ubuntu.com/ubuntu bionic-security/restricted Translation-en [16.5 kB]
    k18worker2: Get:10 http://security.ubuntu.com/ubuntu bionic-security/universe amd64 Packages [687 kB]
    k18worker2: Get:11 http://security.ubuntu.com/ubuntu bionic-security/universe Translation-en [227 kB]
    k18worker2: Get:12 http://security.ubuntu.com/ubuntu bionic-security/multiverse amd64 Packages [8112 B]
    k18worker2: Get:13 http://security.ubuntu.com/ubuntu bionic-security/multiverse Translation-en [2852 B]
    k18worker2: Get:14 http://archive.ubuntu.com/ubuntu bionic/universe Translation-en [4941 kB]
    k18worker2: Get:15 http://archive.ubuntu.com/ubuntu bionic/multiverse amd64 Packages [151 kB]
    k18worker2: Get:16 http://archive.ubuntu.com/ubuntu bionic/multiverse Translation-en [108 kB]
    k18worker2: Get:17 http://archive.ubuntu.com/ubuntu bionic-updates/main amd64 Packages [1032 kB]
    k18worker2: Get:18 http://archive.ubuntu.com/ubuntu bionic-updates/main Translation-en [346 kB]
    k18worker2: Get:19 http://archive.ubuntu.com/ubuntu bionic-updates/restricted amd64 Packages [84.7 kB]
    k18worker2: Get:20 http://archive.ubuntu.com/ubuntu bionic-updates/restricted Translation-en [18.7 kB]
    k18worker2: Get:21 http://archive.ubuntu.com/ubuntu bionic-updates/universe amd64 Packages [1097 kB]
    k18worker2: Get:22 http://archive.ubuntu.com/ubuntu bionic-updates/universe Translation-en [342 kB]
    k18worker2: Get:23 http://archive.ubuntu.com/ubuntu bionic-updates/multiverse amd64 Packages [19.2 kB]
    k18worker2: Get:24 http://archive.ubuntu.com/ubuntu bionic-updates/multiverse Translation-en [6712 B]
    k18worker2: Get:25 http://archive.ubuntu.com/ubuntu bionic-backports/main amd64 Packages [7516 B]
    k18worker2: Get:26 http://archive.ubuntu.com/ubuntu bionic-backports/main Translation-en [4764 B]
    k18worker2: Get:27 http://archive.ubuntu.com/ubuntu bionic-backports/universe amd64 Packages [7736 B]
    k18worker2: Get:28 http://archive.ubuntu.com/ubuntu bionic-backports/universe Translation-en [4588 B]
    k18worker2: Fetched 19.1 MB in 38s (500 kB/s)
    k18worker2: Reading package lists...
    k18worker2: Reading package lists...
    k18worker2: Building dependency tree...
    k18worker2:
    k18worker2: Reading state information...
    k18worker2: The following additional packages will be installed:
    k18worker2:   libcurl4 python3-software-properties
    k18worker2: The following NEW packages will be installed:
    k18worker2:   apt-transport-https gnupg2
    k18worker2: The following packages will be upgraded:
    k18worker2:   ca-certificates curl libcurl4 python3-software-properties
    k18worker2:   software-properties-common
    k18worker2: 5 upgraded, 2 newly installed, 0 to remove and 90 not upgraded.
    k18worker2: Need to get 558 kB of archives.
    k18worker2: After this operation, 195 kB of additional disk space will be used.
    k18worker2: Get:1 http://archive.ubuntu.com/ubuntu bionic-updates/main amd64 ca-certificates all 20190110~18.04.1 [146 kB]
    k18worker2: Get:2 http://archive.ubuntu.com/ubuntu bionic-updates/universe amd64 apt-transport-https all 1.6.12ubuntu0.1 [1692 B]
    k18worker2: Get:3 http://archive.ubuntu.com/ubuntu bionic-updates/main amd64 curl amd64 7.58.0-2ubuntu3.9 [159 kB]
    k18worker2: Get:4 http://archive.ubuntu.com/ubuntu bionic-updates/main amd64 libcurl4 amd64 7.58.0-2ubuntu3.9 [214 kB]
    k18worker2: Get:5 http://archive.ubuntu.com/ubuntu bionic-updates/main amd64 software-properties-common all 0.96.24.32.13 [10.0 kB]
    k18worker2: Get:6 http://archive.ubuntu.com/ubuntu bionic-updates/main amd64 python3-software-properties all 0.96.24.32.13 [23.8 kB]
    k18worker2: Get:7 http://archive.ubuntu.com/ubuntu bionic-updates/universe amd64 gnupg2 all 2.2.4-1ubuntu1.2 [4668 B]
    k18worker2: dpkg-preconfigure: unable to re-open stdin: No such file or directory
    k18worker2: Fetched 558 kB in 2s (225 kB/s)
    k18worker2: (Reading database ...
(Reading database ... 55%database ... 5%
    k18worker2: (Reading database ... 60%
    k18worker2: (Reading database ... 65%
    k18worker2: (Reading database ... 70%
    k18worker2: (Reading database ... 75%
    k18worker2: (Reading database ... 80%
    k18worker2: (Reading database ... 85%
    k18worker2: (Reading database ... 90%
    k18worker2: (Reading database ... 95%
(Reading database ... 59743 files and directories currently installed.)
    k18worker2: Preparing to unpack .../0-ca-certificates_20190110~18.04.1_all.deb ...
    k18worker2: Unpacking ca-certificates (20190110~18.04.1) over (20180409) ...
    k18worker2: Selecting previously unselected package apt-transport-https.
    k18worker2: Preparing to unpack .../1-apt-transport-https_1.6.12ubuntu0.1_all.deb ...
    k18worker2: Unpacking apt-transport-https (1.6.12ubuntu0.1) ...
    k18worker2: Preparing to unpack .../2-curl_7.58.0-2ubuntu3.9_amd64.deb ...
    k18worker2: Unpacking curl (7.58.0-2ubuntu3.9) over (7.58.0-2ubuntu3.8) ...
    k18worker2: Preparing to unpack .../3-libcurl4_7.58.0-2ubuntu3.9_amd64.deb ...
    k18worker2: Unpacking libcurl4:amd64 (7.58.0-2ubuntu3.9) over (7.58.0-2ubuntu3.8) ...
    k18worker2: Preparing to unpack .../4-software-properties-common_0.96.24.32.13_all.deb ...
    k18worker2: Unpacking software-properties-common (0.96.24.32.13) over (0.96.24.32.12) ...
    k18worker2: Preparing to unpack .../5-python3-software-properties_0.96.24.32.13_all.deb ...
    k18worker2: Unpacking python3-software-properties (0.96.24.32.13) over (0.96.24.32.12) ...
    k18worker2: Selecting previously unselected package gnupg2.
    k18worker2: Preparing to unpack .../6-gnupg2_2.2.4-1ubuntu1.2_all.deb ...
    k18worker2: Unpacking gnupg2 (2.2.4-1ubuntu1.2) ...
    k18worker2: Setting up apt-transport-https (1.6.12ubuntu0.1) ...
    k18worker2: Setting up libcurl4:amd64 (7.58.0-2ubuntu3.9) ...
    k18worker2: Setting up gnupg2 (2.2.4-1ubuntu1.2) ...
    k18worker2: Setting up python3-software-properties (0.96.24.32.13) ...
    k18worker2: Setting up ca-certificates (20190110~18.04.1) ...
    k18worker2: Updating certificates in /etc/ssl/certs...
    k18worker2: 2 added, 8 removed; done.
    k18worker2: Setting up software-properties-common (0.96.24.32.13) ...
    k18worker2: Setting up curl (7.58.0-2ubuntu3.9) ...
    k18worker2: Processing triggers for man-db (2.8.3-2ubuntu0.1) ...
    k18worker2: Processing triggers for dbus (1.12.2-1ubuntu1.1) ...
    k18worker2: Processing triggers for libc-bin (2.27-3ubuntu1) ...
    k18worker2: Processing triggers for ca-certificates (20190110~18.04.1) ...
    k18worker2: Updating certificates in /etc/ssl/certs...
    k18worker2: 0 added, 0 removed; done.
    k18worker2:
    k18worker2: Running hooks in /etc/ca-certificates/update.d...
    k18worker2: done.
    k18worker2: Warning: apt-key output should not be parsed (stdout is not a terminal)
    k18worker2: OK
    k18worker2: Get:1 https://download.docker.com/linux/ubuntu bionic InRelease [64.4 kB]
    k18worker2: Hit:2 http://archive.ubuntu.com/ubuntu bionic InRelease
    k18worker2: Hit:3 http://security.ubuntu.com/ubuntu bionic-security InRelease
    k18worker2: Get:4 https://download.docker.com/linux/ubuntu bionic/stable amd64 Packages [12.5 kB]
    k18worker2: Hit:5 http://archive.ubuntu.com/ubuntu bionic-updates InRelease
    k18worker2: Hit:6 http://archive.ubuntu.com/ubuntu bionic-backports InRelease
    k18worker2: Fetched 76.9 kB in 2s (49.0 kB/s)
    k18worker2: Reading package lists...
    k18worker2: Hit:1 https://download.docker.com/linux/ubuntu bionic InRelease
    k18worker2: Hit:2 http://archive.ubuntu.com/ubuntu bionic InRelease
    k18worker2: Hit:3 http://security.ubuntu.com/ubuntu bionic-security InRelease
    k18worker2: Hit:4 http://archive.ubuntu.com/ubuntu bionic-updates InRelease
    k18worker2: Hit:5 http://archive.ubuntu.com/ubuntu bionic-backports InRelease
    k18worker2: Reading package lists...
    k18worker2: Reading package lists...
    k18worker2: Building dependency tree...
    k18worker2:
    k18worker2: Reading state information...
    k18worker2: The following additional packages will be installed:
    k18worker2:   aufs-tools cgroupfs-mount libltdl7 pigz
    k18worker2: The following NEW packages will be installed:
    k18worker2:   aufs-tools cgroupfs-mount containerd.io docker-ce docker-ce-cli libltdl7
    k18worker2:   pigz
    k18worker2: 0 upgraded, 7 newly installed, 0 to remove and 90 not upgraded.
    k18worker2: Need to get 85.3 MB of archives.
    k18worker2: After this operation, 381 MB of additional disk space will be used.
    k18worker2: Get:1 https://download.docker.com/linux/ubuntu bionic/stable amd64 containerd.io amd64 1.2.13-2 [21.4 MB]
    k18worker2: Get:2 http://archive.ubuntu.com/ubuntu bionic/universe amd64 pigz amd64 2.4-1 [57.4 kB]
    k18worker2: Get:3 http://archive.ubuntu.com/ubuntu bionic/universe amd64 aufs-tools amd64 1:4.9+20170918-1ubuntu1 [104 kB]
    k18worker2: Get:4 http://archive.ubuntu.com/ubuntu bionic/universe amd64 cgroupfs-mount all 1.4 [6320 B]
    k18worker2: Get:5 http://archive.ubuntu.com/ubuntu bionic/main amd64 libltdl7 amd64 2.4.6-2 [38.8 kB]
    k18worker2: Get:6 https://download.docker.com/linux/ubuntu bionic/stable amd64 docker-ce-cli amd64 5:19.03.11~3-0~ubuntu-bionic [41.2 MB]
    k18worker2: Get:7 https://download.docker.com/linux/ubuntu bionic/stable amd64 docker-ce amd64 5:19.03.11~3-0~ubuntu-bionic [22.5 MB]
    k18worker2: dpkg-preconfigure: unable to re-open stdin: No such file or directory
    k18worker2: Fetched 85.3 MB in 1min 56s (739 kB/s)
    k18worker2: Selecting previously unselected package pigz.
    k18worker2: (Reading database ...
    k18worker2: (Reading database ... 5%
(Reading database ... 45%database ... 10%
(Reading database ... 55%database ... 50%
    k18worker2: (Reading database ... 60%
    k18worker2: (Reading database ... 65%
    k18worker2: (Reading database ... 70%
    k18worker2: (Reading database ... 75%
    k18worker2: (Reading database ... 80%
    k18worker2: (Reading database ... 85%
    k18worker2: (Reading database ... 90%
    k18worker2: (Reading database ... 95%
(Reading database ... 59748 files and directories currently installed.)
    k18worker2: Preparing to unpack .../0-pigz_2.4-1_amd64.deb ...
    k18worker2: Unpacking pigz (2.4-1) ...
    k18worker2: Selecting previously unselected package aufs-tools.
    k18worker2: Preparing to unpack .../1-aufs-tools_1%3a4.9+20170918-1ubuntu1_amd64.deb ...
    k18worker2: Unpacking aufs-tools (1:4.9+20170918-1ubuntu1) ...
    k18worker2: Selecting previously unselected package cgroupfs-mount.
    k18worker2: Preparing to unpack .../2-cgroupfs-mount_1.4_all.deb ...
    k18worker2: Unpacking cgroupfs-mount (1.4) ...
    k18worker2: Selecting previously unselected package containerd.io.
    k18worker2: Preparing to unpack .../3-containerd.io_1.2.13-2_amd64.deb ...
    k18worker2: Unpacking containerd.io (1.2.13-2) ...
    k18worker2: Selecting previously unselected package docker-ce-cli.
    k18worker2: Preparing to unpack .../4-docker-ce-cli_5%3a19.03.11~3-0~ubuntu-bionic_amd64.deb ...
    k18worker2: Unpacking docker-ce-cli (5:19.03.11~3-0~ubuntu-bionic) ...
    k18worker2: Selecting previously unselected package docker-ce.
    k18worker2: Preparing to unpack .../5-docker-ce_5%3a19.03.11~3-0~ubuntu-bionic_amd64.deb ...
    k18worker2: Unpacking docker-ce (5:19.03.11~3-0~ubuntu-bionic) ...
    k18worker2: Selecting previously unselected package libltdl7:amd64.
    k18worker2: Preparing to unpack .../6-libltdl7_2.4.6-2_amd64.deb ...
    k18worker2: Unpacking libltdl7:amd64 (2.4.6-2) ...
    k18worker2: Setting up aufs-tools (1:4.9+20170918-1ubuntu1) ...
    k18worker2: Setting up containerd.io (1.2.13-2) ...
    k18worker2: Created symlink /etc/systemd/system/multi-user.target.wants/containerd.service → /lib/systemd/system/containerd.service.
    k18worker2: Setting up cgroupfs-mount (1.4) ...
    k18worker2: Setting up libltdl7:amd64 (2.4.6-2) ...
    k18worker2: Setting up docker-ce-cli (5:19.03.11~3-0~ubuntu-bionic) ...
    k18worker2: Setting up pigz (2.4-1) ...
    k18worker2: Setting up docker-ce (5:19.03.11~3-0~ubuntu-bionic) ...
    k18worker2: Created symlink /etc/systemd/system/multi-user.target.wants/docker.service → /lib/systemd/system/docker.service.
    k18worker2: Created symlink /etc/systemd/system/sockets.target.wants/docker.socket → /lib/systemd/system/docker.socket.
    k18worker2: Processing triggers for libc-bin (2.27-3ubuntu1) ...
    k18worker2: Processing triggers for systemd (237-3ubuntu10.39) ...
    k18worker2: Processing triggers for man-db (2.8.3-2ubuntu0.1) ...
    k18worker2: Processing triggers for ureadahead (0.100.0-21) ...
    k18worker2: Synchronizing state of docker.service with SysV service script with /lib/systemd/systemd-sysv-install.
    k18worker2: Executing: /lib/systemd/systemd-sysv-install enable docker
==> k18worker2: Running provisioner: shell...
    k18worker2: Running: /tmp/vagrant-shell20200803-73562-i0sphm.sh
    k18worker2: net.bridge.bridge-nf-call-ip6tables = 1
    k18worker2: net.bridge.bridge-nf-call-iptables = 1
    k18worker2: * Applying /etc/sysctl.d/10-console-messages.conf ...
    k18worker2: kernel.printk = 4 4 1 7
    k18worker2: * Applying /etc/sysctl.d/10-ipv6-privacy.conf ...
    k18worker2: net.ipv6.conf.all.use_tempaddr = 2
    k18worker2: net.ipv6.conf.default.use_tempaddr = 2
    k18worker2: * Applying /etc/sysctl.d/10-kernel-hardening.conf ...
    k18worker2: kernel.kptr_restrict = 1
    k18worker2: * Applying /etc/sysctl.d/10-link-restrictions.conf ...
    k18worker2: fs.protected_hardlinks = 1
    k18worker2: fs.protected_symlinks = 1
    k18worker2: * Applying /etc/sysctl.d/10-lxd-inotify.conf ...
    k18worker2: fs.inotify.max_user_instances = 1024
    k18worker2: * Applying /etc/sysctl.d/10-magic-sysrq.conf ...
    k18worker2: kernel.sysrq = 176
    k18worker2: * Applying /etc/sysctl.d/10-network-security.conf ...
    k18worker2: net.ipv4.conf.default.rp_filter = 1
    k18worker2: net.ipv4.conf.all.rp_filter = 1
    k18worker2: net.ipv4.tcp_syncookies = 1
    k18worker2: * Applying /etc/sysctl.d/10-ptrace.conf ...
    k18worker2: kernel.yama.ptrace_scope = 1
    k18worker2: * Applying /etc/sysctl.d/10-zeropage.conf ...
    k18worker2: vm.mmap_min_addr = 65536
    k18worker2: * Applying /usr/lib/sysctl.d/50-default.conf ...
    k18worker2: net.ipv4.conf.all.promote_secondaries = 1
    k18worker2: net.core.default_qdisc = fq_codel
    k18worker2: * Applying /etc/sysctl.d/99-cloudimg-ipv6.conf ...
    k18worker2: net.ipv6.conf.all.use_tempaddr = 0
    k18worker2: net.ipv6.conf.default.use_tempaddr = 0
    k18worker2: * Applying /etc/sysctl.d/99-sysctl.conf ...
    k18worker2: * Applying /etc/sysctl.d/k8s.conf ...
    k18worker2: net.bridge.bridge-nf-call-ip6tables = 1
    k18worker2: net.bridge.bridge-nf-call-iptables = 1
    k18worker2: * Applying /etc/sysctl.conf ...
    k18worker2: Hit:1 https://download.docker.com/linux/ubuntu bionic InRelease
    k18worker2: Hit:2 http://archive.ubuntu.com/ubuntu bionic InRelease
    k18worker2: Hit:3 http://security.ubuntu.com/ubuntu bionic-security InRelease
    k18worker2: Hit:4 http://archive.ubuntu.com/ubuntu bionic-updates InRelease
    k18worker2: Hit:5 http://archive.ubuntu.com/ubuntu bionic-backports InRelease
    k18worker2: Reading package lists...
    k18worker2: Reading package lists...
    k18worker2: Building dependency tree...
    k18worker2:
    k18worker2: Reading state information...
    k18worker2: curl is already the newest version (7.58.0-2ubuntu3.9).
    k18worker2: apt-transport-https is already the newest version (1.6.12ubuntu0.1).
    k18worker2: 0 upgraded, 0 newly installed, 0 to remove and 92 not upgraded.
    k18worker2: Warning: apt-key output should not be parsed (stdout is not a terminal)
    k18worker2: OK
    k18worker2: deb https://apt.kubernetes.io/ kubernetes-xenial main
    k18worker2: Hit:1 https://download.docker.com/linux/ubuntu bionic InRelease
    k18worker2: Hit:2 http://archive.ubuntu.com/ubuntu bionic InRelease
    k18worker2: Hit:3 http://security.ubuntu.com/ubuntu bionic-security InRelease
    k18worker2: Hit:4 http://archive.ubuntu.com/ubuntu bionic-updates InRelease
    k18worker2: Hit:5 http://archive.ubuntu.com/ubuntu bionic-backports InRelease
    k18worker2: Get:6 https://packages.cloud.google.com/apt kubernetes-xenial InRelease [8993 B]
    k18worker2: Get:7 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 Packages [38.8 kB]
    k18worker2: Fetched 47.8 kB in 3s (16.6 kB/s)
    k18worker2: Reading package lists...
    k18worker2: Installing kube* software
    k18worker2: Reading package lists...
    k18worker2: Building dependency tree...
    k18worker2: Reading state information...
    k18worker2: The following additional packages will be installed:
    k18worker2:   conntrack cri-tools kubernetes-cni socat
    k18worker2: The following NEW packages will be installed:
    k18worker2:   conntrack cri-tools kubeadm kubectl kubelet kubernetes-cni socat
    k18worker2: 0 upgraded, 7 newly installed, 0 to remove and 92 not upgraded.
    k18worker2: Need to get 70.6 MB of archives.
    k18worker2: After this operation, 297 MB of additional disk space will be used.
    k18worker2: Get:1 http://archive.ubuntu.com/ubuntu bionic/main amd64 conntrack amd64 1:1.4.4+snapshot20161117-6ubuntu2 [30.6 kB]
    k18worker2: Get:3 http://archive.ubuntu.com/ubuntu bionic/main amd64 socat amd64 1.7.3.2-2ubuntu2 [342 kB]
    k18worker2: Get:2 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 cri-tools amd64 1.13.0-01 [8775 kB]
    k18worker2: Get:4 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubernetes-cni amd64 0.8.6-00 [25.0 MB]
    k18worker2: Get:4 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubernetes-cni amd64 0.8.6-00 [25.0 MB]
    k18worker2: Get:4 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubernetes-cni amd64 0.8.6-00 [25.0 MB]
    k18worker2: Get:5 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubelet amd64 1.18.6-00 [19.4 MB]
    k18worker2: Get:5 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubelet amd64 1.18.6-00 [19.4 MB]
    k18worker2: Get:5 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubelet amd64 1.18.6-00 [19.4 MB]
    k18worker2: Get:6 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubectl amd64 1.18.6-00 [8826 kB]
    k18worker2: Get:7 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubeadm amd64 1.18.6-00 [8167 kB]
    k18worker2: dpkg-preconfigure: unable to re-open stdin: No such file or directory
    k18worker2: Fetched 70.6 MB in 6min 41s (176 kB/s)
    k18worker2: Selecting previously unselected package conntrack.
    k18worker2: (Reading database ...
(Reading database ... 55%database ... 5%
    k18worker2: (Reading database ... 60%
    k18worker2: (Reading database ... 65%
    k18worker2: (Reading database ... 70%
    k18worker2: (Reading database ... 75%
    k18worker2: (Reading database ... 80%
    k18worker2: (Reading database ... 85%
    k18worker2: (Reading database ... 90%
    k18worker2: (Reading database ... 95%
(Reading database ... 60061 files and directories currently installed.)
    k18worker2: Preparing to unpack .../0-conntrack_1%3a1.4.4+snapshot20161117-6ubuntu2_amd64.deb ...
    k18worker2: Unpacking conntrack (1:1.4.4+snapshot20161117-6ubuntu2) ...
    k18worker2: Selecting previously unselected package cri-tools.
    k18worker2: Preparing to unpack .../1-cri-tools_1.13.0-01_amd64.deb ...
    k18worker2: Unpacking cri-tools (1.13.0-01) ...
    k18worker2: Selecting previously unselected package kubernetes-cni.
    k18worker2: Preparing to unpack .../2-kubernetes-cni_0.8.6-00_amd64.deb ...
    k18worker2: Unpacking kubernetes-cni (0.8.6-00) ...
    k18worker2: Selecting previously unselected package socat.
    k18worker2: Preparing to unpack .../3-socat_1.7.3.2-2ubuntu2_amd64.deb ...
    k18worker2: Unpacking socat (1.7.3.2-2ubuntu2) ...
    k18worker2: Selecting previously unselected package kubelet.
    k18worker2: Preparing to unpack .../4-kubelet_1.18.6-00_amd64.deb ...
    k18worker2: Unpacking kubelet (1.18.6-00) ...
    k18worker2: Selecting previously unselected package kubectl.
    k18worker2: Preparing to unpack .../5-kubectl_1.18.6-00_amd64.deb ...
    k18worker2: Unpacking kubectl (1.18.6-00) ...
    k18worker2: Selecting previously unselected package kubeadm.
    k18worker2: Preparing to unpack .../6-kubeadm_1.18.6-00_amd64.deb ...
    k18worker2: Unpacking kubeadm (1.18.6-00) ...
    k18worker2: Setting up conntrack (1:1.4.4+snapshot20161117-6ubuntu2) ...
    k18worker2: Setting up kubernetes-cni (0.8.6-00) ...
    k18worker2: Setting up cri-tools (1.13.0-01) ...
    k18worker2: Setting up socat (1.7.3.2-2ubuntu2) ...
    k18worker2: Setting up kubelet (1.18.6-00) ...
    k18worker2: Created symlink /etc/systemd/system/multi-user.target.wants/kubelet.service → /lib/systemd/system/kubelet.service.
    k18worker2: Setting up kubectl (1.18.6-00) ...
    k18worker2: Setting up kubeadm (1.18.6-00) ...
    k18worker2: Processing triggers for man-db (2.8.3-2ubuntu0.1) ...
    k18worker2: kubelet set on hold.
    k18worker2: kubeadm set on hold.
    k18worker2: kubectl set on hold.
    k18worker2: initialize kubeadm cluster (master node only), in worker node join only command is required from master
    k18worker2: apiVersion: kubeadm.k8s.io/v1beta2
    k18worker2: kind: ClusterConfiguration
arif@ariflindesk1:~/gitRepos/KBs/kubernetes/vagrant-k18$

vagrant@k18worker2:~$ ip r s
default via 192.168.56.1 dev enp0s8
default via 10.0.2.2 dev enp0s3 proto dhcp src 10.0.2.15 metric 100
10.0.2.0/24 dev enp0s3 proto kernel scope link src 10.0.2.15
10.0.2.2 dev enp0s3 proto dhcp scope link src 10.0.2.15 metric 100
172.17.0.0/16 dev docker0 proto kernel scope link src 172.17.0.1 linkdown
192.168.56.0/24 dev enp0s8 proto kernel scope link src 192.168.56.55


vagrant@k18worker2:~$ sudo kubeadm join 192.168.56.53:6443 --token jxfu9k.axqd31pqhc72fcfk \
>     --discovery-token-ca-cert-hash sha256:fcd8cb0a8020e11a40282a3290228c8c7800b7cb5105fa774c038bce17929698
W0803 20:39:38.630623   13868 join.go:346] [preflight] WARNING: JoinControlPane.controlPlane settings will be ignored when control-plane flag is not set.
[preflight] Running pre-flight checks
[preflight] Reading configuration from the cluster...
[preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
[kubelet-start] Downloading configuration for the kubelet from the "kubelet-config-1.18" ConfigMap in the kube-system namespace
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Starting the kubelet
[kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...

This node has joined the cluster:
* Certificate signing request was sent to apiserver and a response was received.
* The Kubelet was informed of the new secure connection details.

Run 'kubectl get nodes' on the control-plane to see this node join the cluster.

vagrant@k18worker2:~$

vagrant@k18master:~$ kubectl get pods -A -o wide
NAMESPACE     NAME                                       READY   STATUS    RESTARTS   AGE   IP              NODE         NOMINATED NODE   READINESS GATES
kube-system   calico-kube-controllers-65f8bc95db-kt2cb   1/1     Running   0          38m   172.16.101.3    k18master    <none>           <none>
kube-system   calico-node-bpsfh                          1/1     Running   0          11m   192.168.56.55   k18worker2   <none>           <none>
kube-system   calico-node-d2fql                          1/1     Running   0          38m   192.168.56.53   k18master    <none>           <none>
kube-system   calico-node-m6wzg                          1/1     Running   0          32m   192.168.56.54   k18worker1   <none>           <none>
kube-system   coredns-66bff467f8-mj4pj                   1/1     Running   0          40m   172.16.101.1    k18master    <none>           <none>
kube-system   coredns-66bff467f8-rkcgv                   1/1     Running   0          40m   172.16.101.2    k18master    <none>           <none>
kube-system   etcd-k18master                             1/1     Running   0          40m   192.168.56.53   k18master    <none>           <none>
kube-system   kube-apiserver-k18master                   1/1     Running   0          40m   192.168.56.53   k18master    <none>           <none>
kube-system   kube-controller-manager-k18master          1/1     Running   0          40m   192.168.56.53   k18master    <none>           <none>
kube-system   kube-proxy-mllf7                           1/1     Running   0          11m   192.168.56.55   k18worker2   <none>           <none>
kube-system   kube-proxy-mwtkt                           1/1     Running   0          32m   192.168.56.54   k18worker1   <none>           <none>
kube-system   kube-proxy-pzjpv                           1/1     Running   0          40m   192.168.56.53   k18master    <none>           <none>
kube-system   kube-scheduler-k18master                   1/1     Running   0          40m   192.168.56.53   k18master    <none>           <none>


vagrant@k18master:~$ kubectl get nodes -o wide
NAME         STATUS   ROLES    AGE   VERSION   INTERNAL-IP     EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
k18master    Ready    master   40m   v1.18.6   192.168.56.53   <none>        Ubuntu 18.04.4 LTS   4.15.0-91-generic   docker://19.3.11
k18worker1   Ready    <none>   32m   v1.18.6   192.168.56.54   <none>        Ubuntu 18.04.4 LTS   4.15.0-91-generic   docker://19.3.11
k18worker2   Ready    <none>   11m   v1.18.6   192.168.56.55   <none>        Ubuntu 18.04.4 LTS   4.15.0-91-generic   docker://19.3.11
vagrant@k18master:~$
```

