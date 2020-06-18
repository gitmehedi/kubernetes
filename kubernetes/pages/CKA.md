# CKA Questions


1. Create a initContainer with image busybox which will run fix time before nginx pod ready.
2. List all pod which using the service nginx-service.
```
$ for i in $(kg svc --no-headers | awk '{print $7}'); do kg po -l $i; done
$ kg po --show-labels | grep -F -f <(kg svc --no-headers | awk '{print $7}')
```
3.  Add security context' capabilites on a container which will set date on pod.
4. Create a daemon service name nginx with proper tolleration.
5. Create a new deployment named 'red' with the NGINX image and 3 replicas, and ensure it gets placed on the master node only. Use the right operator