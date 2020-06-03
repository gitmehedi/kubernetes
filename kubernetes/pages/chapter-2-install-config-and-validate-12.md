Table of Contents
==================

# Chapter 2: Install, Config and Validate (12%)
   * [Binaries/Provision/Types](#binariesprovisiontypes)
   * [Installing Master and Nodes](#installing-master-and-nodes)
   * [Highly Available Cluster](#highly-available-cluster)
   * [Secure Cluster](#secure-cluster)
   * [End-to-End Tests](#end-to-end-tests)
   
   
## Install, Config and Validate
   ### Binaries/Provision/Types
   
   #### Command References
   ```bash
   -- view addresses of master and services
   $ kubectl cluster-info
   -- show kubeconfig settings
   $ kubectl config view
   -- show all nodes details
   $ kubectl describe nodes
   -- show all pod details
   $ kubectl describe pods
   -- show all services
   $ kubectl get services --all-namespaces
   -- show all resources
   $ kubectl api-resources -o wide
   ```  

   #### References and Further Study
   * https://kubernetes.io/docs/home/

   ### Installing Master and Nodes
   Kubernetes cluster can install in two ways
   * Kubernetes Hard Way
   * Kubeadm Way

   #### References and Further Study
   * https://github.com/mmumshad/kubernetes-the-hard-way
   * https://github.com/gitmehedi/cloudtuts/blob/develop/kubernetes/kubernetes_installation.md

   ### Highly Available Cluster
   #### References and Further Study
   * https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/

   ### Secure Cluster
   #### Command References
   ```bash
   -- view the kubeconfig
   $ cat .kube/config | more
   -- view service account token
   $ kubectl get secrets
   ```  

   #### References and Further Study
   * https://kubernetes.io/docs/reference/access-authn-authz/controlling-access/

   ### End-to-End Tests
   For end-to-end test verify those checklist
   * Deployments can run
   * Pods can run
   * Pod can directly access
   * Logs can be collected
   * Command run from Pod
   * Services can provide access
   * Nodes are healthy
   * Pods are healthy

   #### Command References
   ```
   -- run a simple nginx deployements
   $ kubectl run nginx --image=nginx
   -- view current deployements
   $ kubectl get deploy
   -- lists the pods in the cluster
   $ kubectl get pods
   -- forward port 80 to 8081 on pod
   $ kubectl port-forward nginx 8081:80
   -- get a response from nginx pod
   $ curl --head http://127.0.0.1:8081
   -- get pods logs
   $ kubectl logs nginx
   -- run a command on the pod nginx
   $ kubectl exec -t nginx -- nginx -v 
   -- create a service using our deployment
   $ kubectl expose deploy nginx --port 80 --type NodePort
   -- list the services in the cluster
   $ kubectl get services
   -- get a response from a service
   $ curl -I localhost:<node_port>
   -- list node status
   $ kubectl get nodes
   -- get details info about node
   $ kubectl describe nodes
   -- get details info about pods
   $ kubectl describe pods
   ```
   #### References and Further Study
   * https://github.com/gitmehedi/cloudtuts/blob/develop/kubernetes/kubernetes_installation.md

TOC: [ToC](https://github.com/gitmehedi/cloudtuts/tree/develop/kubernetes)
Prev Chapter: [Chapter 1: Core Concepts (19%)](chapter-1-core-concepts-19.md)
Next Chapter: [Chapter 3: Cluster (11%)](chapter-3-cluster-11.md)