1. Create a pod named “web” using image nginx:1.11.9-alpine, on ports 80 and 443
# pass
```
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: web
  name: web
spec:
  containers:
  - image: nginx:1.11.9-alpine
    name: web
    resources: {}
    ports:
    - containerPort: 80
    - containerPort: 443
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```
2. Create a service to expose that pod, named as “webservice”
# pass
```


```
3. Copy the dns records for the service in file /opt/<yournamespace>/web.dnsrecord
# Fail


4. Create a deployment with “redis” image on port 6379 and expose a service.
# Pass
```
$ k create deploy redis --image=redis  --dry-run -o yaml > 4_redis_deploy.yaml
$ k expose deploy redis --name=redis-service --port=6379 --target-port=6379 --protocol=TCP --type=ClusterIP --dry-run -o yaml
```

5. Increase the number of replicas to 3
# Pass
```$ k scale deploy redis --replicas=3```

6. Perform a rolling update to version 4.0.11-alpine.
# Pass
```$ kubectl set image deploy redis redis=redis:4.0.11-alpine --record=True```

7. Copy pod spec to file /opt/yournamespace/podversion.
# Pass

8. Undo the image update to redis.. and confirm pod spec image matches
# Pass
``` k rollout undo deploy redis```

9. Create a multi container pod, with redis, memcached, nginx and mysql,
assign resource memory limit as 250M for each container.
# pass
10. List all the pods in your namespace sorted by name.
# Pass
```
$ kg pod --sort-by='.metadata.name'
$ kg pod --sort-by'.status.containerStatuses[0].restartCount'
```
11. Mount a temporary volume within a busybox pod named “shell”
at directory “/export/volume” copy the pod spec into /opt/yourname/shellvolume
# Pass

12. To the earlier pod “shell” attach liveliness probe to check the file
/export/volume/app.log being available.
# Fail

13. Setup init container into shell pod that got created just now, to
create a file /export/volume/app.log empty file before the busybox container
is run.
# Fail

14. Create a secret “<yourname>-secret” with user=<yourname>, secret=”SOMESECRET”
edit the “shell” pod to have the above secret imported as a volume
at /opt/mysecretvolume, and MYSECRET environment defined to map to
key secret in “<yourname>-secret”
# 

15. Create a persistent Volume named “<yourname>”
specification that defines a volume for 10Gi mapping to hostpath /opt/<yourname>


16. Take the etcd database snapshot saved into file /opt/<yourname>/etcdsnapshot
the certificates and keys are available in /opt/certs directory.


17. Get the dns records for the service and pods for the deployment “redis”
copied to file /opt/<yourname>/dnsrecord.redis


18. List all the pods that are serviced by the service “webservice”and copy the output in /opt/<yourname>/webservice.targets



############################################
Practice Example Question Dump -2:
— create a namespace <name>0830 and perform the following tasks.
— for each task create a spec file and save it in the homedirectory/namespace
as spec.p<num>
— — — — —
1. Create a pod redis version 5.0-rc4-alpine named “mycache”
2. Upgrade the pod to use 5.0-rc-alpine and save the pod spec as p2
along with the command used.
3. Create a config map from file /var/lib/kubelet/config.yaml
and create a nginx pod that sees the configmap as a volume in the same path within the container,
assign port 80 and expose it as a service “webservice” as well. The pod should be named “web”
4. Create a busybox container that sleeps 60000, named “mybox”.
5. Attach liveness probe to the container and restart if environment USER is null or undefined.
Report pod status after attaching liveness probe.
6. Pass ENV variables “USER” and “SECRET”
from a secret “boxsecret” defined already that has these initialized as “bob”/”somesupersecret”
7. Attach resource requests and limits for cpu and memory at 10m/10m and 100m/1000M
for “mybox” pod above.
8. Create a pv named “yourname-volume” that maps to hostpath “/opt/volume/yourname/” as 100G capacity, and
policy reclaim.
9. Create a deployment “myvolume” for memcached that get a 1G volume mapped from
yourname-volume at /opt/myvolume
10. Scale the deployment to have 2 replicas.
11. Update myvolume deployment to have 1.5.10-alpine image on all replicas.
12. Setup a init container in myvolume deployment to init a file in the mapped volume
/opt/myvolume/config.yaml before the real memcached kick starts.
13. Monitor pod lifecycle and log messages when pod/container starts/stops.
14. Create a multi-container pod with nginx, memcached, redis all sharing the
volume mount at /opt/myvolume with a 1G claim from your earlier pv created.
15. List all objects in your namespace that has label “ques=p5”
Find all pods that are serviced by your webservice.
############################################
Additional Practice Example Question Dump -3:
Create a node that has a SSD and label it as such.
Create a pod that is only scheduled on SSD nodes.
Create 2 pod definitions: the second pod should be scheduled to run anywhere the first pod is running — 2nd pod runs alongside the first pod.
Create a deployment running nginx version 1.12.2 that will run in 2 pods

a. Scale this to 4 pods.
b. Scale it back to 2 pods.
c. Upgrade this to 1.13.8
d. Check the status of the upgrade
e. How do you do this in a way that you can see history of what happened?
f. Undo the upgrade
Create a service that uses a scratch disk.
a. Change the service to mount a disk from the host.
b. Change the service to mount a persistent volume.
Create a pod that has a liveness check
Create a service that manually requires endpoint creation — and create that too
Create a daemon set
a. Change the update strategy to do a rolling update but delaying 30 seconds between pod updates
Create a static pod
Create a busybox container without a manifest. Then edit the manifest.
Create a pod that uses secrets
a. Pull secrets from environment variables
b. Pull secrets from a volume
c. Dump the secrets out via kubectl to show it worked
Create a job that runs every 3 minutes and prints out the current time.
Create a job that runs 20 times, 5 containers at a time, and prints “Hello parallel world”
Create a service that uses an external load balancer and points to a 3 pod cluster running nginx.
Create a horizontal autoscaling group that starts with 2 pods and scales when CPU usage is over 50%.
Create a custom resource definition
a. Display it in the API with curl
Create a networking policy such that only pods with the label access=granted can talk to it.
a. Create an nginx pod and attach this policy to it.
b. Create a busybox pod and attempt to talk to nginx — should be blocked
c. Attach the label to busybox and try again — should be allowed
Create a service that references an externalname.
a. Test that this works from another pod
Create a pod that runs all processes as user 1000.
Create a namespace
a. Run a pod in the new namespace
b. Put memory limits on the namespace
c. Limit pods to 2 persistent volumes in this namespace
Write an ingress rule that redirects calls to /foo to one service and to /bar to another
Write a service that exposes nginx on a nodeport
a. Change it to use a cluster port
b. Scale the service
c. Change it to use an external IP
d. Change it to use a load balancer
Deploy nginx with 3 replicas and then expose a port
a. Use port forwarding to talk to a specific port
Make an API call using CURL and proper certs
Upgrade a cluster with kubeadm
Get logs for a pod
Deploy a pod with the wrong image name (like — image=nginy) and find the error message.
Get logs for kubectl
Get logs for the scheduler
Restart kubelet
Convert a CRT to a PEM
a. Convert it back
Backup an etcd cluster
List the members of an etcd cluster
Find the health of etcd