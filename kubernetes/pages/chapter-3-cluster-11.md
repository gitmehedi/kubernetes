Table of Contents
==================

# Chapter 3: Cluster (11%)
   * [Cluster Upgrade Process](#cluster-upgrade-process)
   * [Operating System Upgrades](#operating-system-upgrades)
   * [Backup and Restore Methodologies](#backup-and-restore-methodologies)
   
   

## Cluster
   ### Cluster Upgrade Process
   In kubernetes, various cluster component with different version working together. When it need to upgrade from one version to another cluster follows set of rules.
   In kubernetes, version are defined as ```1.13.3``` which are describe in table
   
   | Major | Minor | Patch |
   | ----- | ----- | ----- |
   |   1   |  13   |   3   |
   
   Cluster component can be upgrade using a set of rules which followed by each component when upgrading those component.
   
   Rules:
   1. Component's minor version cab be updated 1 version at a time.
   2. Component upgrade process follows a set of equations. If the kubernetes current  component version is ```1.13.3``` then rules will be
   
   If we consider ```X``` is the api-version and it's value is ```1.13.3```, then
   
   | Component Name  | Rule                                             | Equation              | Example                  |
   | --------------  | -----------------------------------------------  | --------------------- | ------------------------ |
   | kube-apiserver  | Exactly equal to X                               | X = X             | X = 1.13 or 1.12         |
   | kube-scheduler  | Equal to X or 1 less than X                      | X = X or X-1          | X = 1.13 or 1.12         |
   | kube-controller | Equal to X or 1 less than X                      | X = X or X-1          | X = 1.13 or 1.12         |
   | kubelet         | Equal to X or 1 or 2 less than X                 | X = X or X-1 or X-2   | X = 1.13 or 1.12 or 1.11 |
   | kube-proxy      | Equal to X or 1 or 2 less than X                 | X = X or X-1 or X-2   | X = 1.13 or 1.12 or 1.11 |
   | kubectl         | Equal to X or 1 greater than X or 1 less than X  | X = X or X +1  or X-1 | X = 1.14 or 1.13 or 1.12 |
   
   
   #### Upgrade Process
   Cluster upgrade steps to follow
   
   ##### Step 1: Get the version of API Server
   ```bash
   -- get kubectl client and server version 
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

   ##### Step 3: Get the version of etcd, kube-apiserver, kube-scheduler, kube-controller-manager
   ```
   -- get pod in kube-system namespace 
   $ kubectl get pod -n kube-system
    NAME                                                READY   STATUS    RESTARTS   AGE
    coredns-66bff467f8-8wr6w                            1/1     Running   6          25d
    etcd-master                                         1/1     Running   7          25d
    kube-apiserver-master                               1/1     Running   7          25d
    kube-controller-manager-master                      1/1     Running   7          25d
    kube-flannel-ds-amd64-qzxkh                         1/1     Running   9          25d
    kube-proxy-2khkk                                    1/1     Running   6          25d
    kube-scheduler-master                               1/1     Running   7          25d

    -- get version of etcd
    $ kubectl describe pod etcd-master  -n kube-system | grep Image:
    Image:         k8s.gcr.io/etcd:3.4.3-0
    
    -- get version of kube-apiserver
    $ kubectl describe pod kube-apiserver-master -n kube-system | grep Image:
    Image:         k8s.gcr.io/kube-apiserver:v1.18.0
    
    -- get version of kube-controller-manager
    $ kubectl describe pod kube-controller-manager-master -n kube-system | grep Image:
    Image:         k8s.gcr.io/kube-controller-manager:v1.18.0
    
    -- get version of kube-scheduler
    $ kubectl describe pod kube-scheduler-master -n kube-system | grep Image:
    Image:         k8s.gcr.io/kube-scheduler:v1.18.0
   ```

   ##### Step 4: Install new version of kubeadm
   Current Version : 1.18.0  
   Upgrade to : 1.18.2  
   
   ```
   -- unhold kubeadm version if already in hold status
   $ sudo apt-mark unhold kubeadm
   Canceled hold on kubeadm
   
   -- install kubeadm lastest version 1.18.2
   $ sudo apt-get install -y kubeadm=1.18.2-00

   -- hold kubeadm version after install kubeadm
   $ sudo apt-mark hold kubeadm

   -- get and verify latest kubeadm version
   $ kubeadm version
   kubeadm version: &version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.2", GitCommit:"9e991415386e4cf155a24b1da15becaa390438d8", GitTreeState:"clean", BuildDate:"2020-03-25T14:56:30Z", GoVersion:"go1.13.8", Compiler:"gc", Platform:"linux/amd64"}
   ```

   ##### Step 5: Prepare cluster upgrade plan
   ```
   -- cluster upgrade plan
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

   ##### Step 6: Upgrade the cluster component
   ```
   -- upgrade kubeadm to latest version
   $ sudo kubeadm upgrade apply v1.18.2

   -- get node version
   $ kubectl get nodes
    NAME     STATUS   ROLES    AGE   VERSION
    master   Ready    master   25d   v1.18.0
    worker   Ready    <none>   25d   v1.18.0

    -- get kubectl client and server version 
   $ kubectl version --short
    Client Version: v1.18.0
    Server Version: v1.18.2
   ```

   ##### Step 7: Install and Upgrade the kubelet version
   ```
   -- unhold kubelet version  
   $ sudo apt-mark unhold kubectl
   Canceled hold on kubelctl

   -- install and upgrade kubectl
   $ sudo apt-get install -y kubectl=1.18.2-00

   -- hold kubelet version
   $ sudo apt-mark hold kubelet
   kubelet set on hold.
   
   -- get kubectl client and server version 
   $ kubectl version --short
    Client Version: v1.18.2
    Server Version: v1.18.2
   ```

   #### References and Further Study
   * https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-upgrade/
   * https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md
   * https://kubernetes.io/docs/concepts/overview/kubernetes-api/
   * https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api_changes.md
   
   ### Operating System Upgrades
   
   #### Terminology:  
   In operating system upgrade some terms are very important
   
   1. **Drain:** When a node drain, Pod are terminated from the node and it can recreate on another node where requirement match.
    Also node marked as unscheduled, meaning no Pod can be schedule on this node until you specify schedulable or uncordon.
    Drain is the safe way to schedule Pod in another node. 
   2. **Cordon:** Marked node as unschedulable.  
   3. **Uncordon:** Marked node as schedulable so that Pod can schedule on this node.
   
   #### System Upgrade Process: 
   ##### Step 1: Evict the Pod from node using drain and take node down.
   Get details of pods which is running on which nodes.
   ```
   -- get pod details
   $ kubectl get pods -o wide
   ```

   Mark node as drain so that pod evict from specified node.
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
   -- delete node from cluster
   $ kubectl delete node [node_name]
   ```  
   
   ##### Step 3: After maintenance mark node as scheduleable to continue pod scheduling.
   After maintenance, node can be schedulable in two ways
   * Mark as schedulable  
   Schedule pods to the node after maintenance is complete:
   ```
   -- uncordon node01
   $ kubectl uncordon [node_name]
   ```  

   * Add New Node  
   1. Install all kubernetes component in worker node and ready to join in cluster.
   2. Get kubernetes cluster join token ```$ sudo kubeadm token generate```.
   3. Run the join token command in worker node.
    
   List the tokens:  
   ```
   $ sudo kubeadm token list
   ```  
    
   Print the kubeadm join command to join a node to the cluster:  
   ```
   $ sudo kubeadm token create [token_name] --ttl 2h --print-join-command 
   ```  
    
   #### Command References
   ```
   -- drain a node
   $ kubectl drain node01 --ignore-daemonset

   -- mark node as schedulable
   $ kubectl uncordon node01

   -- mark node as unschedulable
   $ kubectl cordon node01

   -- generate cluster join token
   $ sudo kubeadm token generate

   -- list cluster join token
   $ sudo kubeadm token list

   -- print cluste join token to join cluster
   $ sudo kubeadm token create [token_name] --ttl 2h --print-join-command 
   ```  
   #### References and Further Study
   * https://kubernetes.io/docs/tasks/administer-cluster/cluster-management/#maintenance-on-a-node  
   
   ### Backup and Restore Methodologies
   #### ETCD Database

   ETCD is a key-value pair database system which store cluster component status. ```etcdctl``` is a command line client for ETCD database.  
   To get backup and restore previous backup ETCD use the command ```etcd```. Before using ```etcd```, always append ```ETCDCTL_API``` with version no or export 
   Current version of ```ETCDCTL_API``` is 3.
   
   Alternative way to skip append is export
   ```
    -- export ETCDCTL_API
    $ export ETCDCTL_API=3

    -- create an alias
    $ alias etcd="ETCDCTL_API=3 etcdctl"
   ```

   On the Master Node:

   To see all the options for a specific sub-command, make use of the -h or --help flag.  
   For example, if you want to take a snapshot of ```etcd```, use:  
   ```
   $ ETCDCTL_API=3 etcdctl snapshot save -h
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
   $ ETCDCTL_API=3 etcdctl snapshot restore -h
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