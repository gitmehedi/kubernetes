Table of Contents
==================

# Chapter 9: Log and Monitor (5%)
   * [Monitor All Cluster Component](#monitor-all-cluster-component)
   * [Monitor Applications](#monitor-applications)
   * [Cluster Component Logs](#cluster-component-logs)
   * [Manage Application Logs](#manage-application-logs)


## Log and Monitor
   ### Monitor All Cluster Component
   The Metrix server allows to collect CPU and memory data from the nodes and pods in the cluster. Install metrix server
   ```
   -- clone metrix server repository
   $ git clone -b release-0.3 --single-branch https://github.com/kubernetes-sigs/metrics-server.git
   
   -- install metrix server
   $ kubectl apply -f metrics-server/deploy/1.8+/
   
   -- get metrix server information
   $ kubectl get --raw /apis/metrics.k8s.io
   ```

   #### Command References
   ```bash
    -- view CPU and memory for the nodes
    $ kubectl top node 
    
    -- view CPU and memory for the pods
    $ kubectl top pods
    
    -- view CPU and memory for the pods in all namespaces and kube-system
    $ kubectl top pods --all-namespaces
    $ kubectl top pods -n kube-system
    
    -- view CPU and memory for the pods with selectors
    $ kubectl top pods -l run=pod-with-defaults 
    
    -- view CPU and memory for the pods with pod_name
    $ kubectl top pod pod-with-defaults 
    
    -- view CPU and memory for the pod's container
    $ kubectl top pods group-context --containers 
    
   ``` 

   #### References and Further Study
   * https://kubernetes.io/docs/concepts/cluster-administration/cluster-administration-overview/#securing-a-cluster
   
   ### Monitor Applications
   #### Liveness and Readiness Probes
   Liveness and readiness probes can be used to automatically restart containers if they are failing or automatically remove from a service point.
   
   #### Command References
   ```bash
    -- get service endpoint
    $ kubectl get ep
   ``` 

   #### References and Further Study
   
   ### Cluster Component Logs
   The log directory for containers is in ```/var/log/containers```, which can potentially can consume all nodes disk spaces. To manage this use sidecar technique with a logging agent.
   
   #### Command References
   ```bash
    -- view the different type of logs 
    $ kubectl exec counter  -- ls /var/log

    -- view logs of a container in a pod
    $ kubectl logs counter conunt-log-1
    $ kubectl logs counter conunt-log-2

   ``` 

   #### References and Further Study
   *
   
   ### Manage Application Logs
   
   #### Command References
   ```bash
    -- view the logs of nginx container
    $ kubectl logs nginx 

    -- view logs of a container in a pod
    $ kubectl logs counter -c conunt-log-1

    -- view logs of all contianers
    $ kubectl logs counter --all-containers=True

    -- view logs of a container in a pod labeled nginx
    $ kubectl logs -p -c nginx nginx

    -- view logs of previously terminated container on pod nginx
    $ kubectl logs counter conunt-log-1

    -- tails the log for a pod
    $ kubectl logs --tail=20 nginx

    -- view the last 1 hour logs
    $ kubectl logs --since=1h nginx

    -- view the contianers logs from a deployment 
    $ kubectl logs deployment/nginx -c nginx

    -- direct logs to a file
    $ kubectl logs counter -c count-log-1 > counter.log

   ``` 

   #### References and Further Study
   *
 
[Table of Contents](https://github.com/gitmehedi/cloudtuts/tree/develop/kubernetes)  
**Prev Chapter:** [Chapter 8: Security (12%)](chapter-8-security-12.md)
**Next Chapter:** [Chapter 10: Troubleshooting (10%)](chapter-10-troubleshooting-10.md)