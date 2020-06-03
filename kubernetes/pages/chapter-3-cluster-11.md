Table of Contents
==================

# Chapter 3: Cluster (11%)
   * [Cluster Upgrade Process](#cluster-upgrade-process)
   * [Operating System Upgrades](#operating-system-upgrades)
   * [Backup and Restore Methodologies](#backup-and-restore-methodologies)
   
   

## Cluster
   ### Cluster Upgrade Process
   kubeadm allows to upgrade cluster components in proper order from one version to another once at a time. 
   
   ```
    -- Allows 1 version at a time
    => 1.12.0 to 1.13.0
    => 1.16.0 to 1.17.0
    
    -- Not Allow
    => 1.12.0 1.16.0
   ```
   #### Upgrade Process
   Follow steps to upgrade lower version to upper version  
   
   ##### Step 1: Get the version of API Server
   ```bash
   $ kubectl version --short
   Client Version: v1.18.0
   Server Version: v1.18.0
   ```
   ##### Step 2: Get the version of kubelet
   ```
   $ kubectl describe nodes
   Kubelet Version:            v1.18.0
   Kube-Proxy Version:         v1.18.0
   ```
   ##### Step 3: Get the version of api-server, kube-apiserver, kube-scheduler, kube-controller-manager
   ```
   $ kubectl get pod -n kube-system
    NAME                                                READY   STATUS    RESTARTS   AGE
    coredns-66bff467f8-8wr6w                            1/1     Running   6          25d
    etcd-master                                         1/1     Running   7          25d
    kube-apiserver-master                               1/1     Running   7          25d
    kube-controller-manager-master                      1/1     Running   7          25d
    kube-flannel-ds-amd64-qzxkh                         1/1     Running   9          25d
    kube-proxy-2khkk                                    1/1     Running   6          25d
    kube-scheduler-master                               1/1     Running   7          25d

    -- Get etcd version
    $ kubectl describe pod etcd-master  -n kube-system | grep Image:
    Image:         k8s.gcr.io/etcd:3.4.3-0
    
    -- Get kube-apiserver version
    $ kubectl describe pod kube-apiserver-master -n kube-system | grep Image:
    Image:         k8s.gcr.io/kube-apiserver:v1.18.0
    
    -- Get kube-controller-manager version
    $ kubectl describe pod kube-controller-manager-master -n kube-system | grep Image:
    Image:         k8s.gcr.io/kube-controller-manager:v1.18.0
    
    -- Get kube-scheduler version
    $ kubectl describe pod kube-scheduler-master -n kube-system | grep Image:
    Image:         k8s.gcr.io/kube-scheduler:v1.18.0
    
   ```

   ##### Step 4: Upgrade kubeadm required latest version (1.18.2) and Install kubeadm 
   ```
   -- unhold kubeadm version if already in hold status
   $ sudo apt-mark unhold kubeadm
   Canceled hold on kubeadm
   
   -- install kubeadm version 1.18.2
   $ sudo apt-get install -y kubeadm=1.18.2-00

   -- hold kubeadm version after install kubeadm
   $ sudo apt-mark hold kubeadm

   -- get latest kubeadm version
   $ kubeadm version
   kubeadm version: &version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.2", GitCommit:"9e991415386e4cf155a24b1da15becaa390438d8", GitTreeState:"clean", BuildDate:"2020-03-25T14:56:30Z", GoVersion:"go1.13.8", Compiler:"gc", Platform:"linux/amd64"}
   ```

   ##### Step 5: Plan controller component upgrade plan before final execution
   ```
   $ sudo kubeadm upgrade plan
    
    Upgrade to the latest version in the v1.18 series:
    
    COMPONENT            CURRENT   AVAILABLE
    API Server           v1.18.0   v1.18.2
    Controller Manager   v1.18.0   v1.18.2
    Scheduler            v1.18.0   v1.18.2
    Kube Proxy           v1.18.0   v1.18.2
    CoreDNS              1.6.7     1.6.7
    Etcd                 3.4.3     3.4.3-0
    You can now apply the upgrade by executing the following command:

        kubeadm upgrade apply v1.18.2

   ```

   ##### Step 6: Upgrade the controller component
   ```
   -- upgrade kubeadm to latest version
   $ sudo kubeadm upgrade apply v1.18.2
   $ kubect get nodes
    NAME     STATUS   ROLES    AGE   VERSION
    master   Ready    master   25d   v1.18.0
    worker   Ready    <none>   25d   v1.18.0

    -- get api server version
   $ kubectl version --short
    Client Version: v1.18.0
    Server Version: v1.18.2
   ```

   ##### Step 7: Upgrade the kubelet version (1.18.2) and Install
   ```
   -- unhold kubelet version  
   $ sudo apt-mark unhold kubectl
   Canceled hold on kubelctl

   -- upgrade kubectl
   $ sudo apt-get install -y kubectl=1.18.2-00
   
   -- Get the version
   $ kubectl version --short
   Client Version: v1.18.2
   Server Version: v1.18.2
   
   -- hole version of kubelet
   $ sudo apt-mark hold kubelet
   kubelet set on hold.
   ```

   #### References and Further Study
   * https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-upgrade/
   * https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md
   * https://kubernetes.io/docs/concepts/overview/kubernetes-api/
   * https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api_changes.md
   
   ### Operating System Upgrades
   
   #### Terminology:  
   In operating system upgrade some terms are very important
   
   1. Drain: When a node drain, Pod are terminated form the node and Pod are recreated on another node where requirement match.
    Also node marked as unscheduled, meaning no Pod can be schedule on this node until you specify Scheduled or uncordon.
    Using it Pod can safe on other node.  
   2. Cordon: Marked node as unschedule able.  
   3. Uncordon: Marked node as scheduleable so that Pod can schedule on this node.
   
   #### System Upgrade Process: 
   ##### Step 1: Evict the Pod from node using drain and take node down.
   Get details of pods which is running on which nodes.
   ```
   -- get pod details
   $ kubectl get pods -o wide
   ```

   Node mark as drain so that pod evict from specified node.
   ```
   -- mark node as drain
   $ kubectl drain [node_name] --ignore-daemonsets
   ```
 
   Watch node changes status
   ```
   -- watch node changes in real time
   $ kubectl get nodes -w
   ```
 

   ##### Step 2: Maintains the node.
   Maintains on node as required.
   Remove a node from the cluster if node is not required
   ```
   $ kubectl delete node [node_name]
   ```  
   
   ##### Step 3: After maintenance continue scheduling using uncordon the node.
   Schedule pods to the node after maintenance is complete:
   ```
   -- uncordon node01
   $ kubectl uncordon node01
   ```  
   **Add New Node**  
   Prepare a new node
   
   Generate a new token:  
   ```
   -- generate token
   $ sudo kubeadm token generate
   ```  
    
   List the tokens:  
   ```
   $ sudo kubeadm token list
   ```  
    
   Print the kubeadm join command to join a node to the cluster:  
   ```
   $ sudo kubeadm token create [token_name] --ttl 2h --print-join-command 
   ```  
    
       
   #### Command References
   ```bash
    $ kubectl drain [node_name]
    $ kubectl cordon [node_name]
    $ kubectl delete [node_name]
    $ kubectl edit [node_name]
   ```  
   #### References and Further Study
   * https://kubernetes.io/docs/tasks/administer-cluster/cluster-management/#maintenance-on-a-node  
   
   
   ### Backup and Restore Methodologies
   #### ETCDCTL

   etcdctl is a command line client for etcd.  
   ETCD key-value database is deployed as a static pod on the master. Current version used is v3.

   To make use of ```etcdctl``` for tasks such as back up and restore, make sure that you set the ```ETCDCTL_API``` to 3.

   It can be done by exporting the variable ```ETCDCTL_API``` prior to using the ```etcdctl``` client. 
   
   ```
    -- can be done
    export ETCDCTL_API=3
   ```

   On the Master Node:

   To see all the options for a specific sub-command, make use of the -h or --help flag.  
   For example, if you want to take a snapshot of ```etcd```, use:  
   ```
   etcdctl snapshot save -h
   ```   
   and keep a note of the mandatory global options.

   Since ETCD database is TLS-Enabled, the following options are mandatory:
   ```
   --endpoints=[127.0.0.1:2379]    This is the default as ETCD is running on master node and exposed on localhost 2379.
   --cacert                        verify certificates of TLS-enabled secure servers using this CA bundle
   --cert                          identify secure client using this TLS certificate file
   --key                           identify secure client using this TLS key file
   ```

   Similarly use the help option for snapshot restore to see all available options for restoring the backup.

   ```
   etcdctl snapshot restore -h
   ```

   For a detailed explanation on how to make use of the ```etcdctl``` command line tool and work with the -h flags, check out the solution video for the Backup and Restore Lab.
   #### Backup ETCD
   
   Backup candidates using following ways
   ```
    1. Resource Configuration
    2. ETCD Cluster
   ```

   ##### Step 1. Resource Configuration
   Take all configuration from a cluster using  
   ```
   -- get all resourece from cluster
   $ kubectl get all --all-namespaces -o yaml > all_deploy_service.yaml
   ```  
   
   ##### Step 2. ETCD Cluster
   Take backup on specific location
   ```
    -- snapshot will save at /tmp/snapshot-pre-boot.db
    $ ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 \
      --cacert=/etc/kubernetes/pki/etcd/ca.crt \
      --cert=/etc/kubernetes/pki/etcd/server.crt \
      --key=/etc/kubernetes/pki/etcd/server.key \
      snapshot save /tmp/snapshot-pre-boot.db
   ```
   
   See the status of snapshot
   ```
   $ ETCDCTL_API=3 etcdctl snapshot status /tmp/snapshot-pre-boot.db
    436037d5, 2612, 854, 2.3 MB
   ```
   
   #### Restore
   Restore ETCD Snapshot to a new directory
   ```
   ETCDCTL_API=3 etcdctl 
     --endpoints=https://[127.0.0.1]:2379 \
     --cacert=/etc/kubernetes/pki/etcd/ca.crt \
     --cert=/etc/kubernetes/pki/etcd/server.crt \
     --key=/etc/kubernetes/pki/etcd/server.key \
     --name=master \
     --data-dir /var/lib/etcd-from-backup \
     --initial-cluster=master=https://127.0.0.1:2380 \
     --initial-cluster-token etcd-cluster-1 \
     --initial-advertise-peer-urls=https://127.0.0.1:2380 \
     snapshot restore /tmp/snapshot-pre-boot.db
   ```

   Add new data directory inside etcd file ```/etc/kubernetes/manifests/etcd.yaml```
   ```
    -- add following lines under command
    $ vim /etc/kubernetes/manifests/etcd.yaml

    --data-dir=/var/lib/etcd-from-backup
    --initial-cluster-token=etcd-cluster-1

    volumeMounts:
        - mountPath: /var/lib/etcd-from-backup
          name: etcd-data
        - mountPath: /etc/kubernetes/pki/etcd
          name: etcd-certs
      hostNetwork: true
      priorityClassName: system-cluster-critical
      volumes:
      - hostPath:
          path: /var/lib/etcd-from-backup
          type: DirectoryOrCreate
        name: etcd-data
      - hostPath:
          path: /etc/kubernetes/pki/etcd
          type: DirectoryOrCreate
        name: etcd-certs
   ```

   #### Command References
   ```bash
    -- Get the version of etcd 
    $ kubectl logs etcd-master -n kube-system
    $ kubectl describe pod etcd-master -n kube-system
   ``` 

   #### References and Further Study
   * https://github.com/mmumshad/kubernetes-the-hard-way/blob/master/practice-questions-answers/cluster-maintenance/backup-etcd/etcd-backup-and-restore.md
   
[Table of Contents](https://github.com/gitmehedi/cloudtuts/tree/develop/kubernetes)  
**Prev Chapter:** [Chapter 2: Install, Config and Validate (12%)](chapter-2-install-config-and-validate-12.md)
**Next Chapter:** [Chapter 4: Networking (11%)](chapter-4-networking-11.md)