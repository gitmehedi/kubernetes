Table of Contents
==================

# Chapter 6: Application Lifecycle (8%)
   * [Deploying an Application with Rolling Updates and Rollback](#deploying-an-application-with-rolling-updates-and-rollback)
   * [Configure Highly Available Application](#configure-highly-available-application)
   * [Scale Applications](#scale-applications)
   * [Manage Self-Healing Application](#manage-self-healing-application)
   

## Application Lifecycle
   ### Application with Rolling Updates and Rollback
   There are application upgrading strategies
   * **Rolling Update**: It's a default strategy. Create new pod with latest version one by one and down previous pod with last version one by one
   * **Recreate**: Create new pod with latest version once at a time and down all previous version pod once at a time.
   
   #### Important Tips:
   * Using the --revision flag:   
   You can check the status of each revision individually by using the --revision flag:
   ```
   master $ kubectl rollout history deployment nginx --revision=1
   deployment.extensions/nginx with revision #1
     
   Pod Template:
     Labels:    app=nginx    pod-template-hash=6454457cdb
     Containers:  nginx:  Image:   nginx:1.16
       Port:    <none>
       Host Port: <none>
       Environment:    <none>
       Mounts:   <none>
     Volumes:   <none>
   ```
   * Using the --record flag:  
   You would have noticed that the "change-cause" field is empty in the rollout history output. We can use the --record flag to save the command used to create/update a deployment against the revision number.
   ```
    master $ kubectl set image deployment nginx nginx=nginx:1.17 --record
    deployment.extensions/nginx image updated
    master $master $
     
    master $ kubectl rollout history deployment nginx
    deployment.extensions/nginx
     
    REVISION CHANGE-CAUSE
    1     <none>
    2     kubectl set image deployment nginx nginx=nginx:1.17 --record=true
   ```
   You can now see that the change-cause is recorded for the revision 2 of this deployment.

   Let's make some more changes. In the example below, we are editing the deployment and changing the image from nginx:1.17 to nginx:latest while making use of the --record flag.
   
   ```
    master $ kubectl edit deployments. nginx --record
    deployment.extensions/nginx edited
     
    master $ kubectl rollout history deployment nginx
    REVISION CHANGE-CAUSE
    1     <none>
    2     kubectl set image deployment nginx nginx=nginx:1.17 --record=true
    3     kubectl edit deployments. nginx --record=true
     
     
     
    master $ kubectl rollout history deployment nginx --revision=3
    deployment.extensions/nginx with revision #3
     
    Pod Template: Labels:    app=nginx
        pod-template-hash=df6487dc Annotations: kubernetes.io/change-cause: kubectl edit deployments. nginx --record=true
     
     Containers:
      nginx:
      Image:   nginx:latest
      Port:    <none>
      Host Port: <none>
      Environment:    <none>
      Mounts:   <none>
     Volumes:   <none>
   ```
   * Undo a change:
   Lets now rollback to the previous revision:
   ```
    master $ kubectl rollout undo deployment nginx
    deployment.extensions/nginx rolled back
     
    master $ kubectl rollout history deployment nginx
    deployment.extensions/nginxREVISION CHANGE-CAUSE
    1     <none>
    3     kubectl edit deployments. nginx --record=true
    4     kubectl set image deployment nginx nginx=nginx:1.17 --record=true
     
     
    master $ kubectl rollout history deployment nginx --revision=4
    deployment.extensions/nginx with revision #4Pod Template:
     Labels:    app=nginx    pod-template-hash=b99b98f9
     Annotations: kubernetes.io/change-cause: kubectl set image deployment nginx nginx=nginx:1.17 --record=true
     Containers:
      nginx:
      Image:   nginx:1.17
      Port:    <none>
      Host Port: <none>
      Environment:    <none>
      Mounts:   <none>
     Volumes:   <none>
     
     
    master $ kubectl describe deployments. nginx | grep -i image:
      Image:    nginx:1.17
   ```

   
   #### Command References
   ```bash
    -- create new deployemnt with record and file name app-deployment.yaml
    $ kubectl create -f app-deployment.yaml --record
    
    -- Get deployment status
    $ kubectl get deployments
    
    -- upgrade a vesion of software in deployments app-deployment.yaml
    $ kubectl apply -f app-deployment.yaml
    $ kubectl set image deploy myapp-deployment nginx=nginx:1.9.1

    -- get deployment status and history
    $ kubectl rollout status deploy myapp-deployment
    $ kubectl rollout history deploy myapp-deployment

    -- get deployment history with revision
    $ kubectl rollout history deploy myapp-deployment --revision=2
    
    -- rollback a deployment 
    $ kubectl rollout undo deploy myapp-deployment

    -- rollback to a certain revision 
    $ kubectl rollout undo deploy myapp-deployment --to-revision=2

    -- pause and resume a deployment 
    $ kubectl rollout pause deploy myapp-deployment 
    $ kubectl rollout resume deploy myapp-deployment 
   ``` 

   #### References and Further Study
   * https://kubernetes.io/docs/concepts/workloads/controllers/deployment/
   
   ### Configure Highly Available Application
   #### Command and Arguments 
   ##### Docker
   Containers is not like a virtual machine to host an operating system. Containers only operate a specific task or process.
   In container, who defines what command will run inside a container.  
   Two command where docker give us provision to put command and it's argument
   * ENTRYPOINT: ENTRYPOINT is used for command which will execute.
   * CMD: CMD is used for parametes for ENTRYPOINT command.
   
   Command Patter:
   CMD command params1       == CMD sleep 10
   CMD ["command","params"]  == CMD ["sleep","5"]
   
   ##### Kubernetes
   In kubernetes, command key overwrite the functionality of ENTRYPOINT and args key overwrites the functionality of CMD.
   
   #### Environment Variable
   Kubernetes can set environment variable in three ways
   * In POD
   ```
   env:
   - name: APP_COLOR
     value: pink 
   ```
   * In ConfigMap and using in POD
   ```
   env:
   - name: APP_COLOR
     valueFrom: 
        configMapKeyRef:
   ```
   * In Secret and using in POD
   ```
   env:
   - name: APP_COLOR
     valueFrom: 
        secretKeyRef:
   ```
   ##### ConfigMaps
   Two stages of ConfigMaps. 
   ```
   * Create ConfigMaps
   * Inject ConfigMaps into POD
   ```
   * Create ConfigMaps  
   ConfigMaps can be created using two ways  
   
   **Imperative Way**  
   ```
   -- kubectl create configmap <configmap_name> --from-literal=<key>=<value>
   $ kubectl create configmap app-config --from-literal=APP_COLOR=blue
   $ kubectl create configmap app-config --from-literal=APP_COLOR=blue --form-literal=APP_TYPE=prod
   $ kubectl create configmap game-config --from-file=configure-pod-container/configmap/
   $ kubectl create configmap game-config-env-file --from-env-file=configure-pod-container/configmap/game-env-file.properties

   ```
   **Declarative Way**  
   Create a configMap object from a file app-config.yaml
   ```
   apiVersion: v1
   kind: ConfigMap
   metadata:
      name: app-config
      namespace: default
   data:
     APP_COLOR: blue
     APP_TYPE: prod
   ```
   Inject ConfigMaps into POD  
   Inject ConfigMaps data into pod using following ways  
   a. ENV  
   ```
   envFrom:
     - configMapRef:
         name: app-config
   ```
   b. SINGLE VIEW  
   ```
   env:
     - name: APP_COLOR
       valueFrom: 
         configMapKeyRef:
            name: app-config
            key: APP_COLOR
   ```
   c. VOLUME    
   ```
   volumes:
     - name: app-config-volume
       configMap: 
         name: app-config
   ```
   
   ##### Secrets
   Two stages of Secrets. 
   ```
   * Create Secrets
   * Inject Secrets into POD
   ```
   * Create Secrets  
   Secrets can be created using two ways  
   
   **Imperative Way**  
   ```
   -- kubectl create secret generic <secret_name> --from-literal=<key>=<value>
   $ kubectl create secret generic app-secret --from-literal=APP_COLOR=blue
   $ kubectl create secret generic app-secret --from-literal=APP_COLOR=blue --form-literal=APP_TYPE=prod
   $ kubectl create secret generic game-secret --from-file=configure-pod-container/secret/
   $ kubectl create secret generic game-secret-env-file --from-env-file=configure-pod-container/secret/game-env-file.properties

   ```
   **Declarative Way**  
   Create a secret object from a file app-secret.yaml
   ```
   apiVersion: v1
   kind: Secret
   metadata:
     creationTimestamp: null
     name: db-secret
   data:
     DB_Host: c3FsMDE=
     DB_Password: cGFzc3dvcmQxMjM=
     DB_User: cm9vdA==
   ```
   Inject ConfigMaps into POD  
   Inject ConfigMaps data into pod using following ways  
   a. ENV  
   ```
   envFrom:
     - secretRef:
         name: app-secret
   ```
   b. SINGLE VIEW  
   ```
   env:
     - name: APP_COLOR
       valueFrom: 
         secretKeyRef:
            name: app-secret
            key: APP_COLOR
   ```
   c. VOLUME    
   when a secret mount in a volume it create a file for each secret value pair.
   ```
   volumes:
     - name: app-secret-volume
       secret: 
         secretName: app-secret
   ```

   #### Command References
   ```bash
    -- view configmaps
    $ kubectl get configmaps

    -- view details of a configmaps
    $ kubectl details configmaps app-config

    -- view secrets and view secrets with value
    $ kubectl get secrets
    $ kubectl get secrets -o yaml

    -- view details of a secrets
    $ kubectl details secrets app-secret

    -- encode a string in base64 in linux host
    $ echo -n "mysql" | base64  

    -- decode a base64 encoded string in linux host
    $ echo -n "bXlzcWw=" | base64 --decode
   
   ``` 

   #### References and Further Study
   * https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/
   
   ### Scale Applications
   
   #### Multi Containers
   There are 3 multi-container design pattern
   * SIDECAR
   * ADAPTER
   * AMBASSADOR
   
   #### InitContainers
In a multi-container pod, each container is expected to run a process that stays alive as long as the POD's lifecycle. For example in the multi-container pod that we talked about earlier that has a web application and logging agent, both the containers are expected to stay alive at all times. The process running in the log agent container is expected to stay alive as long as the web application is running. If any of them fails, the POD restarts.

But at times you may want to run a process that runs to completion in a container. For example a process that pulls a code or binary from a repository that will be used by the main web application. That is a task that will be run only  one time when the pod is first created. Or a process that waits  for an external service or database to be up before the actual application starts. That's where initContainers comes in.

An initContainer is configured in a pod like all other containers, except that it is specified inside a initContainers section,  like this:


    ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: myapp-pod
      labels:
        app: myapp
    spec:
      containers:
      - name: myapp-container
        image: busybox:1.28
        command: ['sh', '-c', 'echo The app is running! && sleep 3600']
      initContainers:
      - name: init-myservice
        image: busybox
        command: ['sh', '-c', 'git clone <some-repository-that-will-be-used-by-application> ; done;']
    ```

When a POD is first created the initContainer is run, and the process in the initContainer must run to a completion before the real container hosting the application starts. 

You can configure multiple such initContainers as well, like how we did for multi-pod containers. In that case each init container is run one at a time in sequential order.

If any of the initContainers fail to complete, Kubernetes restarts the Pod repeatedly until the Init Container succeeds.
    ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: myapp-pod
      labels:
        app: myapp
    spec:
      containers:
      - name: myapp-container
        image: busybox:1.28
        command: ['sh', '-c', 'echo The app is running! && sleep 3600']
      initContainers:
      - name: init-myservice
        image: busybox:1.28
        command: ['sh', '-c', 'until nslookup myservice; do echo waiting for myservice; sleep 2; done;']
      - name: init-mydb
        image: busybox:1.28
        command: ['sh', '-c', 'until nslookup mydb; do echo waiting for mydb; sleep 2; done;']
    ```
   #### Further Study    
   See the section [Application with Rolling Updates and Rollback](#application-with-rolling-updates-and-rollback)
   
   #### References and Further Study
   * https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
   
   ### Manage Self-Healing Application
   Kubernetes supports self-healing applications through ReplicaSets and Replication Controllers. The replication controller helps in ensuring that a POD is re-created automatically when the application within the POD crashes. It helps in ensuring enough replicas of the application are running at all times.

Kubernetes provides additional support to check the health of applications running within PODs and take necessary actions through Liveness and Readiness Probes. However these are not required for the CKA exam and as such they are not covered here. These are topics for the Certified Kubernetes Application Developers (CKAD) exam and are covered in the CKAD course.
   #### Command References
   ```bash
    -- pause and resume a deployment 
    $ kubectl rollout pause deploy myapp-deployment 
    $ kubectl rollout resume deploy myapp-deployment 
   ``` 

   #### References and Further Study
   * 
   
  
  
[<- Back to Table of Contents](../README.md)