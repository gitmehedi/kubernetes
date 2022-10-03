# NFS Client Server Cluster Installation
Network File System (NFS) is a distributed file system protocol originally developed by Sun Microsystems (Sun) in 1984,[1] allowing a user on a client computer to access files over a computer network much like local storage is accessed. NFS, like many other protocols, builds on the Open Network Computing Remote Procedure Call (ONC RPC) system. NFS is an open IETF standard defined in a Request for Comments (RFC), allowing anyone to implement the protocol.

**Table of Content**
- [NFS Client Server Cluster Installation](#nfs-client-server-cluster-installation)
  - [Document History](#document-history)
  - [Introduction](#introduction)
  - [Architecture](#architecture)
  - [Provison Cluster Node Using Vagrant](#provison-cluster-node-using-vagrant)
  - [Installation](#installation)
    - [Step 1: Install NFS Kernel Server in Ubuntu](#step-1-install-nfs-kernel-server-in-ubuntu)
    - [Step 2: Create an NFS Export Directory](#step-2-create-an-nfs-export-directory)
    - [Step 3: Grant NFS Share Access to Client Systems](#step-3-grant-nfs-share-access-to-client-systems)
    - [Step 4: Export the NFS Share Directory](#step-4-export-the-nfs-share-directory)
    - [Step 5: Allow NFS Access through the Firewall](#step-5-allow-nfs-access-through-the-firewall)
      - [Step 1: Install the NFS-Common Package](#step-1-install-the-nfs-common-package)
      - [Step 2: Create a NFS Mount Point on Client](#step-2-create-a-nfs-mount-point-on-client)
      - [Step 3: Mount NFS Share on Client System](#step-3-mount-nfs-share-on-client-system)
      - [Step 4: Testing the NFS Share on Client System](#step-4-testing-the-nfs-share-on-client-system)
  - [Step 6: Summary](#step-6-summary)
  

## Document History

```
Document History:
2022-10-03	V1 Md Mehedi Hasan "Install NFS Cluster Node for Network File System using vagrant and virtualbox"
```


## Introduction

This document provides the procedure to install 3 nodes Kubernetes cluster in Ubuntu 18.04 LTS VM. VMs are provision using vagrant utility, which eventually used virtualbox environment. Download and install [Vagrant](https://www.vagrantup.com/downloads.html)  and [VirtualBox](https://www.virtualbox.org/wiki/Downloads).



## Architecture

Two VMs are taken for the NFS cluster setup and assigned fixed IP address from network 192.168.56.0/24 using vagrant.

```bash
#ip plan for kube cluster
nfs8server      192.168.56.50/24
nfs8client		192.168.56.51/24
```



As VMs are required internet access to setup necessary package, so added NAT rule in host system using ipables command if you are using linux based host.

```bash
iptables -t nat  -A POSTROUTING -s 192.168.56.0/24 -j MASQUERADE
```



## Provison Cluster Node Using Vagrant

Clone repository for provisioning VMs using [Vagrant config file](https://github.com/arif332/KBs.Pub/blob/master/kubernetes/vagrant-k18/Vagrantfile) and [Scripts](https://github.com/arif332/KBs.Pub/blob/master/kubernetes/vagrant-k18). 

```bash
$ git clone https://github.com/arif332/kubernetes.git
$ cd kubernetes/nfs-server-client/
```

Check VMs status which is 

```bash
$ vagrant status
Current machine states:
nfs8server                not created (virtualbox)
nfs8client                not created (virtualbox)
```

Now, provision/initiate VMs as per below commands 

```bash
$ vagrant up nfs8server
$ vagrant up nfs8client
```


After node provision, verify that each node can reach other node using IP address and name. Also check default gw, which should be configured using 192.168.56.1 as per information in Vagrantfile.

## Installation
To install and configure the NFS server, follow the steps outlined below.

### Step 1: Install NFS Kernel Server in Ubuntu
The first step is to install the nfs-kernel-server package on the server. But before we do this, let’s first update the system packages using the following apt command.  
```shell
$ sudo apt update
```

Once the update is complete, proceed and install the nfs-kernel-server package as shown below. This will store additional packages such as nfs-common and rpcbind which are equally crucial to the setup of the file share.  
```shell
$ sudo apt install nfs-kernel-server
```
￼
Install NFS Server on Ubuntu
###  Step 2: Create an NFS Export Directory
The second step will be creating a directory that will be shared among client systems. This is also referred to as the export directory and it’s in this directory that we shall later create files which will be accessible by client systems.
Run the command below by specifying the NFS mount directory name.  
```shell
$ sudo mkdir -p /mnt/nfs_share
```
Since we want all the client machines to access the shared directory, remove any restrictions in the directory permissions.
```shell
$ sudo chown -R nobody:nogroup /mnt/nfs_share/
```
You can also tweak the file permissions to your preference. Here’s we have given the read, write and execute privileges to all the contents inside the directory.  

```shell
$ sudo chmod 777 /mnt/nfs_share/
```

Create NFS Share in Ubuntu
### Step 3: Grant NFS Share Access to Client Systems
Permissions for accessing the NFS server are defined in the /etc/exports file. So open the file using your favorite text editor:

```shell
$ sudo vim /etc/exports
```

You can provide access to a single client, multiple clients or specify an entire subnet.
In this guide, we have allowed en entire subnet to have access to the NFS share. 

```shell 
/mnt/nfs_share  192.168.43.0/24(rw,sync,no_subtree_check)
```

Explanation about the options used in the above command.
* rw: Stands for Read/Write.
* sync: Requires changes to be written to the disk before they are applied.
* No_subtree_check: Eliminates subtree checking.
￼
Set NFS Share Access
To grant access to a single client, use the syntax:

```/mnt/nfs_share  client_IP_1 (re,sync,no_subtree_check)```
For multiple clients, specify each client on a separate file:
```shell
/mnt/nfs_share  client_IP_1 (re,sync,no_subtree_check)
/mnt/nfs_share  client_IP_2 (re,sync,no_subtree_check)
```
### Step 4: Export the NFS Share Directory

After granting access to the preferred client systems, export the NFS share directory and restart the NFS kernel server for the changes to come into effect.
```shell
$ sudo exportfs -a
$ sudo systemctl restart nfs-kernel-server
```

**Export NFS Share Directory**
### Step 5: Allow NFS Access through the Firewall
For the client to access the NFS share, you need to allow access through the firewall otherwise, accessing and mounting the shared directory will be impossible. To achieve this run the command:
```shell
$ sudo ufw allow from 192.168.43.0/24 to any port nfs
```
Reload or enable the firewall (if it was turned off) and check the status of the firewall. Port 2049, which is the default file share, 
should be opened.
```shell
$ sudo ufw enable
$ sudo ufw status
￼
```
Open NFS Port on Firewall
Install the NFS Client on the Client Systems
We’re done installing and configuring the NFS service on the Server, let’s now install NFS on the client system.
#### Step 1: Install the NFS-Common Package
As is the norm, begin by updating the system packages and repositories before anything else.
```shell
$ sudo apt update
```
Next, install nfs-common packages as shown.
```shell
$ sudo apt install nfs-common
```
Install NFS on Client System
#### Step 2: Create a NFS Mount Point on Client
Next,you need to create a mount point on which you will mount the nfs share from the NFS server. To do this, run the command:
```shell 
$ sudo mkdir -p /mnt/nfs_clientshare
```
#### Step 3: Mount NFS Share on Client System
The last step remaining is mounting the NFS share that is shared by the NFS server. This will enable the client system to access the shared directory.
Let’s check the NFS Server’s IP address using the ifconfig command.
```shell
$ ifconfig
```
Check Ubuntu Server IP Address
To achieve this run the command:
```shell
$ sudo mount 192.168.43.234:/mnt/nfs_share  /mnt/nfs_clientshare
```
#### Step 4: Testing the NFS Share on Client System
To verify that our NFS setup is working, we are going to create a few files in the NFS share directory located in the server.
```shell
$ cd /mnt/nfs_share/

$ touch file1.txt file2.txt file3.txt
```

Now head back to the NFS client system and check if the files exist.
```shell
$ ls -l /mnt/nfs_clientshare/
```

## Step 6: Summary
Test NFS Share on Client
Great! The output confirms that we can access the files we just created on the NFS server!
And that about it. In this guide, we walked you through the installation and configuration of the NFS server on Ubuntu 18.04. NFS is rarely used nowadays and has been relegated in favor of the more robust and secure Samba share protocol.

