# CKA Questions


1. Create a initContainer with image busybox which will run fix time before nginx pod ready.
2. List all pod which using the service nginx-service.
```
$ for i in $(kg svc --no-headers | awk '{print $7}'); do kg po -l $i; done
$ kg po --show-labels | grep -F -f <(kg svc --no-headers | awk '{print $7}')
```
3. Add security context' capabilites on a container which will set date on pod.
4. Create a daemon service name nginx with proper tolleration.
5. Create a new deployment named 'red' with the NGINX image and 3 replicas, and ensure it gets placed on the master node only. Use the right operator.
6. Create a pod with selected any of the images. Image name redis,nginx
7. Create deployment with name deploy-nginx which accept traffic with service service-nginx.
8. get all the cluster users and write in a filename /var/answer/UJDHH.TXT
9. Create a secret with name env-secret with value password=user1 and use it in pod envFrom.
10. To update a cluster we need to take the node down. Down the K82 .
11. Take a ETCD cluster backup on location /tmp/cluster.bk. All the required values given.
12. A pod deployed cluster-pod in the system. Create a service cluster-service in which POD will be access.
13. Create a egress rule to a pod egree-pod where ip does not need to mention.
14. Write dns information to the file /var/answer/HDKDKD.txt from the pod log-pod.
15. Reshedule pod nginx-pod with image nginx in node k82 in namespace cluster-scheduler.
16. Set labels with proper information ???
17. Create a deployment with image nginx and name will be dep-nginx. Upgrade the image of the deployment nginx-12.04. After proper upgrade backto the previous version of the image nginx.
18. Add a ConfigMap password with configuring in volume. ConfigMap value is APP_COLOR=RED and volume name is color-volume.
19. Create a volume pv-log with empty with claim name pvc-log and mount in pod redis with image redis.
 