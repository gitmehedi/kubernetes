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
   * [Upgrading the cluster](#upgrading-the-cluster)
   * [OS Upgrades](#os-upgrades)
   * [Restoring a Cluster](#restoring-a-cluster)
   * [Understand Kubernetes cluster upgrade process.](#understand-kubernetes-cluster-upgrade-process)
   * [Facilitate operating system upgrades.](#facilitate-operating-system-upgrades)
   * [Implement backup and restore methodologies](#implement-backup-and-restore-methodologies)

* [Chapter 4: Networking (11%)](#chapter-4-networking-11)
   * [Pod and Node Networking](#pod-and-node-networking) 
   * [Container Network Interface](#container-network-interface) 
   * [Service Networking](#service-networking) 
   * [Ingress and Load Balancers](#ingress-and-load-balancers) 
   * [Cluster DNS](#cluster-dns) 
   * [Understand the networking configuration on the cluster nodes](#understand-the-networking-configuration-on-the-cluster-nodes) 
   * [Understand Pod networking concepts](#understand-pod-networking-concepts) 
   * [Understand service networking](#understand-service-networking) 
   * [Deploy and configure network load balancer](#deploy-and-configure-network-load-balancer) 
   * [Know how to use Ingress rules](#know-how-to-use-ingress-rules) 
   * [Know how to configure and use the cluster DNS](#know-how-to-configure-and-use-the-cluster-dns.)
   * [Understand CNI](#understand-cni)

* [Chapter 5: Scheduling (5%)](#chapter-5-scheduling-5)
   * [Kubernetes Scheduler](#kubernetes-scheduler) 
   * [Multiple Schedulers](#multiple-schedulers) 
   * [Resource Limits and Labels](#resource-limitsand-labels) 
   * [DaemonSets](#daemonsets) 
   * [Scheduler Events](#scheduler-events) 
   * [Use label selectors to schedule Pods.](#use-label-selectors-to-schedule-pods) 
   * [Understand the role of DaemonSets.](#understand-the-role-of-daemonSets.) 
   * [Understand how resource limits can affect Pod scheduling.](#understand-how-resource-limits-can-affect-pod-scheduling) 
   * [Understand how to run multiple schedulers and how to configure Pods to use them.](#understand-how-to-run-multiple-schedulers-and-how-to-configure-pods-to-use-them) 
   * [Manually schedule a pod without a scheduler.](#manually-schedule-a-pod-without-a-scheduler) 
   * [Display scheduler events.](#display-scheduler-events) 
   * [Know how to configure the Kubernetes scheduler.](#know-how-to-configure-the-kubernetes-scheduler.) 
   
* [Chapter 6: Application Lifecycle (8%)](#chapter-6-application-lifecycle-8)
   * [Deploying an Applicaiton](#deploying-an-application)
   * [Highly Available Apps](#highly-available-apps)
   * [Self-Healing Apps](#self-healing-apps)
   * [Understand Deployments and how to per form rolling updates and rollbacks.](#understand-deployments-and-how-to-per-form-rolling-updates-and-rollbacks)
   * [Know various ways to configure applications.](#know-various-ways-to-configure-applications)
   * [Know how to scale applications](#know-how-to-scale-applications)
   * [Understand the primitives necessary to create a self-healing application.](#understand-the-primitives-necessary-to-create-a-self-healing-application.)

* [Chapter 7: Storage (7%)](#chapter-7-storage-7)
   * [Persistent Volume](#persistent-volume)
   * [Volume Access Modes](#volume-access-modes)
   * [Persistent Volume Claims](#persistent-volume-claims)
   * [Storage Objects](#storage-objects)
   * [Application with Storage](#application-with-storage)
   * [Understand persistent volumes and know how to create them](#understand-persistent-volumes-and-know-how-to-create-them)
   * [Understand access modes for volumes](#understand-access-modes-for-volumes)
   * [Understand persistent volume claims primitive.](#understand-persistent-volume-claims-primitive.)
   * [Understand Kubernetes storage objects](#understand-kubernetes-storage-objects)
   * [Know how to configure applications with persistent storage](#know-how-to-configure-applications-with-persistent-storage)

* [Chapter 8: Security (12%)](#chapter-8-security-12)
   * [Security Primitives](#security-primitives)
   * [Authenticate and Authorize](#authenticate-and-authorize)
   * [Network Policies](#network-policies)
   * [TLS Certificate](#tls-certificate)
   * [Secure Images](#secure-images)
   * [Security Contexts](#security-contexts)
   * [Key Value Stores](#key-value-stores)
   * [Know how to configure authentication and authorization](#know-how-to-configure-authentication-and-authorization)
   * [Understand Kubernetes security primitives](#understand-kubernetes-security-primitives)
   * [Know to configure network policies](#know-to-configure-network-policies)
   * [Create and manage TLS certificates for cluster components](#create-and-manage-tls-certificates-for-cluster-components)
   * [Work with images securely](#work-with-images-securely)
   * [Define security contexts](#define-security-contexts)
   * [Secure persistent key value store](#secure-persistent-key-value-store)
   
* [Chapter 9: Log and Monitor (5%)](#chapter-9-log-and-monitor-5)
   * [Monitor Cluster](#monitor-cluster)
   * [Monitor Application](#monitor-application)
   * [Cluster Logs](#cluster-logs)
   * [Applicaiton Logs](#application-logs)
   * [Understand how to monitor all cluster components.](#understand-how-to-monitor-all-cluster-components.)
   * [Understand how to monitor applications](#understand-how-to-monitor-applications)
   * [Manage cluster component logs](#manage-cluster-component-logs)
   * [Manage application logs](#manage-application-logs)
   
* [Chapter 10: Troubleshooting (10%)](#chapter-10-troubleshooting-10)
   * [Application Failure](#application-failure)
   * [Control Place Failure](#control-place-failure)
   * [Worker Node Failure](#worker-node-failure)
   * [Network Failure](#network-failure)
   * [Troubleshoot application failure.](#troubleshoot0applicationffailure.)
   * [Troubleshoot control plane failure.](#troubleshoot-control-plane-failure.)
   * [Troubleshoot worker node failure.](#troubleshoot-worker-node-failure.)
   



## Document History

```
Document History:
2020-05-01	V1 Mehedi Hasan  "Certified Kubernetes Administrator (CKA) Curriculum"
```

* ## Chapter 1: Core Concepts (19%) 
   * ### Cluster Architecture
   
   * ### API Primitives
    > Kubernetes API to read and write Kubernetes resource objects via a Kubernetes API endpoint.
   
    **Resources Categories** 
    There are 5 basic types of resources provided by kubernetes API 
    1. **Workloads** are objects you use to manage and run your containers on the cluster.
   
    2. **Discovery & LB** resources are objects you use to "stitch" your workloads together into an externally accessible, load-balanced Service.
   
    3. **Config & Storage** resources are objects you use to inject initialization data into your applications, and to persist data that is external to your container.
   
    4. **Cluster** resources objects define how the cluster itself is configured; these are typically used only by cluster operators.
   
    5. **Metadata** resources are objects you use to configure the behavior of other resources within the cluster, such as HorizontalPodAutoscaler for scaling workloads.
    
    **Resources Objects** 
      Resource objects typically have 3 components:
   
    1. **Resource ObjectMeta**: This is metadata about the resource, such as its name, type, api version, annotations, and labels. This contains fields that maybe updated both by the end user and the system (e.g. annotations).
    2. **ResourceSpec**: This is defined by the user and describes the desired state of system. Fill this in when creating or updating an object.
    3. **ResourceStatus**: This is filled in by the server and reports the current state of the system. In most cases, users don't need to change this.
   
    **Resources Operations**  
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
    
    **Additional Operations**  
    Resources may define additional operations specific to that resource type.  
    
     **Rollback**: Rollback a PodTemplate to a previous version. Only available for some resource types.  
     **Read / Write Scale**: Read or Update the number of replicas for the given resource. Only available for some resource types.  
     **Read / Write Status**: Read or Update the Status for a resource object. The Status can only changed through these update operations.              
    
    **Reference and Further Study**
    * https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/
    * https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.16/#container-v1-core
                                               
    
   
   * ### Services and Network
    > Understand Services and other network primitives
   
* ## Chapter 2: Install, Config and Validate (12%)
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

* ## Chapter 3: Cluster (11%)
   * ### Upgrading the cluster
   * ### OS Upgrades
   * ### Restoring a Cluster
   * ### Understand Kubernetes cluster upgrade process.
   * ### Facilitate operating system upgrades.
   * ### Implement backup and restore methodologies

* ## Chapter 4: Networking (11%)
   * ### Pod and Node Networking
   * ### Container Network Interface
   * ### Service Networking
   * ### Ingress and Load Balancers
   * ### Cluster DNS
   * ### Understand the networking configuration on the cluster nodes.
   * ### Understand Pod networking concepts.
   * ### Understand service networking.
   * ### Deploy and configure network load balancer.
   * ### Know how to use Ingress rules.
   * ### Know how to configure and use the cluster DNS.
   * ### Understand CNI.

* ## Chapter 5: Scheduling (5%)
   * ### Kubernetes Scheduler
   * ### Multiple Schedulers
   * ### Resource Limits and Labels
   * ### DaemonSets
   * ### Scheduler Events
   * ### Use label selectors to schedule Pods
   * ### Understand the role of DaemonSets
   * ### Understand how resource limits can affect Pod scheduling
   * ### Understand how to run multiple schedulers and how to configure Pods to use them
   * ### Manually schedule a pod without a scheduler
   * ### Display scheduler events
   * ### Know how to configure the Kubernetes scheduler

* ## Chapter 6: Application Lifecycle (8%)
   * ### Deploying an Applicaiton
   * ### Highly Available Apps
   * ### Self-Healing Apps
   * ### Understand Deployments and how to per form rolling updates and rollbacks.
   * ### Know various ways to configure applications.
   * ### Know how to scale applications
   * ### Understand the primitives necessary to create a self-healing application.

* ## Chapter 7: Storage (7%)
   * ### Persistent Volume
   * ### Volume Access Modes
   * ### Persistent Volume Claims
   * ### Storage Objects
   * ### Application with Storage
   * ### Understand persistent volumes and know how to create them.
   * ### Understand access modes for volumes.
   * ### Understand persistent volume claims primitive.
   * ### Understand Kubernetes storage objects.
   * ### Know how to configure applications with persistent storage.

* ## Chapter 8: Security (12%)
   * ### Security Primitives
   * ### Authenticate and Authorize
   * ### Network Policies
   * ### TLS Certificate
   * ### Secure Images
   * ### Security Contexts
   * ### Key Value Stores
   * ### Know how to configure authentication and authorization
   * ### Understand Kubernetes security primitives.
   * ### Know to configure network policies.
   * ### Create and manage TLS certificates for cluster components.
   * ### Work with images securely
   * ### Define security contexts.
   * ### Secure persistent key value store.

* ## Chapter 9: Log and Monitor (5%)
   * ### Monitor Cluster
   * ### Monitor Application
   * ### Cluster Logs
   * ### Application Logs
   * ### Understand how to monitor all cluster components.
   * ### Understand how to monitor applications.
   * ### Manage cluster component logs
   * ### Manage application logs.

* ## Chapter 10: Troubleshooting (10%)
   * ### Application Failure
   * ### Control Place Failure
   * ### Worker Node Failure
   * ### Network Failure
   * ### Troubleshoot application failure.
   * ### Troubleshoot control plane failure
   * ### Troubleshoot worker node failure




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





## Upgrade Cluster:



#### Upgrade control plane

```bash
# replace x in 1.18.x-00 with the latest patch version
apt-mark unhold kubeadm && \
apt-get update && apt-get install -y kubeadm=1.18.x-00 && \
apt-mark hold kubeadm

# since apt-get version 1.1 you can also use the following method
apt-get update && \
apt-get install -y --allow-change-held-packages kubeadm=1.18.x-00


kubectl drain <cp-node-name> --ignore-daemonsets
sudo kubeadm upgrade plan
kubeadm upgrade apply v1.18.0
```



##### Upgrade master node

```bash
kubectl drain kube-master --ignore-daemonsets

kubeadm upgrade plan v1.7.0
kubeadm upgrade apply v1.7.0

upgrade kubelet
apt-get install kubelet=1.17.0-00

kubectl get node

--hold automatic update
apt-mark hold kubeadm
apt-mark hold kubelet

kubectl uncordon kube-master
```





##### Upgrade worker node

```bash
kubectl drain node1
kubectl drain kube-node1 --ignore-daemonsets

--upgrade kubeadm 
kubeadm upgrade node

apt-get install kubelet=1.17.0-00

apt-mark hold kubeadm
apt-mark hold kubelet

kubectl uncordon kube-node1
```





## Backup and Restore



```bash
kubectl -n kube-system describe po etcd-kube-master
```



###### Backup api service config

```bash

kubectl get all --all-namespaces -o yaml
kubectl get all -A -o yaml
kubectl get all -o yaml

```



#### ETCD Backup and Restore



###### Backup

```bash
export ETCDCTL_API=3
etcdctl version
etcdctl snapshot save -h

--etcd restore

```



###### Restore

```bash
etcdctl snapshot restore -h
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

