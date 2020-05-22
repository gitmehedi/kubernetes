# Certified Kubernetes Administrator (CKA) 


Table of Contents
==================
* [Document History](#document-history)
* [Chapter 1: Core Concepts  (19%)](#chapter-1-core-concepts-19)
   * [Cluster Architecture](#cluster-architecture)
   * [API Primitives](#api-primitives)
   * [Services and Network](#services-and-network)     

* [Chapter 2: Install, Config and Validate (12%)](#chapter-2-install-config-and-validate-12)
   * [Design a Kubernetes cluster.](#design-a-kubernetes-cluster)
   * [Install Kubernetes masters and nodes](#install-kubernetes-masters-and-nodes)
   * [Configure secure cluster communications.](#configure-secure-cluster-communications.)
   * [Configure a Highly-Available Kubernetes cluster.](#configure-a-highly--vailable-kubernetes-cluster)
   * [Know where to get the Kubernetes release binaries.](#know-where-to-get-the-kubernetes-release-binaries)
   * [Provision underlying infrastructure to deploy a Kubernetes cluster](#provision-underlying-infrastructure-to-deploy-a-kubernetes-cluster)
   * [Choose a network solution.](#choose-a-network-solution)
   * [Choose your Kubernetes infrastructure configuration.](#choose-your-kubernetes-infrastructure-configuration)
   * [Run end-to-end tests on your cluster.](#run-end-to-end-tests-on-your-cluster)
   * [Analyse end-to-end tests results.](#analyse-end-to-end-tests-results)
   * [Run Node end-to-end tests.](#run-node-end-to-end-tests)
   * [Install and use kubeadm to install, configure, and manage Kubernetes clusters](#install-and-use-kubeadm-to-install-configure-and-manage-kubernetes-clusters)
   
* [Chapter 3: Cluster (11%)](#chapter-3-cluster-11)
   * [Cluster Upgrade Process](#cluster-upgrade-process)
   * [Operating System Upgrades](#operating-system-upgrades)
   * [Backup and Restore Methodologies](#backup-and-restore-methodologies)

* [Chapter 4: Networking (11%)](#chapter-4-networking-11)
   * [Node Networking Concepts](#node-networking-concepts) 
   * [Pod Networking Concepts](#pod-networking-concepts) 
   * [Service Networking Concepts](#service-networking-concepts) 
   * [Container Network Interface](#container-network-interface-cni) 
   * [Load Balancer Configure and Deploy](#load-balancer-configure-and-deploy) 
   * [Ingress Rules Configure](#ingress-rules-configure) 
   * [Cluster DNS Configure](#cluster-dns-configure) 
   
* [Chapter 5: Scheduling (5%)](#chapter-5-scheduling-5)
   * [Kubernetes Labels and Selectors to Schedule Pods](#kubernetes-labels-and-selectors-to-schedule-pods)
   * [Role of DaemonSets](#role-of-daemonsets)
   * [Resource Limits and Labels in Pods Scheduling](#resource-limits-and-labels-in-pods-scheduling)
   * [Multiple Schedulers to Run and Configure Pods](#multiple-schedulers-to-run-and-configure-pods)
   * [Manually Schedule a Pods](#manually-schedule-a-pods)
   * [Scheduler Events](#scheduler-events)
   * [Configure Kubernetes Scheduler](#configure-kubernetes-scheduler)
  
* [Chapter 6: Application Lifecycle (8%)](#chapter-6-application-lifecycle-8)
   * [Deploying an Application with Rolling Updates and Rollback](#deploying-an-application-with-rolling-updates-and-rollback)
   * [Configure Highly Available Application](#configure-highly-available-application)
   * [Scale Applications](#scale-applications)
   * [Manage Self-Healing Application](#manage-self-healing-application)
  
* [Chapter 7: Storage (7%)](#chapter-7-storage-7)
   * [Manage Persistent Volume](#manage-persistent-volume)
   * [Volume Access Modes](#volume-access-modes)
   * [Manage Persistent Volume Claims](#manage-persistent-volume-claims)
   * [Manage Storage Objects](#manage-storage-objects)
   * [Configure Application with Storage](#configure-application-with-storage)
  
* [Chapter 8: Security (12%)](#chapter-8-security-12)
   * [Security Primitives](#security-primitives)
   * [Configure Authentication and Authorization](#configure-authenticatation-and-authorization)
   * [Configure Network Policies](#configure-network-policies)
   * [Manage TLS Certificate for Cluster](#manage-tls-certificate-for-cluster)
   * [Image Security](#image-security)
   * [Persistent Key Value Stores](#persistent-key-value-stores)

* [Chapter 9: Log and Monitor (5%)](#chapter-9-log-and-monitor-5)
   * [Monitor All Cluster Component](#monitor-all-cluster-component)
   * [Monitor Applications](#monitor-applications)
   * [Cluster Component Logs](#cluster-component-logs)
   * [Manage Application Logs](#manage-application-logs)
   
* [Chapter 10: Troubleshooting (10%)](#chapter-10-troubleshooting-10)
   * [Application Failure](#application-failure)
   * [Control Plane Failure](#control-place-failure)
   * [Worker Node Failure](#worker-node-failure)
   * [Network Failure](#network-failure)
  

## Document History

```
Document History:
2020-05-01	V1 Mehedi Hasan  "Certified Kubernetes Administrator (CKA) Curriculum"
```

## Chapter 1: Core Concepts (19%) 
   ### Cluster Architecture
   In kubernetes cluster there are two main component
   ```bash
   1. Master Node
   2. Worker Node
   ```
  #### Master Node:  
  There are 4 basic component in Master Node on The Control Plane:  
  Components:  
  ```
  1. API Server
  2. Scheduler
  3. Controller Manager
  4. ETCD
  ```
  * **API Server**: API server is the communication hub for all cluster components. It exposes many kubernetes API.  
  * **Scheduler**: Assign application/pod to worker node. Auto detects which pod to assign to which node based on resources requirements, hardware constrains etc. Its doesn't pod on worker node itself.  
  * **Controller Manager**: Maintaining the cluster. Handles node failures, replicating components, maintaining correct amount of POD.  
  * **ETCD**: Data store that stores cluster information.  
  
  Depending on Setup you can see configuration of each component in directory in following way. You will find all Control Plane component it there 
  1. Kubeadm Setup:  ```/etc/kubernetes/manifests/```  
  2. Hardway Setup:  ```/etc/systemd/system```
  ```
  -- Kubeadm 
  $ cat /etc/kubernetes/manifests/api-server.yaml
  $ cat /etc/kubernetes/manifests/etcd-server.yaml
  $ cat /etc/kubernetes/manifests/kube-controller-manager.yaml
  $ cat /etc/kubernetes/manifests/scheduler-manager.yaml
  
  -- Hardway 
  $ cat /etc/systemd/system/api-server.service
  $ cat /etc/systemd/system/etcd-server.service
  $ cat /etc/systemd/system/kube-controller-manager.service
  $ cat /etc/systemd/system/scheduler-manager.service

  -- Using process
  $ ps -ef | grep api-server
  $ ps -ef | grep etcd-server
  $ ps -ef | grep kube-contoller-manager
  $ ps -ef | grep scheduler-manager
  ```
  
  
  #### Worker Node:
  Components:
  ```
  1. Kubelet
  2. Kube-proxy
  3. Container Runtime
  ```
  
  * **Kubelet**:  
  Run and manages the containers on the nodes and communicate to API Server. 
  ```
  * Kubeadm does not install kubelet automatically. It need to download manually
  ```
  * **Kube-proxy**: Load balance traffic between application components.  
  ```
  * It creates iptable rules in each node to forward traffic to the IP of the service. Example: DaemonSet  
  ```
  * **Container Runtime**: The programs that run containers
  ```
  1. Docker
  2. rkt
  3. containerd
  ```
  
  #### Command References
  ```bash
  -- API Call
  $ kubectl get --raw /apis/metrics.k8s.io/

  -- Cluster Information
  $ kubectl config
  $ kubectl cluster-info
  $ kubectl get componentstatuses
  ```
  
  #### References and Further Study
  * https://kubernetes.io/docs/concepts/overview/components/
  * https://wiki.aquasec.com/display/containers/Kubernetes+Architecture+101
  
 ### API Primitives
  > Kubernetes API to read and write Kubernetes resource objects via a Kubernetes API endpoint.
   
  #### Resources Categories  
  There are 5 basic types of resources provided by kubernetes API 
  1. **Workloads** are objects you use to manage and run your containers on the cluster.
  2. **Discovery & LB** resources are objects you use to "stitch" your workloads together into an externally accessible, load-balanced Service.
  3. **Config & Storage** resources are objects you use to inject initialization data into your applications, and to persist data that is external to your container.
  4. **Cluster** resources objects define how the cluster itself is configured; these are typically used only by cluster operators.
  5. **Metadata** resources are objects you use to configure the behavior of other resources within the cluster, such as HorizontalPodAutoscaler for scaling workloads.
    
  #### Resources Objects 
  Resource objects typically have 3 components:
   
  1. **Resource ObjectMeta**: This is metadata about the resource, such as its name, type, api version, annotations, and labels. This contains fields that maybe updated both by the end user and the system (e.g. annotations).
  2. **ResourceSpec**: This is defined by the user and describes the desired state of system. Fill this in when creating or updating an object.
  3. **ResourceStatus**: This is filled in by the server and reports the current state of the system. In most cases, users don't need to change this.
   
  #### Resources Operations
  Most resources provide the following Operations:

  1. **Create**  
  Create operations will create the resource in the storage backend. After a resource is create the system will apply the desired state.
    
  2. **Update**  
  Updates come in 2 forms: Replace and Patch:
    
     **Replace**: Replacing a resource object will update the resource by replacing the existing spec with the provided one. For read-then-write operations this is safe because an optimistic lock failure will occur if the resource was modified between the read and write. Note: The ResourceStatus will be ignored by the system and will not be updated. To update the status, one must invoke the specific status update operation.
        Note: Replacing a resource object may not result immediately in changes being propagated to downstream objects. For instance replacing a ConfigMap or Secret resource will not result in all Pods seeing the changes unless the Pods are restarted out of band.  
        
     **Patch**: Patch will apply a change to a specific field. How the change is merged is defined per field. Lists may either be replaced or merged. Merging lists will not preserve ordering.
        Patches will never cause optimistic locking failures, and the last write will win. Patches are recommended when the full state is not read before an update, or when failing on optimistic locking is undesirable. When patching complex types, arrays and maps, how the patch is applied is defined on a per-field basis and may either replace the field's current value, or merge the contents into the current value.
    
  3. **Read**
  Reads come in 3 forms: Get, List and Watch:
    
     **Get**: Get will retrieve a specific resource object by name.  
     **List**: List will retrieve all resource objects of a specific type within a namespace, and the results can be restricted to resources matching a selector query.  
     **List All Namespaces**: Like List but retrieves resources across all namespaces.    
     **Watch**: Watch will stream results for an object(s) as it is updated. Similar to a callback, watch is used to respond to resource changes.  
        
  4. **Delete**  
  Delete will delete a resource. Depending on the specific resource, child objects may or may not be garbage collected by the server. See notes on specific resource objects for details.
    
  5. **Additional Operations**  
  Resources may define additional operations specific to that resource type.  
    
     **Rollback**: Rollback a PodTemplate to a previous version. Only available for some resource types.  
     **Read / Write Scale**: Read or Update the number of replicas for the given resource. Only available for some resource types.  
     **Read / Write Status**: Read or Update the Status for a resource object. The Status can only changed through these update operations.              
    
  #### Command References
  ```bash
    -- create a deployment from yaml file nginx.yaml
    $ kubectl create -f nginx.yaml

    -- Generate yaml from a pod
    $ kubectl get deployment nginx-deployemnt -o yaml > nginx.yaml  
  ```  
  #### References and Further Study
  * https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/
  * https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.16/#container-v1-core
   
  ### Services and Network
    > Understand Services and other network primitives
    
  #### Services
  
  #### Networking Primitives
  
  #### Kubernetes Command
  There are two ways to create resources in a Kubernetes cluster: the imperative and the declarative ones.  
  1. **Declarative**: The declarative approach is used to create resources from manifest files (usually in YAML) using the kubectl apply command. 
  This is the approach used in a production environment.  
  ```kubectl apply -f <object>.<yaml,json>```
  2. **Imperative**: The imperative way is used to manage resources using several distinct commands and do not requires any manifest files.  
  
  ```
  -- Create an NGINX Pod
  $ kubectl run --generator=run-pod/v1 nginx --image=nginx --dry-run -o yaml 
    
  -- Create a deployment
  $ kubectl create deployment --image=nginx nginx --dry-run -o yaml
  $ kubectl run --generator=deployment/v1beta1 nginx --image=nginx --dry-run --replicas=4 -o yaml
    
  -- Create a Service named redis-service of type ClusterIP to expose pod redis on port 6379
  $ kubectl expose pod redis --port=6379 --name redis-service --dry-run -o yaml
  $ kubectl create service clusterip redis --tcp=6379:6379 --dry-run -o yaml
  ```
  
  ##### Generator
  You can generate the following resources with a kubectl command,   
  ```kubectl create --dry-run -o yaml```
  ```
clusterrole         Create a ClusterRole.
  clusterrolebinding  Create a ClusterRoleBinding for a particular ClusterRole.
  configmap           Create a configmap from a local file, directory or literal value.
  cronjob             Create a cronjob with the specified name.
  deployment          Create a deployment with the specified name.
  job                 Create a job with the specified name.
  namespace           Create a namespace with the specified name.
  poddisruptionbudget Create a pod disruption budget with the specified name.
  priorityclass       Create a priorityclass with the specified name.
  quota               Create a quota with the specified name.
  role                Create a role with single rule.
  rolebinding         Create a RoleBinding for a particular Role or ClusterRole.
  secret              Create a secret using specified subcommand.
  service             Create a service using specified subcommand.
  serviceaccount      Create a service account with the specified name.
```
  
  #### Command References
  ```bash
    # create a deployment from yaml file nginx.yaml
    $ kubectl create -f nginx.yaml
    # Generate yaml from a pod
    $ kubectl get deployment nginx-deployemnt -o yaml > nginx.yaml  
  ```  

  #### References and Further Study
  * https://kubernetes.io/docs/reference/kubectl/cheatsheet/
  * https://kubernetes.io/docs/concepts/services-networking/service/
  * https://kubernetes.io/docs/reference/kubectl/conventions/
  
  
## Chapter 2: Install, Config and Validate (12%)
   * ### Design a Kubernetes cluster.
   * ### Install Kubernetes masters and nodes
   * ### Configure secure cluster communications.
   * ### Configure a Highly-Available Kubernetes cluster.
   * ### Know where to get the Kubernetes release binaries.
   * ### Provision underlying infrastructure to deploy a Kubernetes cluster.
   * ### Choose a network solution.
   * ### Choose your Kubernetes infrastructure configuration.
   * ### Run end-to-end tests on your cluster.
   * ### Analyse end-to-end tests results.
   * ### Run Node end-to-end tests.
   * ### Install and use kubeadm to install, confi gure, and manage Kubernetes clusters
   ```
    /etc/kubernetes/
    ├── admin.conf
    ├── controller-manager.conf
    ├── kubelet.conf
    ├── manifests
    │   ├── etcd.yaml
    │   ├── kube-apiserver.yaml
    │   ├── kube-controller-manager.yaml
    │   └── kube-scheduler.yaml
    ├── pki
    │   ├── apiserver.crt
    │   ├── apiserver-etcd-client.crt
    │   ├── apiserver-etcd-client.key
    │   ├── apiserver.key
    │   ├── apiserver-kubelet-client.crt
    │   ├── apiserver-kubelet-client.key
    │   ├── ca.crt
    │   ├── ca.key
    │   ├── etcd
    │   │   ├── ca.crt
    │   │   ├── ca.key
    │   │   ├── healthcheck-client.crt
    │   │   ├── healthcheck-client.key
    │   │   ├── peer.crt
    │   │   ├── peer.key
    │   │   ├── server.crt
    │   │   └── server.key
    │   ├── front-proxy-ca.crt
    │   ├── front-proxy-ca.key
    │   ├── front-proxy-client.crt
    │   ├── front-proxy-client.key
    │   ├── sa.key
    │   └── sa.pub
    └── scheduler.conf
   ```
    
    
## Chapter 3: Cluster (11%)
   ### Cluster Upgrade Process
   kubeadm allows to upgrade cluster components in the proper order from one version at a time. 
   ```textmate
    -- Allows 1 version at a time
    => 1.12.0 to 1.13.0
    => 1.16.0 to 1.17.0
    
    -- Not Allow
    => 1.12.0 1.16.0
   ```
   Follow steps to upgrade lower version to upper version  
   Step 1: Get the version of API Server
   ```bash
   $ kubectl version --short
   Client Version: v1.18.0
   Server Version: v1.18.0
   ```
   Step 2: Get the version of kubelet
   ```
   $ kubectl describe nodes
   Kubelet Version:            v1.18.0
   Kube-Proxy Version:         v1.18.0
   ```
   Step 3: Get the version of api-server, kube-apiserver, kube-scheduler, kube-controller-manager
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
   
   Step 4: Unhold kubeadm, kubelet if already in hold status
   ```
   $ sudo apt-mark unhold kubeadm kubelet
   Canceled hold on kubeadm
   Canceled hold on kubelet
   ```
   Step 5: Install kubeadm of version 1.18.2
   ```
   $ sudo apt-get install -y kubeadm=1.18.2-00
   ```

   Step 6: Hold kubeadm version and get kubeadm version
   ```
   $ sudo apt-mark hold kubeadm
   $ kubeadm version
   kubeadm version: &version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.2", GitCommit:"9e991415386e4cf155a24b1da15becaa390438d8", GitTreeState:"clean", BuildDate:"2020-03-25T14:56:30Z", GoVersion:"go1.13.8", Compiler:"gc", Platform:"linux/amd64"}
   ```

   Step 7: Plan the upgrade before executing
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

   Step 8: Upgrade the controller component
   ```
   $ sudo kubeadm upgrade apply v1.18.2
   $ kubect get nodes
    NAME     STATUS   ROLES    AGE   VERSION
    master   Ready    master   25d   v1.18.0
    worker   Ready    <none>   25d   v1.18.0

    -- Get the version
    $ kubectl version --short
    Client Version: v1.18.0
    Server Version: v1.18.2
   ```

   Step 9: Upgrade the kubelet version
   ```
   $ sudo apt-mark unhold kubectl
   Canceled hold on kubelctl

   -- upgrade kubectl
   $ sudo apt install -y kubectl=1.18.2-00
   
   -- Get the version
   $ kubectl version --short
   Client Version: v1.18.2
   Server Version: v1.18.2

   ```

   Step 10: Upgrade the version of kubelet and hold the version of kubelet
   ```
   $ sudo apt install -y kubelet=1.18.2-00
   $ sudo apt-mark hold kubelet
   kubelet set on hold.
   ```
   
   #### Command References
   ```bash
    
   ```  
   #### References and Further Study
   * https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-upgrade/
   * https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md
   * https://kubernetes.io/docs/concepts/overview/kubernetes-api/
   * https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api_changes.md
   
   
   ### Operating System Upgrades
   
   #### Terms:  
   In operating system upgrade some terms are very important
   
   1. Drain: When a node drain, Pod are terminated form the node and Pod are recreated on another node where requirement match.
    Also node marked as unscheduled, meaning no Pod can be schedule on this node until you specify Scheduled or uncordon.
    Using it Pod can safe on other node.  
   2. Cordon: Marked node as unschedule able.  
   3. Uncordon: Marked node as scheduleable so that Pod can schedule on this node.
   
   Process: 
   1. Evict the Pod from node using drain and take node down.
   2. Maintains the node
   2. After maintenance continue scheduling using uncordon the node.
   
   See which pods are running on which nodes:  
   ```$ kubectl get pods -o wide```  
   
   Evict the pods on a node:  
   ```$ kubectl drain [node_name] --ignore-daemonsets```  
   
   Watch as the node changes status:  
   ```$ kubectl get nodes -w```  
   
   Schedule pods to the node after maintenance is complete:
   ```$ kubectl uncordon [node_name]```  
   
   Remove a node from the cluster:  
   ```$ kubectl delete node [node_name]```  
   
   Generate a new token:  
   ```$ sudo kubeadm token generate```  
    
   List the tokens:  
   ```$ sudo kubeadm token list```  
    
   Print the kubeadm join command to join a node to the cluster:  
   ```$ sudo kubeadm token create [token_name] --ttl 2h --print-join-command ```  
    
       
   #### Command References
   ```bash
    $ kubectl drain [node_name]
    $ kubectl cordon [node_name]
    $ kubectl cordon [node_name]
    $ kubectl delete [node_name]
    $ kubectl edit [node_name]
   ```  
   #### References and Further Study
   * https://kubernetes.io/docs/tasks/administer-cluster/cluster-management/#maintenance-on-a-node  
   
   
   ### Backup and Restore Methodologies
   Working with ETCDCTL


etcdctl is a command line client for etcd.



In all our Kubernetes Hands-on labs, the ETCD key-value database is deployed as a static pod on the master. The version used is v3.

To make use of etcdctl for tasks such as back up and restore, make sure that you set the ETCDCTL_API to 3.



You can do this by exporting the variable ETCDCTL_API prior to using the etcdctl client. This can be done as follows:

export ETCDCTL_API=3

On the Master Node:





To see all the options for a specific sub-command, make use of the -h or --help flag.



For example, if you want to take a snapshot of etcd, use:

etcdctl snapshot save -h and keep a note of the mandatory global options.



Since our ETCD database is TLS-Enabled, the following options are mandatory:

--cacert                                                verify certificates of TLS-enabled secure servers using this CA bundle

--cert                                                    identify secure client using this TLS certificate file

--endpoints=[127.0.0.1:2379]          This is the default as ETCD is running on master node and exposed on localhost 2379.

--key                                                      identify secure client using this TLS key file





Similarly use the help option for snapshot restore to see all available options for restoring the backup.

etcdctl snapshot restore -h

For a detailed explanation on how to make use of the etcdctl command line tool and work with the -h flags, check out the solution video for the Backup and Restore Lab.
   #### Backup
   There are 2 back candidates
   ```
    1. Resource Configuration
    2. ETCD Cluster
   ```
   ##### 1. Resource Configuration:  
      you can take all configuration from a cluster using  
      ```$ kubectl get all --all-namespaces -o yaml > all_deploy_service.yaml```  
   
   ##### 2. ETCD Cluster:  
   Take backup on specific location
   ```
    $ ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key snapshot save /tmp/snapshot-pre-boot.db
    Snapshot saved at /tmp/snapshot-pre-boot.db
   ```
   
   See the status of snapshot
   ```
   $ ETCDCTL_API=3 etcdctl snapshot status /tmp/snapshot-pre-boot.db
    436037d5, 2612, 854, 2.3 MB
   ```
   
   #### Restore
   Restore ETCD Snapshot to a new folder
   ```
   ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt \
     --name=master \
     --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key \
     --data-dir /var/lib/etcd-from-backup \
     --initial-cluster=master=https://127.0.0.1:2380 \
     --initial-cluster-token etcd-cluster-1 \
     --initial-advertise-peer-urls=https://127.0.0.1:2380 \
     snapshot restore /tmp/snapshot-pre-boot.db
   ```

   Modify /etc/kubernetes/manifests/etcd.yaml
   ```
    -- open etcd.yaml and add following lines under command
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
   
   
## Chapter 4: Networking (11%)
   ### Network Pre-requisite
   
   #### Command References
   ```bash
    -- Manage and display the state of all network
interfaces
    $ ip link
    $ ip link set em1 down
    $ ip link set em1 mtu 9000
    $ ip link add veth-red type veth peer name veth-bridge

    -- Display IP Addresses and property information
    $ ip addr
    $ ip addr add 192.168.1.1/24 dev em1

    -- Display and alter the routing table
    $ ip route

    -- see all interface in a network
    $ ip arp

    -- Manage network namespace
    $ ip netns
    $ ip netns add blue
    $ ip netns exec red blue
   ``` 

   #### References and Further Study
   * [IP Command](https://access.redhat.com/sites/default/files/attachments/rh_ip_command_cheatsheet_1214_jcs_print.pdf)
  
   
   
   #### Network Namespace
   
   Create network namespaces  
   1. Create Network Namespace  
   ```
   -- create two network namespace red and blue
   $ ip netns add red
   $ ip netns add blue
   ```
   2. Create Bridge Network/Interface  
   ```
   -- create bridge network
   $ ip link add v-net-0 type bridge
   ```
   3. Create VETH Pairs (Pipe/Virtual Cable)  
   ```
   -- create ip network cable
   $ ip link add veth-red type veth peer name veth-red-br
   $ ip link add veth-blue type veth peer name veth-blue-br
   ```
   4. Attach vEth to Namespace  
   ```
   -- attach blue and red cable with namespace
   $ ip link set veth-red netns red
   $ ip link set veth-blue netns blue
   ```

   5. Attach Other vEth to Bridge  
   ```
   -- attach cable with bridge
   $ ip link set veth-red-br master v-net-0
   $ ip link set veth-blue-br master v-net-0
   ```

   6. Assign IP Address  
   ```
   -- set ip address with blue and red namepsace
   $ ip -n red addr add 192.168.15.1 dev veth-red
   $ ip -n blue addr add 192.168.15.2 dev veth-blue
   ```

   7. Bring the Interface UP  
   ```
   -- bring namespce and bridge network up
   $ ip -n red link set veth-red up
   $ ip -n blue link set veth-blue up
   $ ip link set dev v-net-0 up
   ```
   8. Enable NAT-IP Masquerade  
   ```
   -- enable nat-ip masquerade
   $ iptable -t nat -A POSTROUTING -s 192.168.15.0/24 -j MASQUERADE
   ```
   
   ### Node Networking Concepts
   For node networking  
   * Each node must have a Interface
   * Each node must have a MAC Address  
   
   #### Ports
   * kube-apiserver = 6443
   * kube-scheduler = 10251
   * kube-controller-manager = 10252
   * etcd = 2379 (For multiple 2380)
   * kubelet = 10250
   * worker-node = 30000-32767
   
   #### Command References
   ```bash
    
   ``` 


   #### References and Further Study
   * https://kubernetes.io/docs/concepts/cluster-administration/networking/
   
   ### Pod Networking Concepts
   #### Command References
   ```bash
    
   ``` 

   #### References and Further Study
   
   
   ### Service Networking Concepts
   To make a POD accessible create a service for that POD. Service is actually create a forwarding rule in each node  
   
   | IP Address     | Forward To    |
   | -------------  | ------------- |
   | 192.168.13.178 | 10.244.1.2    |
   
   
   ##### ClusterIP: 
   To make a POD accessible for all POD within the cluster create a service with type clusterIP.
   ##### NodePort:
   When a POD is needed to access by outside of the cluster then it's called nodePort.
   ##### LoadBalancer:
   When a POD is needed to access by outside of the cluster then it's called nodePort.
   
   Marjor Terms:  
   * Kube-proxy
   * iptables
   * ipvs
   
   #### Command References
   ```bash
    
   ``` 

   #### References and Further Study
   * https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types
   
   
   ### Container Network Interface (CNI)
   #### Command References
   ```bash
    
   ``` 

   #### References and Further Study
   
   
   ### Load Balancer Configure and Deploy
   #### Command References
   ```bash
    
   ``` 

   #### References and Further Study
   
   
   ### Ingress Rules Configure
   Ingress is a layer 7 load balancer built-in with kubernetes which implement SSL.
   Ingress need services to communicate with outer world.  
   Two major component in Ingress  
   ```
   1. Ingress Controller
   2. Ingress Resources   
   ```
   #### Ingress Controller
   Ingress Controller is not default in kubernetes. It need to configure manually.  
   Steps:  
   * Create a NGINX Deployment.
   * Create an Config Object.
   * Create an Service Account.
   * Create an Auth Object.
   
   #### Ingress Resources
   Ingress Resource creates in kubenetes definition file ```ingress-wear.yaml```.
   Traffic goes based on 
   ```
   1. Route
   2. Domain Name
   ```
   Ingress Resource Rules:
   
   #### Command References
   ```bash
    
   ``` 

   #### References and Further Study
   
   
   ### Cluster DNS Configure
   Fully qualified domain name
   
   |    Hostname   |   Namespace   |     Type      |      Root     | IP Address
   | ------------- | ------------- | ------------- | ------------- | ------------- |
   | web-service   |   apps        |    svc        | cluster.local | 10.10.56.20   |
   | 10-12-30-20   |   apps        |    pod        | cluster.local | 10.12.30.20   |
   
   #### Command References
   ```bash
    
   ``` 

   #### References and Further Study
   
   
   
## Chapter 5: Scheduling (5%)
   The default scheduler goes through a series of steps to determine the right node for the pod. 
   1. Is the node running out of resources?
   2. Does the pods request a specific node?
   3. Does the node have a matching label?
   4. If the pod request a port, is it available?
   5. If the pod request a volume, can it be mounted?
   6. Does the pod tolerate the taints of the node?
   7. Does the pod specify node or pod affinity?
   
   ### Kubernetes Labels and Selectors to Schedule Pods
   Kubernetes uses Labels and Selector internally to group object and connect objection together.
   
   #### Labels
   Lebels used in kubernetes to lebel an object under the metadata section
   ```bash
    apiVersion: v1
    kind: Pod
    metadata:
      name: nginx
      labels:
         app: application
    spec:
      containers:
      - name: nginx
        image: nginx
   ``` 
   #### Selector
   Kubernetes uses selector to select labels which is defined under metadata section.
   selector can used in selecting labels like ```kubectl get pods -selector app=application```.  
   Selector definition file:
   
   ```bash
    apiVersion: v1
    kind: Service
    metadata:
      name: my-service
    spec:
      selector:
        app: application
      ports:
        - protocol: TCP
          port: 80
          targetPort: 9376
   ``` 
   #### Annotations
   Annotations is used to record additional information about a object like build,version,email,phone_no etc under metadata section.
   ```bash
    apiVersion: v1
    kind: Pod
    metadata:
      name: nginx
      labels:
         app: application
      annotations:
         build: 12.01.01
         phone: +011 001 0001
    spec:
      containers:
      - name: nginx
        image: nginx
   ``` 
   
   #### Command References
   ```bash
    $ kubectl get pods -selector app=application
   ``` 

   #### References and Further Study
   * https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/
   
   ### Role of DaemonSets
   
   #### Command References
   ```bash
    
   ``` 

   #### References and Further Study
   
   ### Resource Limits and Labels in Pods Scheduling
   
   #### Command References
   ```bash
    
   ``` 

   #### References and Further Study
   * https://kubernetes.io/docs/tasks/configure-pod-container/assign-memory-resource/
   * https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/memory-default-namespace/
   * https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/cpu-default-namespace/
   
   
   ### Multiple Schedulers to Run and Configure Pods
   
   #### Command References
   

   #### References and Further Study
   
   ### Manually Schedule a Pods
   When kube-scheduler does not installed or configure on cluster, then Pods can be manually schedule in Node using add a  property ```nodeName``` direct child of spec in Pod definition yaml file. 
   ```bash
    apiVersion: v1
    kind: Pod
    metadata:
      name: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
      nodeName: kube-01
   ``` 
   
   #### Command References
   ```bash
    --  check for kube-scheduler install or not
    $ kubectl get pods -n kube-system
   ``` 

   #### References and Further Study
   
   ### Scheduler Events
   
   #### Command References
   ```bash
    
   ``` 

   #### References and Further Study
   
   ### Configure Kubernetes Scheduler
   
   #### Command References
   ```bash
    
   ``` 

   #### References and Further Study


## Chapter 6: Application Lifecycle (8%)
   * ### Deploying an Application with Rolling Updates and Rollback
   * ### Configure Highly Available Application
   * ### Scale Applications
   * ### Manage Self-Healing Application
  
## Chapter 7: Storage (7%)
   * ### Manage Persistent Volume
   * ### Volume Access Modes
   * ### Manage Persistent Volume Claims
   * ### Manage Storage Objects
   * ### Configure Application with Storage
  
## Chapter 8: Security (12%)
   * ### Security Primitives
   * ### Configure Authentication and Authorization
   * ### Configure Network Policies
   * ### Manage TLS Certificate for Cluster
   * ### Image Security
   * ### Security Contexts
   * ### Persistent Key Value Stores
   
## Chapter 9: Log and Monitor (5%)
   * ### Monitor All Cluster Component
   * ### Monitor Applications
   * ### Cluster Component Logs
   * ### Manage Application Logs
   
## Chapter 10: Troubleshooting (10%)
   ### Application Failure
   Following error exception will raise with POD
   * AppCommErr
   * CrashLookBackoffErr
   * FailedMountErr
   * Pending
   * RbacErr
   * ImagePullErr
   * DiscoveryErr
   
   Consider a 2-tier application for figuring out application failure. Look through below image 
   
   ![Application Failure](./image/application_failure.png)
   
   #### Components:
   * NodePort
   * Web Service
   * Web
   * DB Service
   * DB 
   
   Check every component until you find the issue
   
   * Node PortWeb Service:  
    Check the node-port of the web service if the ip of the nodePort accessible.
   ```
   $ curl http://web-service-ip:node-port
   ```
    
   * Web Service:  
    View details of the web service object and find parameters selectors and endpoints.
    And also view the WEB Pods and match with web service selector and pod selector exactly same.
   ```
   -- Get details of service
   $ kubectl describe svc web-service

   -- Get yaml of the pod
   $ kubectl get pod WEB -o yaml 
   ```
    
   * WEB:  
    Check status of the POD and look at the status of STATUS and RESTARTS parameters. Make sure STATUS is running and RESTARTS will be zero.
    If so check the events of the POD  
   ``` 
    $ kubectl describe pod WEB 
   ```
    
   Check the logs of the POD  
    
   ``` 
    -- Get the current version of the POD
    $ kubectl logs WEB
    
    -- Watch the logs 
    $ kubectl logs WEB -f
    
    -- Wathc the previous logs of the POD
    $ kubectl logs WEB -f --previous
   ```
    
   * DB Service:  
    View details of the db service object and find parameters selectors and endpoints.
    And also view the WEB Pods and match with db service selector and pod selector exactly same.
   ```
   -- Get details of service
   $ kubectl describe svc db-service

   -- Get yaml of the pod
   $ kubectl get pod DB -o yaml 
   ```

   * DB:  
    Check status of the POD and look at the status of STATUS and RESTARTS parameters. Make sure STATUS is running and RESTARTS will be zero.
    If so check the events of the POD  
    
   ``` 
    $ kubectl describe pod DB 
   ```
    
   Check the logs of the POD  
   ``` 
   -- Get the current version of the POD
   $ kubectl logs DB
    
   -- Watch the logs 
   $ kubectl logs DB -f
    
   -- Wathc the previous logs of the POD
   $ kubectl logs DB -f --previous
   ```
   
   #### References and Further Study
   *
   
   ### Control Plane Failure
   If a control panel components fail then look through the manifest file in kubernetes directory or service file.
   And fix those file. Follow the series of steps in Control Panel components. 
   
   ##### Check Node Status
   ```
   $ kubectl get nodes
   ```   

   ##### Check POD Status
   ```
   -- Check default namespaces pods
   $ kubectl get pods
   ```
   #### Deployment Process
   * Using Kubeadm
   ```
   -- Check service in pods
   $ kubectl get pods -n kube-system
    NAME                             READY   STATUS             RESTARTS   AGE
    coredns-5644d7b6d9-9pmlh         1/1     Running            0          33m
    coredns-5644d7b6d9-tkrnq         1/1     Running            0          33m
    etcd-master                      1/1     Running            0          32m
    kube-apiserver-master            1/1     Running            0          32m
    kube-controller-manager-master   1/1     Running            0          31m
    kube-proxy-qhmwn                 1/1     Running            0          33m
    kube-proxy-vsjrg                 1/1     Running            0          32m
    kube-scheduler-master            0/1     CrashLoopBackOff   1          30s
    weave-net-fhlrb                  2/2     Running            0          33m
    weave-net-zgd4p                  2/2     Running            0          32m


   -- Check control panel pods
   $ kubectl logs kube-apiserver-master -n kube-system
   $ kubectl logs kube-controller-manager-master -n kube-system
   $ kubectl logs kubelet -n kube-system
   $ kubectl logs kube-proxy -n kube-system
   ```
   * Using Services
   
   * Using Services: Check control place services
   ```
   -- Check kube-apiserver services in Master Node
   $ service kube-apiserver status

   -- Check kube-controller-manager services in Master Node
   $ service kube-controller-manager status

   -- Check kube-scheduler services in Master Node
   $ service kube-scheduler status

   -- Check kubelet services in Worker Node
   $ service kubelet status

   -- Check kube-proxy services in Worker Node
   $ service kube-proxy status

   -- Check logs of Control Panel Component
   $ sudo journalctl -u kube-apiserver
   $ sudo journalctl -u kube-controller-manager
   $ sudo journalctl -u kube-scheduler
   $ sudo journalctl -u kubelet
   $ sudo journalctl -u kube-proxy
   ```


   #### Command References

   ```bash
    -- view the events of control panel components
    $ kubectl get events -n kube-system

    -- view the logs of control panel pods
    $ kubectl logs kube-scheduler-master -n kube-system

    -- check the status of docker service
    $ sudo systemctl status docker

    -- enable and start the docker service
    $ sudo systemctl enable docker && sudo systemctl start docker

    -- check the status of kubelet service
    $ sudo systemctl status kubelet
    
    -- enable and start the kubelet service
    $ sudo systemctl enable kubelet && sudo systemctl start kubelet

    -- disable swap
    $ sudo swapoff -a && sed -i '/ swap / s/^/#/' /etc/fstab
    
    -- check if the firewalld service running
    $ sudo systemctl status firewalld

    -- disable firewalld and stop the service
    $ sudo systemctl disable firewalld && sudo systemctl stop firewalld

    -- view config view
    $ kubectl config view

   ``` 

   #### References and Further Study
   * https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/
   
   ### Worker Node Failure
   If a control panel components fail then look through the manifest file in kubernetes directory or service file.
   And fix those file. Follow the series of steps in Control Panel components. 
   
   ##### Check Node Status
   ```
   $ kubectl get nodes
   
   -- check node condition section in details
   $ kubectl describe node worker-1
   
   -- check node memory
   $ top

   -- check node disk spaces
   $ df -h 

   -- check kubelet status and kubelet logs
   $ service kubelet status
   $ sudo journalctl -u kubelet
 

   -- check certificates
   $ openssl x509 -n /var/lib/kubelet/worker-1.crt -text

   ```   

   #### Command References
   ```bash
   -- look at the IP address of the node
   $ kubectl get pods -selector app=application

   -- try to ping the down node
   $ ping 172.31.29.182

   -- generate a token for a new node
   $ sudo kubeadm token generate

   -- print the kubeadm join command to add a new node to the cluster
   $ sudo kubeadm toker create [token_name] --ttl 2h --print-join-command 

   -- stop the kubernetes service
   $ sudo systemctl stop kubelet 

   -- view the kubelet journalctl logs 
   $ sudo journalctl -u kubelet 

   -- view the syslog events
   $ sudo more syslog | tail -120 | grep kubelet
   ``` 

   #### References and Further Study
   * https://kubernetes.io/docs/tasks/debug-application-cluster/debug-cluster/
   
   ### Network Failure
   
   
   
   
   #### Command References
   ```bash
    $ kubectl get pods -selector app=application
   ``` 

   #### References and Further Study
   * https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/



```bash
kubectl logs -h

--check system componet logs
kubectl get pods -A
kubectl get pods --all-namespaces

kubectl logs --namespace kube-system kube-flannel-ds-amd64-54wxq
kubectl logs -n kube-system kube-flannel-ds-amd64-54wxq

--check logs for pods
kubectl get pods
kubectl logs nginx-6db489d4b7-5m7dx
kubectl logs nginx-6db489d4b7-5m7dx --all-containers=true

kubectl describe pod nginx-6db489d4b7-5m7dx

```



### Namespace

```bash
kubectl create namespace dev
kubectl config current-context
kubectl config set-context $(kubectl config current-context) --namespace dev

arif@kube-master:~$ kubectl config current-context
kubernetes-admin@kubernetes

```



#### kubectl run/create

```bash
kubectl run --generator=run-pod/v1 nginx --image=nginx
kubectl run --generator=run-pod/v1 nginx --image=nginx --dry-run -o yaml


kubectl create deployment --image=nginx nginx
kubectl create deployment --image=nginx nginx --dry-run -o yaml

--not supported depoyment since v1.16
kubectl run --generator=deployment/v1beta1 nginx --image=nginx --dry-run --replicas=4 -o yaml
kubectl create deployment --image=nginx nginx --replicas=4 --dry-run -o yaml


kubectl create service clusterip redis --tcp=6379:6379 --dry-run -o yaml
kubectl expose pod nginx --port=80 --name nginx-service --dry-run -o yaml



```



deployment check

```bash
kubectl rollout status deployments/nginx
kubectl rollout history deployments/nginx


```



Replica set

```bash
kubectl get replicasets
```





```bash

kubectl get deployments -A

kubectl run vaaa1 --image=arif332/vaaa
kubectl delete deployment nginx

```





#### kubectl exec

```bash
 kubectl exec etcd-kube-master -n kube-system etcdctl
 kubectl exec etcd-kube-master -n kube-system etcdctl help get
 
```



Check Certificate

```bash
sudo kubeadm alpha certs check-expiration
kubectl -n kube-system get cm kubeadm-config -oyaml


kubeadm upgrade apply --certificate-renewal=false
kubeadm upgrade node --certificate-renewal=false

kubeadm alpha certs renew

```
























## Networking

###### Namespace

```bash
ip netns exec red ip link
ip -n red link

```



###### docker networking

```bash

ip link add docker type bridge

#docker expose do dnat in host iptables
iptables -nvl -t nat

```



###### CNI

```bash

plugin
bridge
vlan
ipvlan

CNM (container network model)


ps -aux|grep kubelet

```



###### Service

```bash
ps aux|grep kube-api
sudo iptables -L

cluster service
nodeport
forwarding rule - ip and port

userspace
iptables
ipvs



```



###### DNS

```bash
kube-dns
core-dns

pod dns

service dns

service name


curl http://web-service.apps.svc.cluster.local

web-serv.default.svc.cluster.local
web-service.apps.svc.cluster.local
10-12-12-12.apps.pod.cluster.local

kubectl get service -n kube-system
arif@kube-master:~$ kubectl get service -n kube-system
NAME       TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE
kube-dns   ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   10d

how core dns setup done
where is forwarding zone
where is reverse zone


```





###### Ingress

```bash
Ingress Controller
Ingress resource

host
path

Deployment
service
ConfigMap
Auth

kubectl get ingress


- create a ingress service
- understand ingress perfectly

```





## E2E

```bash
build
deploy
test
cleanup

```











## Appendix:



#### kubectl

```bash
arif@kube-master:~$ kubectl -h
kubectl controls the Kubernetes cluster manager.

 Find more information at: https://kubernetes.io/docs/reference/kubectl/overview/

Basic Commands (Beginner):
  create         Create a resource from a file or from stdin.
  expose         Take a replication controller, service, deployment or pod and expose it as a new Kubernetes Service
  run            Run a particular image on the cluster
  set            Set specific features on objects

Basic Commands (Intermediate):
  explain        Documentation of resources
  get            Display one or many resources
  edit           Edit a resource on the server
  delete         Delete resources by filenames, stdin, resources and names, or by resources and label selector

Deploy Commands:
  rollout        Manage the rollout of a resource
  scale          Set a new size for a Deployment, ReplicaSet or Replication Controller
  autoscale      Auto-scale a Deployment, ReplicaSet, or ReplicationController

Cluster Management Commands:
  certificate    Modify certificate resources.
  cluster-info   Display cluster info
  top            Display Resource (CPU/Memory/Storage) usage.
  cordon         Mark node as unschedulable
  uncordon       Mark node as schedulable
  drain          Drain node in preparation for maintenance
  taint          Update the taints on one or more nodes

Troubleshooting and Debugging Commands:
  describe       Show details of a specific resource or group of resources
  logs           Print the logs for a container in a pod
  attach         Attach to a running container
  exec           Execute a command in a container
  port-forward   Forward one or more local ports to a pod
  proxy          Run a proxy to the Kubernetes API server
  cp             Copy files and directories to and from containers.
  auth           Inspect authorization

Advanced Commands:
  diff           Diff live version against would-be applied version
  apply          Apply a configuration to a resource by filename or stdin
  patch          Update field(s) of a resource using strategic merge patch
  replace        Replace a resource by filename or stdin
  wait           Experimental: Wait for a specific condition on one or many resources.
  convert        Convert config files between different API versions
  kustomize      Build a kustomization target from a directory or a remote url.

Settings Commands:
  label          Update the labels on a resource
  annotate       Update the annotations on a resource
  completion     Output shell completion code for the specified shell (bash or zsh)

Other Commands:
  api-resources  Print the supported API resources on the server
  api-versions   Print the supported API versions on the server, in the form of "group/version"
  config         Modify kubeconfig files
  plugin         Provides utilities for interacting with plugins.
  version        Print the client and server version information

Usage:
  kubectl [flags] [options]

Use "kubectl <command> --help" for more information about a given command.
Use "kubectl options" for a list of global command-line options (applies to all commands).
arif@kube-master:~$ 

```



#### kubectl options

```bash
arif@kube-master:~$ kubectl options
The following options can be passed to any command:

      --add-dir-header=false: If true, adds the file directory to the header
      --alsologtostderr=false: log to standard error as well as files
      --as='': Username to impersonate for the operation
      --as-group=[]: Group to impersonate for the operation, this flag can be repeated to specify multiple groups.
      --cache-dir='/home/arif/.kube/http-cache': Default HTTP cache directory
      --certificate-authority='': Path to a cert file for the certificate authority
      --client-certificate='': Path to a client certificate file for TLS
      --client-key='': Path to a client key file for TLS
      --cluster='': The name of the kubeconfig cluster to use
      --context='': The name of the kubeconfig context to use
      --insecure-skip-tls-verify=false: If true, the server's certificate will not be checked for validity. This will
make your HTTPS connections insecure
      --kubeconfig='': Path to the kubeconfig file to use for CLI requests.
      --log-backtrace-at=:0: when logging hits line file:N, emit a stack trace
      --log-dir='': If non-empty, write log files in this directory
      --log-file='': If non-empty, use this log file
      --log-file-max-size=1800: Defines the maximum size a log file can grow to. Unit is megabytes. If the value is 0,
the maximum file size is unlimited.
      --log-flush-frequency=5s: Maximum number of seconds between log flushes
      --logtostderr=true: log to standard error instead of files
      --match-server-version=false: Require server version to match client version
  -n, --namespace='': If present, the namespace scope for this CLI request
      --password='': Password for basic authentication to the API server
      --profile='none': Name of profile to capture. One of (none|cpu|heap|goroutine|threadcreate|block|mutex)
      --profile-output='profile.pprof': Name of the file to write the profile to
      --request-timeout='0': The length of time to wait before giving up on a single server request. Non-zero values
should contain a corresponding time unit (e.g. 1s, 2m, 3h). A value of zero means don't timeout requests.
  -s, --server='': The address and port of the Kubernetes API server
      --skip-headers=false: If true, avoid header prefixes in the log messages
      --skip-log-headers=false: If true, avoid headers when opening log files
      --stderrthreshold=2: logs at or above this threshold go to stderr
      --token='': Bearer token for authentication to the API server
      --user='': The name of the kubeconfig user to use
      --username='': Username for basic authentication to the API server
  -v, --v=0: number for the log level verbosity
      --vmodule=: comma-separated list of pattern=N settings for file-filtered logging
arif@kube-master:~$ 
```



#### kubectl create

```bash
arif@kube-master:~$ kubectl create -h
Create a resource from a file or from stdin.

 JSON and YAML formats are accepted.

Examples:
  # Create a pod using the data in pod.json.
  kubectl create -f ./pod.json
  
  # Create a pod based on the JSON passed into stdin.
  cat pod.json | kubectl create -f -
  
  # Edit the data in docker-registry.yaml in JSON then create the resource using the edited data.
  kubectl create -f docker-registry.yaml --edit -o json

Available Commands:
  clusterrole         Create a ClusterRole.
  clusterrolebinding  Create a ClusterRoleBinding for a particular ClusterRole
  configmap           Create a configmap from a local file, directory or literal value
  cronjob             Create a cronjob with the specified name.
  deployment          Create a deployment with the specified name.
  job                 Create a job with the specified name.
  namespace           Create a namespace with the specified name
  poddisruptionbudget Create a pod disruption budget with the specified name.
  priorityclass       Create a priorityclass with the specified name.
  quota               Create a quota with the specified name.
  role                Create a role with single rule.
  rolebinding         Create a RoleBinding for a particular Role or ClusterRole
  secret              Create a secret using specified subcommand
  service             Create a service using specified subcommand.
  serviceaccount      Create a service account with the specified name

Options:
      --allow-missing-template-keys=true: If true, ignore any errors in templates when a field or map key is missing in
the template. Only applies to golang and jsonpath output formats.
      --dry-run=false: If true, only print the object that would be sent, without sending it.
      --edit=false: Edit the API resource before creating
  -f, --filename=[]: Filename, directory, or URL to files to use to create the resource
  -k, --kustomize='': Process the kustomization directory. This flag can't be used together with -f or -R.
  -o, --output='': Output format. One of:
json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.
      --raw='': Raw URI to POST to the server.  Uses the transport specified by the kubeconfig file.
      --record=false: Record current kubectl command in the resource annotation. If set to false, do not record the
command. If set to true, record the command. If not set, default to updating the existing annotation value only if one
already exists.
  -R, --recursive=false: Process the directory used in -f, --filename recursively. Useful when you want to manage
related manifests organized within the same directory.
      --save-config=false: If true, the configuration of current object will be saved in its annotation. Otherwise, the
annotation will be unchanged. This flag is useful when you want to perform kubectl apply on this object in the future.
  -l, --selector='': Selector (label query) to filter on, supports '=', '==', and '!='.(e.g. -l key1=value1,key2=value2)
      --template='': Template string or path to template file to use when -o=go-template, -o=go-template-file. The
template format is golang templates [http://golang.org/pkg/text/template/#pkg-overview].
      --validate=true: If true, use a schema to validate the input before sending it
      --windows-line-endings=false: Only relevant if --edit=true. Defaults to the line ending native to your platform.

Usage:
  kubectl create -f FILENAME [options]

Use "kubectl <command> --help" for more information about a given command.
Use "kubectl options" for a list of global command-line options (applies to all commands).
arif@kube-master:~$ 

```





##### kubectl exec etcd-...

```bash
arif@kube-master:~$ kubectl exec etcd-kube-master -n kube-system etcdctl
NAME:
	etcdctl - A simple command line client for etcd3.

USAGE:
	etcdctl [flags]

VERSION:
	3.4.3

API VERSION:
	3.4


COMMANDS:
	alarm disarm		Disarms all alarms
	alarm list		Lists all alarms
	auth disable		Disables authentication
	auth enable		Enables authentication
	check datascale		Check the memory usage of holding data for different workloads on a given server endpoint.
	check perf		Check the performance of the etcd cluster
	compaction		Compacts the event history in etcd
	defrag			Defragments the storage of the etcd members with given endpoints
	del			Removes the specified key or range of keys [key, range_end)
	elect			Observes and participates in leader election
	endpoint hashkv		Prints the KV history hash for each endpoint in --endpoints
	endpoint health		Checks the healthiness of endpoints specified in `--endpoints` flag
	endpoint status		Prints out the status of endpoints specified in `--endpoints` flag
	get			Gets the key or a range of keys
	help			Help about any command
	lease grant		Creates leases
	lease keep-alive	Keeps leases alive (renew)
	lease list		List all active leases
	lease revoke		Revokes leases
	lease timetolive	Get lease information
	lock			Acquires a named lock
	make-mirror		Makes a mirror at the destination etcd cluster
	member add		Adds a member into the cluster
	member list		Lists all members in the cluster
	member promote		Promotes a non-voting member in the cluster
	member remove		Removes a member from the cluster
	member update		Updates a member in the cluster
	migrate			Migrates keys in a v2 store to a mvcc store
	move-leader		Transfers leadership to another etcd cluster member.
	put			Puts the given key into the store
	role add		Adds a new role
	role delete		Deletes a role
	role get		Gets detailed information of a role
	role grant-permission	Grants a key to a role
	role list		Lists all roles
	role revoke-permission	Revokes a key from a role
	snapshot restore	Restores an etcd member snapshot to an etcd directory
	snapshot save		Stores an etcd node backend snapshot to a given file
	snapshot status		Gets backend snapshot status of a given file
	txn			Txn processes all the requests in one transaction
	user add		Adds a new user
	user delete		Deletes a user
	user get		Gets detailed information of a user
	user grant-role		Grants a role to a user
	user list		Lists all users
	user passwd		Changes password of user
	user revoke-role	Revokes a role from a user
	version			Prints the version of etcdctl
	watch			Watches events stream on keys or prefixes

OPTIONS:
      --cacert=""				verify certificates of TLS-enabled secure servers using this CA bundle
      --cert=""					identify secure client using this TLS certificate file
      --command-timeout=5s			timeout for short running command (excluding dial timeout)
      --debug[=false]				enable client-side debug logging
      --dial-timeout=2s				dial timeout for client connections
  -d, --discovery-srv=""			domain name to query for SRV records describing cluster endpoints
      --discovery-srv-name=""			service name to query when using DNS discovery
      --endpoints=[127.0.0.1:2379]		gRPC endpoints
  -h, --help[=false]				help for etcdctl
      --hex[=false]				print byte strings as hex encoded strings
      --insecure-discovery[=true]		accept insecure SRV records describing cluster endpoints
      --insecure-skip-tls-verify[=false]	skip server certificate verification
      --insecure-transport[=true]		disable transport security for client connections
      --keepalive-time=2s			keepalive time for client connections
      --keepalive-timeout=6s			keepalive timeout for client connections
      --key=""					identify secure client using this TLS key file
      --password=""				password for authentication (if this option is used, --user option shouldn't include password)
      --user=""					username[:password] for authentication (prompt if password is not supplied)
  -w, --write-out="simple"			set the output format (fields, json, protobuf, simple, table)

arif@kube-master:~$ kubectl exec etcd-kube-master -n kube-system etcdctl

```







firewall

```bash
arif@ariflindesk1:~$ sudo iptables -t nat -L
Chain PREROUTING (policy ACCEPT)
target     prot opt source               destination         
DOCKER     all  --  anywhere             anywhere             ADDRTYPE match dst-type LOCAL

Chain INPUT (policy ACCEPT)
target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination         
DOCKER     all  --  anywhere            !localhost/8          ADDRTYPE match dst-type LOCAL

Chain POSTROUTING (policy ACCEPT)
target     prot opt source               destination         
MASQUERADE  all  --  172.17.0.0/16        anywhere            
MASQUERADE  all  --  172.21.0.0/16        anywhere            
MASQUERADE  all  --  10.80.95.0/24        anywhere            
MASQUERADE  all  --  172.18.0.0/16        anywhere            
RETURN     all  --  192.168.122.0/24     base-address.mcast.net/24 
RETURN     all  --  192.168.122.0/24     255.255.255.255     
MASQUERADE  tcp  --  192.168.122.0/24    !192.168.122.0/24     masq ports: 1024-65535
MASQUERADE  udp  --  192.168.122.0/24    !192.168.122.0/24     masq ports: 1024-65535
MASQUERADE  all  --  192.168.122.0/24    !192.168.122.0/24    
MASQUERADE  all  --  192.168.56.0/24      anywhere            

Chain DOCKER (2 references)
target     prot opt source               destination         
RETURN     all  --  anywhere             anywhere            
RETURN     all  --  anywhere             anywhere            
RETURN     all  --  anywhere             anywhere            
RETURN     all  --  anywhere             anywhere            

```



```bash
arif@ariflindesk1:~$ sysctl -p
arif@ariflindesk1:~$ firewall-cmd --get-default-zone
public
arif@ariflindesk1:~$ firewall-cmd --get-active-zones
public
  interfaces: eno2 wlo1
arif@ariflindesk1:~$ firewall-cmd --get-zones
block dmz drop external home internal public trusted work
arif@ariflindesk1:~$ 


--enable masquerade
firewall-cmd --zone=public --add-masquerade
firewall-cmd --add-masquerade --zone=public --permanent
firewall-cmd --zone=external --query-masquerade


firewall-cmd --zone=external --add-forward-port=port=22:proto=tcp:toport=3753
firewall-cmd --permanent --zone=external --add-forward-port=port=22:proto=tcp:toport=3753:toaddr=10.0.0.1
firewall-cmd --reload

```

