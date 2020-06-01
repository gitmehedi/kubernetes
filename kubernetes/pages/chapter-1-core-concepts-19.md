Table of Contents
==================

# Chapter 1: Core Concepts  (19%)
   * [Cluster Architecture](#cluster-architecture)
   * [API Primitives](#api-primitives)
   * [Services and Network](#services-and-network)     
   
   
## Core Concepts

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
  
[<- Back to Table of Contents](../README.md)