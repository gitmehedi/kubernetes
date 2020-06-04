Table of Contents
==================

# Chapter 5: Scheduling (5%)
   * [Kubernetes Labels and Selectors to Schedule Pods](#kubernetes-labels-and-selectors-to-schedule-pods)
   * [Role of DaemonSets](#role-of-daemonsets)
   * [Resource Limits and Labels in Pods Scheduling](#resource-limits-and-labels-in-pods-scheduling)
   * [Multiple Schedulers to Run and Configure Pods](#multiple-schedulers-to-run-and-configure-pods)
   * [Manually Schedule a Pods](#manually-schedule-a-pods)
   * [Scheduler Events](#scheduler-events)
   * [Configure Kubernetes Scheduler](#configure-kubernetes-scheduler)

   
## Scheduling
   The default scheduler goes through a series of steps to determine the right node for the pod. 
   1. Is the node running out of resources?
   2. Does the pods request a specific node?
   3. Does the node have a matching label?
   4. If the pod request a port, is it available?
   5. If the pod request a volume, can it be mounted?
   6. Does the pod tolerate the taints of the node?
   7. Does the pod specify node or pod affinity?
   
   Schdueling automatically schedule pod on the right node if kube-scheduler run on the cluster. If a kube-scheduler is not available on the system or has some issue then set an property on pod manifest file called ```nodeName```, it will automatically runs pod in that node.
   
   Schedule pod on node ```node01```.
   ```
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
      nodeName: node01
   ``` 
   Assign an existing pod into another node using pod binding
   ```
    apiVersion: v1
    kind: Binding
    metadata:
      name: nginx
    target:
      apiVersion: v1
      kind: Node
      name: node02
   ``` 
   **Tips:** Pod binding always request using curl where pod binding definition file converted to json object.
   
   ### Kubernetes Labels and Selectors to Schedule Pods
   Kubernetes uses Labels and Selector internally to group object and connect objection together.
   
   #### Labels
   Lebels used in kubernetes to label an object under the metadata section
   
   ```
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

   #### Taints, Toleration, Node Selector and Node Affinity
   ##### Taints
   Taints are applied on a node to repel a set of pods. 
   Add a taints on a node using ```kubectl taint```
   ```
   -- add taints on a node
   $ kubectl taint nodes node01 key=value:NoSchedule
   ```
   This means that no pod will be able to schedule onto ```node01``` unless it has a matching toleration.
   
   ```
   -- remove taints from a node
   $ kubeclt taint nodes node01 key:NoSchedule-
   ```
   
   ##### Toleration
   Tolerations are applied to pods, and allow (but do not require) the pods to schedule onto nodes with matching taints.
   Taints and tolerations work together to ensure that pods are not scheduled onto inappropriate nodes. One or more taints are applied to a node; this marks that the node should not accept any pods that do not tolerate the taints.
   You specify a toleration for a pod in the PodSpec. Both of the following tolerations “match” the taint created by the kubectl taint line above, and thus a pod with either toleration would be able to schedule onto node1:
   
   ```
   tolerations:
   - key: "key"
     operator: "Equal"
     value: "value"
     effect: "NoSchedule"

   tolerations:
   - key: "key"
     operator: "Exists"
     effect: "NoSchedule"
   ```
   Tolerations uses in POD
   
   ```
   apiVersion: v1
   kind: Pod
   metadata:
      name: nginx
      labels:
        env: test
   spec:
      containers:
      - name: nginx
        image: nginx
        imagePullPolicy: IfNotPresent
      tolerations:
      - key: "example-key"
        operator: "Exists"
        effect: "NoSchedule"
   ```

   
   ##### Node Selector
   You can constrain a Pod to only be able to run on particular Node(s) , or to prefer to run on particular nodes.
   
   ```
   $ kubectl label nodes kubernetes-foo-node-1.c.a-robinson.internal disktype=ssd
   ```
   or 
   ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: nginx
      labels:
        env: test
    spec:
      containers:
      - name: nginx
        image: nginx
        imagePullPolicy: IfNotPresent
      nodeSelector:
        disktype: ssd
   ```

   ##### Node Affinity
   Node affinity, is a property of Pods that attracts them to a set of nodes (either as a preference or a hard requirement).
   
   
   
   #### Command References
   ```bash
    $ kubectl get pods -selector app=application
   ``` 

   #### References and Further Study
   * https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/
   * https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/
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
   Problem with scheduler events can be identified in the following ways
   1. At the POD level
   1. At the Event level
   1. At the Log level
   
   #### Command References
   ```
    -- get the scheduler pod name
    $ kubectl get pods -n kube-system

    -- get events for default namespaces
    $ kubectl get events

    -- get events for kube-system namespaces
    $ kubectl get events -n kube-system

    -- watch the events in real time
    $ kubectl get events -w

    -- delete all pods in default namespaces
    $ kubectl delete pod --all

    -- view the log output from scheduler pod
    $ kubectl log <scheduler_pod_name> -n kube-system

   ``` 

   #### References and Further Study
   * https://kubernetes.io/docs/tasks/debug-application-cluster/
   
   ### Configure Kubernetes Scheduler

   #### References and Further Study
   * https://kubernetes.io/docs/tasks/debug-application-cluster/
   
[Table of Contents](https://github.com/gitmehedi/cloudtuts/tree/develop/kubernetes)  
**Prev Chapter:** [Chapter 4: Networking (11%)](chapter-4-networking-11.md)  
**Next Chapter:** [Chapter 6: Application Lifecycle (8%)](chapter-6-application-lifecycle-8.md)  