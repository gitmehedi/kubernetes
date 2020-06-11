# JSONPATH
```
$ kubectl get po -o=jsonpath='{.items[*].metadata.labels.version}
$ kubectl get po -o=custom-columns='Name:metadata.name,Image:spec.containers[*].name,Volume:spec.volumes[*].name'
$ kubectl get po --sort-by='.status.containerStatuses[0].restartCount'
$ kubectl get no --selector='!node-role.kubernetes.io/master'
$ kubectl get po --field-selector=status.phase=Running
```

# List pods Sorted by Restart Count
```
$ kubectl get pods --sort-by='.status.containerStatuses[0].restartCount'
```

# Get the version label of all pods with label app=cassandra
```
$ kubectl get pods --selector=app=cassandra -o jsonpath='{.items[*].metadata.labels.version}'
```

# Get all running pods in the namespace
```
$ kubectl get pods --field-selector=status.phase=Running
```

# Show labels for all pods (or any other Kubernetes object that supports labelling)
```
$ kubectl get pods --show-labels
```

# Check which nodes are ready
```
JSONPATH='{range .items[*]}{@.metadata.name}:{range @.status.conditions[*]}{@.type}={@.status};{end}{end}' \
 && kubectl get nodes -o jsonpath="$JSONPATH" | grep "Ready=True"
```