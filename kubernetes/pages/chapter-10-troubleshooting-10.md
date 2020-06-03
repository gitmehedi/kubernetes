Table of Contents
==================

# Chapter 10: Troubleshooting (10%)
   * [Application Failure](#application-failure)
   * [Control Plane Failure](#control-place-failure)
   * [Worker Node Failure](#worker-node-failure)
   * [Network Failure](#network-failure)


## Troubleshooting
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
   
   <p align="center"><img src="./image/application_failure.png" width="600" height="400"/></p>
   
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

[Table of Contents](https://github.com/gitmehedi/cloudtuts/tree/develop/kubernetes)  
**Prev Chapter:** [Chapter 9: Log and Monitor (5%)](chapter-9-log-and-monitor-5.md)