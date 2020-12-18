Table of Contents
==================

# Chapter 7: Storage (7%)
   * [Manage Persistent Volume](#manage-persistent-volume)
   * [Volume Access Modes](#volume-access-modes)
   * [Manage Persistent Volume Claims](#manage-persistent-volume-claims)
   * [Manage Storage Objects](#manage-storage-objects)
   * [Configure Application with Storage](#configure-application-with-storage)


## Storage
   ### Manage Persistent Volume
   #### Command References
   ```bash
    apiVersion: v1
    kind: PersistentVolume
    metadata:
      name: pv0003
    spec:
      capacity:
        storage: 5Gi
      volumeMode: Filesystem
      accessModes:
        - ReadWriteOnce
      persistentVolumeReclaimPolicy: Recycle
      storageClassName: slow
      mountOptions:
        - hard
        - nfsvers=4.1
      nfs:
        path: /tmp
        server: 172.17.0.2
   ``` 

   #### References and Further Study
   * https://kubernetes.io/docs/concepts/storage/volumes/

   ### Volume Access Modes
   A PersistentVolume can be mounted on a host in any way supported by the resource provider. As shown in the table below, providers will have different capabilities and each PV’s access modes are set to the specific modes supported by that particular volume. For example, NFS can support multiple read/write clients, but a specific NFS PV might be exported on the server as read-only. Each PV gets its own set of access modes describing that specific PV’s capabilities.
   The access modes are:  

   * ReadWriteOnce – the volume can be mounted as read-write by a single node
   * ReadOnlyMany – the volume can be mounted read-only by many nodes
   * ReadWriteMany – the volume can be mounted as read-write by many nodes  
   
   In the CLI, the access modes are abbreviated to:  
   * RWO - ReadWriteOnce
   * ROX - ReadOnlyMany
   * RWX - ReadWriteMany

   #### References and Further Study
   * https://kubernetes.io/docs/concepts/storage/persistent-volumes/
   
   ### Manage Persistent Volume Claims
   #### Command References
   ```bash
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: myclaim
    spec:
      accessModes:
        - ReadWriteOnce
      volumeMode: Filesystem
      resources:
        requests:
          storage: 8Gi
      storageClassName: slow
      selector:
        matchLabels:
          release: "stable"
        matchExpressions:
          - {key: environment, operator: In, values: [dev]}
   ``` 

   #### References and Further Study
   * https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims
   
   ### Manage Storage Objects
   Volumes are already use by a pod are protected against dataloss. This means that even if you delete a  PVC, you can access the volume from POD.  
   
   #### Command References
   ```bash
    $ kubectl get pv
    $ kubectl get pvc
   ``` 

   #### References and Further Study
   * https://kubernetes.io/docs/concepts/storage/storage-classes/
   
   ### Configure Application with Storage
   #### Command References
   ```bash
    apiVersion: v1
    kind: Pod
    metadata:
      name: mypod
    spec:
      containers:
        - name: myfrontend
          image: nginx
          volumeMounts:
          - mountPath: "/var/www/html"
            name: mypd
      volumes:
        - name: mypd
          persistentVolumeClaim:
            claimName: myclaim
   ``` 

   #### References and Further Study
   * 
  

[Table of Contents](https://github.com/gitmehedi/cloudtuts/tree/develop/kubernetes)  
**Prev Chapter:** [Chapter 6: Application Lifecycle (8%)](chapter-6-application-lifecycle-8.md)  
**Next Chapter:** [Chapter 8: Security (12%)](chapter-8-security-12.md)  