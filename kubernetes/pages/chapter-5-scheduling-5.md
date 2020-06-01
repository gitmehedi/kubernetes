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
   
[<- Back to Table of Contents](../README.md)