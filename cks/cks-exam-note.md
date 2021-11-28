# 1. Exam Note: Certified K8s Security Specialist (CKS)



- [1. Exam Note: Certified K8s Security Specialist (CKS)](#1-exam-note-certified-k8s-security-specialist-cks)
  - [1.1. Document History](#11-document-history)
  - [1.2. Introduction](#12-introduction)
  - [1.3. Lab environment:](#13-lab-environment)
  - [1.4. Environtment variable to setup](#14-environtment-variable-to-setup)
  - [1.5. CKS Course Summary](#15-cks-course-summary)
- [2. Kubernetes Security Essentials (LFS260)](#2-kubernetes-security-essentials-lfs260)
  - [2.1. Chapter 1](#21-chapter-1)
  - [2.2. Chapter 2 Cloud Security Overview](#22-chapter-2-cloud-security-overview)
  - [2.3. Chapter 3 Preparing to Install](#23-chapter-3-preparing-to-install)
  - [2.4. Chapter 4 Installing the Cluster](#24-chapter-4-installing-the-cluster)
  - [2.5. Chapter 5 Securing Kube-Apiserver](#25-chapter-5-securing-kube-apiserver)
  - [2.6. Chapter 6 Networking](#26-chapter-6-networking)
  - [2.7. Chapter 7 Workload Considerations](#27-chapter-7-workload-considerations)
  - [2.8. Chapter 8 Issue Detection](#28-chapter-8-issue-detection)
- [3. CKS Udemy Course](#3-cks-udemy-course)
  - [3.1. Section 1: Introduction](#31-section-1-introduction)
  - [3.2. Section 2: Create your cluster](#32-section-2-create-your-cluster)
  - [3.3. Section 3: Foundations - Kubernetes Secure Architecture](#33-section-3-foundations---kubernetes-secure-architecture)
  - [3.4. Section 4: Foundation - Containers under the hood](#34-section-4-foundation---containers-under-the-hood)
  - [3.5. Section 5: Cluster Setup - Network Policies](#35-section-5-cluster-setup---network-policies)
  - [3.6. Section 6: Cluster Setup - GUI Elements](#36-section-6-cluster-setup---gui-elements)
  - [3.7. Section 7: Cluster Setup - Secure Ingress](#37-section-7-cluster-setup---secure-ingress)
  - [3.8. Section 8: Cluster Setup - Node Metadata Protection](#38-section-8-cluster-setup---node-metadata-protection)
  - [3.9. Section 9: Cluster Setup - CIS Benchmarks](#39-section-9-cluster-setup---cis-benchmarks)
  - [3.10. Section 10: Cluster Setup - Verify Platform Binaries](#310-section-10-cluster-setup---verify-platform-binaries)
  - [3.11. Section 11: Cluster Hardening RBAC](#311-section-11-cluster-hardening-rbac)
  - [3.12. Section 12: Cluster Hardening - Exercise caution in using ServiceAccounts](#312-section-12-cluster-hardening---exercise-caution-in-using-serviceaccounts)
  - [3.13. Section 13: Cluster Hardening - Restricted API Access](#313-section-13-cluster-hardening---restricted-api-access)
  - [3.14. Section 14: Cluster Hardening - Upgrade Kubernetes](#314-section-14-cluster-hardening---upgrade-kubernetes)
  - [3.15. Section 15: Microservice Vulnerabilites - Secrets](#315-section-15-microservice-vulnerabilites---secrets)
  - [3.16. Section 16: Microservice Vulnerabilites - Container runtime (Sandboxes)](#316-section-16-microservice-vulnerabilites---container-runtime-sandboxes)
  - [3.17. Section 17: Microservice Vulnerabilites - OS Security](#317-section-17-microservice-vulnerabilites---os-security)
  - [3.18. Section 18: Microservice Vulnerabilites - mTLS](#318-section-18-microservice-vulnerabilites---mtls)
  - [3.19. Section 19: Open Policy Agent (OPA)](#319-section-19-open-policy-agent-opa)
  - [3.20. Section 20: Supply Chain Security - Image Footprint](#320-section-20-supply-chain-security---image-footprint)
  - [3.21. Section 21: Supply Chain Security - Static Analysis](#321-section-21-supply-chain-security---static-analysis)
  - [3.22. Section 22: Supply Chain Security - Image Vulnerability Scanning](#322-section-22-supply-chain-security---image-vulnerability-scanning)
  - [3.23. Section 23: Supply Chain Security - Secure Supply Chain](#323-section-23-supply-chain-security---secure-supply-chain)
  - [3.24. Section 24: Runtime Security - Behavioral Analytics at host and container level](#324-section-24-runtime-security---behavioral-analytics-at-host-and-container-level)
  - [3.25. Section 25: Runtime Security - Immunity of containers at runtime](#325-section-25-runtime-security---immunity-of-containers-at-runtime)
  - [3.26. Section 26: Runtime Security - Auditing](#326-section-26-runtime-security---auditing)
  - [3.27. Section 27: System Hardening - Kernel Hardening tools - AppArmor and Seccomp](#327-section-27-system-hardening---kernel-hardening-tools---apparmor-and-seccomp)
  - [3.28. Section 28: System Hardening - Reduce Attack Surface](#328-section-28-system-hardening---reduce-attack-surface)
- [4. CKS: A-Cloud-Guru Course](#4-cks-a-cloud-guru-course)
  - [4.1. Chapter 1: CKS Introduction](#41-chapter-1-cks-introduction)
  - [4.2. Chapter 2: Kubernetes Cluster Setup](#42-chapter-2-kubernetes-cluster-setup)
    - [4.2.1. Restrict Default Access with NetworkPolicies](#421-restrict-default-access-with-networkpolicies)
    - [4.2.2. Allowing Limited Access with NetworkPolices](#422-allowing-limited-access-with-networkpolices)
    - [4.2.3. Hands-on Lab: Lock Down Inter-Pod Communication with NetworkPolicies](#423-hands-on-lab-lock-down-inter-pod-communication-with-networkpolicies)
    - [4.2.4. Running a CIS Benchmark with kube-bench](#424-running-a-cis-benchmark-with-kube-bench)
    - [4.2.5. Fixing Security Issues Detected by a CIS Benchmark](#425-fixing-security-issues-detected-by-a-cis-benchmark)
    - [4.2.6. Strengthen Cluster Security with a CIS Kubernetes Benchmark](#426-strengthen-cluster-security-with-a-cis-kubernetes-benchmark)
    - [4.2.7. Implementing TLS with Ingress](#427-implementing-tls-with-ingress)
    - [4.2.8. Hands-on Lab: Add TLS to a Kubernetes Service with Ingress](#428-hands-on-lab-add-tls-to-a-kubernetes-service-with-ingress)
    - [4.2.9. Securing Node Endpoints](#429-securing-node-endpoints)
    - [4.2.10. Securing GUI Elements (attack surface control)](#4210-securing-gui-elements-attack-surface-control)
    - [4.2.11. Verifying Kubernetes Platform Binaries](#4211-verifying-kubernetes-platform-binaries)
    - [4.2.12. Cluster Setup Review](#4212-cluster-setup-review)
  - [4.3. Chapter 3: Kubernetes Cluster Hardening](#43-chapter-3-kubernetes-cluster-hardening)
    - [4.3.1. Restricting Service Account Permissions](#431-restricting-service-account-permissions)
    - [4.3.2. Hands-on Lab: Limit Service Account Permissions in Kubernetes](#432-hands-on-lab-limit-service-account-permissions-in-kubernetes)
  - [4.4. Chapter 4: System Hardening](#44-chapter-4-system-hardening)
    - [4.4.1. Understanding Host OS Security Concerns](#441-understanding-host-os-security-concerns)
    - [4.4.2. Exploring AppArmor](#442-exploring-apparmor)
    - [4.4.3. Hands-on Lab: Protecting a Kubernetes Cluster with AppArmor](#443-hands-on-lab-protecting-a-kubernetes-cluster-with-apparmor)
  - [4.5. Chapter 5: Minimizing Microservice Vulnerabilities](#45-chapter-5-minimizing-microservice-vulnerabilities)
    - [4.5.1. Minimizing Microservice Vulnerabilities Intro](#451-minimizing-microservice-vulnerabilities-intro)
    - [4.5.2. Managing Container Access with Security Contexts](#452-managing-container-access-with-security-contexts)
    - [4.5.3. Using Pod Security Policies](#453-using-pod-security-policies)
    - [4.5.4. Hans-on LAB: PodSecurityPolicy](#454-hans-on-lab-podsecuritypolicy)
    - [4.5.5. Using OPA Gatekeeper](#455-using-opa-gatekeeper)
    - [4.5.6. Managing Kubernetes Secrets](#456-managing-kubernetes-secrets)
    - [4.5.7. Hand-on Lab Secret](#457-hand-on-lab-secret)
    - [4.5.8. Understanding Container Runtime Sandboxes](#458-understanding-container-runtime-sandboxes)
    - [4.5.9. Hands-on Lab: Moving Kubernetes Pods to a Secured Runtime Sandbox](#459-hands-on-lab-moving-kubernetes-pods-to-a-secured-runtime-sandbox)
    - [4.5.10. mTLS and Signing Certificates](#4510-mtls-and-signing-certificates)
    - [4.5.11. Minimizing Microservice Vulnerabilities Review](#4511-minimizing-microservice-vulnerabilities-review)
  - [4.6. Chapter 6: Supply Chain Security](#46-chapter-6-supply-chain-security)
    - [4.6.1. Supply Chain Security Intro](#461-supply-chain-security-intro)
    - [4.6.2. Whitelisting Allowed Image Registries](#462-whitelisting-allowed-image-registries)
    - [4.6.3. Validating Signed Images](#463-validating-signed-images)
    - [4.6.4. Analyzing a Dockerfile](#464-analyzing-a-dockerfile)
    - [4.6.5. Analyzing Resource YAML Files](#465-analyzing-resource-yaml-files)
    - [4.6.6. Scanning Images for Known Vulnerabilities](#466-scanning-images-for-known-vulnerabilities)
    - [4.6.7. Scanning Images with an Admission Controller](#467-scanning-images-with-an-admission-controller)
    - [4.6.8. Supply Chain Security Review](#468-supply-chain-security-review)
  - [4.7. Chapter 7: Monitoring, Logging and Runtime Security](#47-chapter-7-monitoring-logging-and-runtime-security)
    - [4.7.1. Monitoring, Logging, and Runtime Security Intro](#471-monitoring-logging-and-runtime-security-intro)
    - [4.7.2. Understanding Behavioral Analytics and Analyzing Container Behavior with Falco](#472-understanding-behavioral-analytics-and-analyzing-container-behavior-with-falco)
    - [4.7.3. Hands-on Lab: Threat Detection in Kubernetes with Falco](#473-hands-on-lab-threat-detection-in-kubernetes-with-falco)
    - [4.7.4. Ensuring Containers are Immutable](#474-ensuring-containers-are-immutable)
    - [4.7.5. Hands-on Lab: Check Kubernetes Pods for Container Immutability](#475-hands-on-lab-check-kubernetes-pods-for-container-immutability)
    - [4.7.6. Understanding Audit Logs](#476-understanding-audit-logs)
    - [4.7.7. Hans-on Lab: Configure Audit Logging in Kubernetes](#477-hans-on-lab-configure-audit-logging-in-kubernetes)
  - [4.8. Chapter 8: Practice Exam](#48-chapter-8-practice-exam)
    - [4.8.1. Certified Kubernetes Security Specialist (CKS) - Practice Exam Part 1](#481-certified-kubernetes-security-specialist-cks---practice-exam-part-1)
    - [4.8.2. Certified Kubernetes Security Specialist (CKS) - Practice Exam Part 2](#482-certified-kubernetes-security-specialist-cks---practice-exam-part-2)
    - [4.8.3. Certified Kubernetes Security Specialist (CKS) - Practice Exam Part 3](#483-certified-kubernetes-security-specialist-cks---practice-exam-part-3)
    - [4.8.4. Certified Kubernetes Security Specialist (CKS) - Practice Exam Part 4](#484-certified-kubernetes-security-specialist-cks---practice-exam-part-4)
    - [4.8.5. Certified Kubernetes Security Specialist (CKS) - Practice Exam Part 5](#485-certified-kubernetes-security-specialist-cks---practice-exam-part-5)
    - [4.8.6. Certified Kubernetes Security Specialist (CKS) - Practice Exam Part 6](#486-certified-kubernetes-security-specialist-cks---practice-exam-part-6)
    - [4.8.7. Certified Kubernetes Security Specialist (CKS) - Practice Exam Part 7](#487-certified-kubernetes-security-specialist-cks---practice-exam-part-7)
    - [4.8.8. Certified Kubernetes Security Specialist (CKS) - Practice Exam Part 8](#488-certified-kubernetes-security-specialist-cks---practice-exam-part-8)
    - [4.8.9. Certified Kubernetes Security Specialist (CKS) - Practice Exam Part 9](#489-certified-kubernetes-security-specialist-cks---practice-exam-part-9)
    - [4.8.10. Certified Kubernetes Security Specialist (CKS) - Practice Exam Part 10](#4810-certified-kubernetes-security-specialist-cks---practice-exam-part-10)
    - [4.8.11. Certified Kubernetes Security Specialist (CKS) - Practice Exam Part 11](#4811-certified-kubernetes-security-specialist-cks---practice-exam-part-11)
    - [4.8.12. Certified Kubernetes Security Specialist (CKS) - Practice Exam Part 12](#4812-certified-kubernetes-security-specialist-cks---practice-exam-part-12)
- [5. References](#5-references)
- [6. Appendix](#6-appendix)
  - [6.1. openssl](#61-openssl)
  - [6.2. CKS Exam simulator note killer.sh](#62-cks-exam-simulator-note-killersh)

## 1.1. Document History

```bash
Arif V1 2021-04-20 "Note from CKS udemy course"
Arif V1 2021-07-02 "Note from CKS A-Cloud-Guru course"
```



## 1.2. Introduction

Keeping note and sample command for the Certified Kubernetes Security Specialist (CKS) Exam. 





## 1.3. Lab environment:

```bash
-- need two node kubernetes cluster
-- create two node in linux academy play ground server

cks-master (3 unit resource, 4gb)
b8ec5a50d21c.mylabserver.com
b8ec5a50d21d.mylabserver.com
172.31.38.113

cks-worker (3 unit resource, 4gb)
c297f2ab681c.mylabserver.com
c297f2ab681d.mylabserver.com
172.31.33.97
```

[Install script for kubernetes master node - cks_install_master.sh](cks_install_master.sh)

[Install script for kubernetes worker node - cks_install_worker.sh](cks_install_worker.sh)



**Install kubernetes cluster** in local or any cloud provider virtual machine.  [`Vagrant config file`](vagrant-cks-lab/Vagrantfile) for creating two VM.

```bash
# create vagrant pc in local environment
cd /home/arif/gitRepos/professional-certifications/202103 CKS-Exam/vagrant-cks-lab
export VAGRANT_CWD=/home/arif/gitRepos/professional-certifications/202103\ CKS-Exam/vagrant-cks-lab/
vagrant status
vagrant up cks-master
vagrant up cks-worker

# install kubernetes software in cks-master node, upload cks_install_master.sh script
vagrant ssh cks-master
sudo ./cks_install_master.sh

# install kubernetes software in cks-worker node, upload cks_install_worker.sh script
vagrant ssh cks-master
sudo ./cks_install_worker.sh
```



## 1.4. Environtment variable to setup

VIM profile -

```bash
cat <<EOF>~/.vimrc
set ts=2 sw=2 sts=2 et ai number
syntax on
colorscheme ron
EOF

Or may be follow below procedure:
echo "set ts=2 sts=2 sw=2 et number" >> ~/.vimrc
source ~/.vimrc
```



Command alias -

```bash
cat <<EOF>kalias.sh
alias k="kubectl"
alias kgn="kubectl get node" 
alias aa='kubectl get all,sa,ep,sc,pv,pvc,cm,netpol'
alias kn='kubectl config set-context --current --namespace '
alias kcc='kubectl config get-contexts'

export do="--dry-run=client -o yaml" o="-o wide" y="-o yaml" l="--show-labels" r="--recursive"

source <(kubectl completion bash)
complete -F __start_kubectl k
EOF

source kalias.sh
```

## 1.5. CKS Course Summary

cks topics :
- Find Security risk
  - Docker config file check (root user, copy etc)
  - Pod specification file check (runasuser - 0, )
  - CIS benchmark (kube-bench)
- image checksum check using sha256 for pod image (image:v@sha256:hash)
- Network Policy :
- Ingress TLS (certificate, tls secret, ingress resource with TLS)
- manage TLS : CFSSL
- mTLS : side car proxy etc
- Api-Server
  - auditing
  - disable insecure gui port
  - admission-control= ImagePolicyWebhook, NodeRestriction, RBAC
- AppArmor : define profile, parse profile, annotation setup in pod definition file
- Seccomp : pod definition setup in spec file
- gVisior : runtime sc create, used runtime sc class in pop spec
- psp (pod security  policy): policy definition, sa, role, rolebinding, pod specification
- opa (open policy agent gatekeeper) : label based check (ConstraintTemplate, define label and mention label in pod annotation)
- trivy : image vulnerability check 
- falco : audting setting with api server, pod
- 


<br><br>

---
<br>


# 2. Kubernetes Security Essentials (LFS260)



## 2.1. Chapter 1

```bash
4 C in Cloud Native Security - Code, Container, Cluster and Cloud/Co-Lo/Corporate Datacenter



```



## 2.2. Chapter 2 Cloud Security Overview

```bash
four C’s of cloud security: code, container, cluster, cloud.
Special Interest Groups (SIGs)
Kubernetes Security Profiles Operator SIG
CNCF Special Interest Group for Security

What is security ?
Computer security is the protection of items of value, called assets, of a computer or computer system. There are many types of assets, involving hardware, software, data, process, staff, or a combination thereof.

Assets
Software development
Policies Defining Security
Roles and Responsibilities

Basic security principlas:
- Assessment
- Prevention
- Detection
- Reaction
Intrusion Detection and Prevention Systems (IDPS)

Current incident detection methods include signature-based, statistical anomaly-based, and stateful protocol analysis.
Stateful protocol analysis includes system monitoring.

Classes of Attackers:
- white hat / ethical hacker
- Black Hat
- Script Kiddie / skid or skiddie
- Hacktivist
- Nation State
- Organized Crime
- Bots

Attack Sources:
- An inside attack
- An outside attack

assets: A resource (both physical or logical)

Types of Attacks:
- Active Attacks
- Passive Attacks

Attack surface:
- etcd database
- API endpoint
- kubelet
- kube-proxy

Platform AbstRaction for SECurity (PARSEC) are trying to provide a common API to security services abstracted from the particular platform.

Federal Information Processing Standard (FIPS)
Cybersecurity Framework (CSF):
five different activities (Identify, Protect, Detect, Respond, and Recovery).
They further divide the activity into six categories:
- Asset Management
- Business Environment
- Governance
- Risk Assessment
- Risk Management Strategy
- Supply Chain Risk Management.

High Value Asset (HVA)

Cybersecurity and Infrastructure Security Agency (CISA)
National Vulnerability Database (NVD)
National Institute of Standards and Technology (NIST)
Computer Security Resource Center (CSRC)
Federal Information Processing Standards (FIPS) and (Special Publications (SP) 
Center for Internet Security, Inc. (CIS®)

kube-bench
non-container specific security tools (e.g., SELinux, Kerberos, SAML, etc.)


```

Note:

* https://csrc.nist.gov/publications/fips
* https://nvd.nist.gov/vuln/search
* https://www.cisecurity.org/cis-benchmarks/
* https://cisecurity.org/



## 2.3. Chapter 3 Preparing to Install

```bash

- Trow
- Prisma Cloud
- NeuVector: deep packet + container firewalls
- Clair
- Aqua: scanning and heuristic tool, Trivy
- Notary : TLS key verification
- Harbor: graduated project. secure registry

```



## 2.4. Chapter 4 Installing the Cluster

```bash

```





## 2.5. Chapter 5 Securing Kube-Apiserver

```bash
- Authentication
- Authorization
- Admission Control 

The localhost port provides a testing port with no TLS and exposes port 8080. API calls via this port bypass the authentication and authorization phases of the API server.

The secure port defaults to 6443 and will use the first non-localhost network interface.
--bind-address flag to set the interface
/etc/kubernetes/manifests/kube-apiserver.yaml

spec: 
  containers: 
  - command: 
    - kube-apiserver 
    - --advertise-address=10.128.15.193 
    - --allow-privileged=true 
    - --authorization-mode=Node,RBAC 
    - --client-ca-file=/etc/kubernetes/pki/ca.crt 
    - --enable-admission-plugins=NodeRestriction 
    - --enable-bootstrap-token-auth=true
    
#Enable Audit Log:
1 - --audit-policy-file=/etc/kubernetes/simple-policy.yaml 
2 - --audit-log-path=/var/log/audit.log 
3 - --audit-log-maxbackup=2 
4 - --audit-log-maxage=7 
5 - --audit-log-maxsize=200   

Every call is divided into three phases -
- RequestReceived
- ResponseStarted
- ResponseComplete
- Panic

Each of the events is compared against rules in order.
- None : Nothing sent to backend.
- Metadata : Metadata, but not request or response body, sent to backend.
- Request: Metadata and request, but not response body sent.
- RequestResponse: Metadata, request, and response bodies sent to backend.

#Audit Policy:
apiVersion: audit.k8s.io/v1 
kind: Policy 
rules: 
- level: Metadata 
  resources: 
  - group: "" 
    resources: ["pods/log", "pods/status"]
- level: Metadata
  omitStages:
  - "RequestReceived"
  
  
apiVersion: policy/v1beta1 
kind: PodSecurityPolicy 
metadata: 
   name: basicpolicy 
spec: 
privileged: true 
runAsUser: 
   rule: RunAsAny 
seLinux: 
  rule: RunAsAny 
fsGroup: 
  rule: RunAsAny 
supplementalGroups: 
  rule: RunAsAny 
allowedCapabilities: 
  - '*' 
volumes: 
  -'*'

- identity
- aescbc
- secretbox
- aesgcm
- kms

#Encryption Policy File
apiVersion: apiserver.config.k8s.io/v1 
kind: EncryptionConfiguration 
name: configureKeys 
resources: 
  - resources: 
    - secrets 
    providers: 
    - aescbc: 
        keys: 
        - name: encKey 
          secret: Ezqai0SIGChGOwf0VdbkFtYPUM2EYf1TAAQbDrfizJQ= 
    - identity: {}

--disable-admission-plugins and --enable-admission-plugins

The service account is usually tied to a secret, which usually contains ca.crt, token and namespace information to use.
```

Note:

* https://www.keycloak.org
* 

## 2.6. Chapter 6 Networking

```bash
iptables based plugin cant handle large number of node.

Calico : iptables (default), ipvs, WorkloadEndpoint, HostEndpoint, GlobalNetworkPolicy, eBPF dataplane
Weave : support mesh overlay  
kube-router : network policy via iptables, ipset and conntrack

netfilter
IP Virtual Server(IPVS) : transport layer load balancer, build on top of netfilter
firewalld

nftables

chains (of rules) - prerouting, input, output, forward, postrouting
tables (of chains) - filter, NAT, mangle, RAW, security


Linux Virtual Server(LVS)

```





## 2.7. Chapter 7 Workload Considerations

```bash

Sysdig or Aqua
ValidatingWebhookConfiguration
- Docker Bench, 
- Clair: quay.io by redhat, two part and three functional division
- Trivy
docker-bench-security

Falco - dynamic scanning tool, eBPF, perf, ftrace
Falco is composed of three main components: a userspace program, configuration, and a driver.

dynamic admission controller to insert an initContainer:
Custom Resource Definitions (CRDs)

https://github.com/aquasecurity/tracee

SELinux works with these three conceptual quantities:
- Contexts : These are labels to files, processes and ports. Examples of contexts are SELinux user, role and type.
- Rules : They describe access control in terms of contexts, processes, files, ports, users, etc.
- Policies : They are a set of rules that describe what system-wide access control decisions should be made by SELinux.

$ ls -Z
$ ps auZ

And we can use the chcon command to change the context:

$ chcon -t etc_t somefile
$ chcon --reference somefile someotherfile

$ ls -Z
-rw-rw-r--. dog dog unconfined_u:object_r:user_home_t:s0 somefile

$ chcon -t etc_t somefile
$ ls -Z
-rw-rw-r--. dog dog unconfined_u:object_r:etc_t:s0 somefile

$ ls -Z
-rw-rw-r--. dog dog unconfined_u:object_r:etc_t:s0 somefile
-rw-rw-r--. dog dog unconfined_u:object_r:user_home_t:s0 somefile1

$ chcon --reference somefile somefile1
$ ls -Z
-rw-rw-r--. dog dog unconfined_u:object_r:etc_t:s0 somefile
-rw-rw-r--. dog dog unconfined_u:object_r:etc_t:s0 somefile1

$ restorecon -Rv /home/jimih
ls -Z

[root@rhel7 /]# semanage fcontext -a -t httpd_sys_content_t /virtualHosts
[root@rhel7 /]# ls -Z
[root@rhel7 /]# restorecon -RFv /virtualHosts
[root@rhel7 /]# ls -Z

semanage boolean -l

Discretionary Access Control (DAC) model by providing Mandatory Access Control (MAC).

AppArmor:
sudo systemctl [start|stop|restart|status] apparmor
sudo apparmor_status

/usr/bin/evince
/etc/apparmor.d
man apparmor.d.

aa-logprof
aa-genprof

```

Note:

* https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/selinux_users_and_administrators_guide/index
* 

## 2.8. Chapter 8 Issue Detection



```bash
CVEs (Common Vulnerabilities and Exposures)

Kill chain, or cyber kill chain, is the attack progression.
- Reconnaissance
- Weaponization
- Delivery
- Exploitation
- Installation
- Command and Control (C2)
- Actions on Objectives

Host Intrusion Detection Systems (HIDS)
AIDE (Advanced Intrusion Detection Environment)
OSSEC is an open source host-based intrusion detection system
SNORT
Suricata is a newer NIDS tool

"The Suricata engine is capable of real time intrusion detection (IDS), inline intrusion prevention (IPS), network security monitoring (NSM) and offline pcap processing"

Physical Intrusion Detection Systems (PIDS)



```



Note:

* https://seclists.org/oss-sec/
* 



<br><br>

---
<br>


# 3. CKS Udemy Course

## 3.1. Section 1: Introduction



## 3.2. Section 2: Create your cluster

```bash
# CREATE cks-master VM using gcloud command
# not necessary if created using the browser interface
gcloud compute instances create cks-master --zone=europe-west3-c \
--machine-type=e2-medium --image=ubuntu-1804-bionic-v20201014 --image-project=ubuntu-os-cloud --boot-disk-size=50GB

# CREATE cks-worker VM using gcloud command
# not necessary if created using the browser interface
gcloud compute instances create cks-worker --zone=europe-west3-c \
--machine-type=e2-medium --image=ubuntu-1804-bionic-v20201014 --image-project=ubuntu-os-cloud --boot-disk-size=50GB

# you can use a region near you
https://cloud.google.com/compute/docs/regions-zones

# INSTALL cks-master
gcloud compute ssh cks-master
sudo -i
bash <(curl -s https://raw.githubusercontent.com/killer-sh/cks-course-environment/master/cluster-setup/latest/install_master.sh)

# INSTALL cks-worker
gcloud compute ssh cks-worker
sudo -i
bash <(curl -s https://raw.githubusercontent.com/killer-sh/cks-course-environment/master/cluster-setup/latest/install_worker.sh)
```



## 3.3. Section 3: Foundations - Kubernetes Secure Architecture

```bash
API Server					center of kubernetes cluster
Scheduler
ETCD
Controller Manager	

kubelet								run pod
kube-proxy 						service / IP tables

PKI
CA

cd /etc/kubernetes/pki
cd /var/lib/kubelet/pki


```



## 3.4. Section 4: Foundation - Containers under the hood

```bash
cgroups
docker run --name c1 -d ubuntu sh -c 'sleep 1d'
docker exec c1 ps aux

docker run --name c2 -d ubuntu sh -c 'sleep 99d'
docker exec c1 ps aux

docker run --name c2 --pid-container:c1 -d ubuntu sh -c 'sleep 99d'
docker exec c1 ps aux
docker exec c2 ps aux
```

Note:

* [What have containers done for you lately?](https://www.youtube.com/watch?v=MHv6cWjvQjM)



## 3.5. Section 5: Cluster Setup - Network Policies

```bash
k run frontend --image=nginx
k run backend --image=nginx
k expose pod frontend --port 80
k expose pod backend --port 80
k get pod,svc,ep
k exec frontend -- curl backend
k exec backend -- curl frontend

# default-deny NP which still allows DNS resolution
https://github.com/killer-sh/cks-course-environment/blob/master/course-content/cluster-setup/network-policies/default-deny/default-deny-allow-dns.yaml

cat <<EOF>> default-deny-all.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-all
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress
    egress:
  - to:
    ports:
    - port: 53
      protocol: TCP
    - port: 53
      protocol: UDP
EOF  

#Check policy
k describe netpol default-deny-all

# frontend->backend NP
https://github.com/killer-sh/cks-course-environment/tree/master/course-content/cluster-setup/network-policies/frontend-backend

# Network Policy: Frontend ->  Backend 

cat << EOF >> allow-frontend.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: frontend-policy
spec:
  podSelector:
    matchLabels:
      run: frontend
  policyTypes:
  - Egress
  - Ingress
  egress:
  - to:
    - podSelector:
        matchLabels:
          run: backend  
  ingress:										#ingress probably not require 
  - from:
    - podSelector:
        matchLabels:
          run: backend          
EOF

#check netpolicy
k describe netpol

cat << EOF >> allow-backend.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: backend-policy
spec:
  podSelector:
    matchLabels:
      run: backend
  policyTypes:
  - Egress
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          run: frontend
  egress:											#egress probably not required
  - to:
    - podSelector:
        matchLabels:
          run: frontend  
EOF

#check using ip adress
k get pod $o
k exec frontend -- curl backend_pod_ip_address

#check three tier connection
https://github.com/killer-sh/cks-course-environment/tree/master/course-content/cluster-setup/network-policies/frontend-backend-database
....

k create ns db
k run database --image=nginx
k expose pod database --port 80

```

Note:

* https://kubernetes.io/docs/concepts/services-networking/network-policies
* https://github.com/killer-sh/cks-course-environment/blob/master/course-content/cluster-setup/network-policies/default-deny/default-deny-allow-dns.yaml
* https://github.com/killer-sh/cks-course-environment/tree/master/course-content/cluster-setup/network-policies/frontend-backend
* https://github.com/killer-sh/cks-course-environment/tree/master/course-content/cluster-setup/network-policies/frontend-backend-database





## 3.6. Section 6: Cluster Setup - GUI Elements

```bash
kubectl proxy
kubectl port-forward

# --install kubernetes dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.1.0/aio/deploy/recommended.yaml

#File to check /etc/kubernetes/manifests/kube-apiserver.yaml

# -- change deployment conifg and add insecure-port options in the deployment, disable auto cert option, \
# change liveness port to 9090 and scheme to http.

 43         - --insecure-port=9090
 44         #- --auto-generate-certificates
 45         - --namespace=kubernetes-dashboard
k -n kubernetes-dashboard edit deployments.apps kubernetes-dashboard

#-- change kubernetes svc to NodePort and target port 9090, so that we can able to access outside
k -n kubernetes-dashboard edit service kubernetes-dashboard

http://node-ip:nodeport

#-- Give cluster role binding for SA account - kubernetes-dashboard

k -n kubernetes-dashboard create rolebinding insecure --serviceaccount kubernetes-dashboard:kubernetes-dashboard --clusterrole view

k -n kubernetes-dashboard create clusterrolebinding insecure --serviceaccount kubernetes-dashboard:kubernetes-dashboard --clusterrole view


```

Note:

* https://github.com/kubernetes/dashboard/blob/master/docs/common/dashboard-arguments.md





## 3.7. Section 7: Cluster Setup - Secure Ingress

```bash
ingress controller = nginx ingress

LB
NodePort
ClusterIP

# Install NGINX Ingress (bare-metal nodePort)
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.40.2/deploy/static/provider/baremetal/deploy.yaml

# K8s Ingress Docs
https://kubernetes.io/docs/concepts/services-networking/ingress

cat <<EOF>>ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: secure-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - http:
      paths:
      - path: /service1
        pathType: Prefix
        backend:
          service:
            name: service1
            port:
              number: 80
      - path: /service2
        pathType: Prefix
        backend:
          service:
            name: service2
            port:
              number: 80
EOF

k run pod1 --image=nginx
k run pod2 --image=httpd
k expose pod pod1 --port 80 --name service1
k expose pod pod2 --port 80 --name service2

--secure ingress over https
k -n ingress-nginx get svc

cloud_user@b8ec5a50d21c:~$ k -n ingress-nginx get svc
NAME                                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
ingress-nginx-controller             NodePort    10.111.138.16   <none>        80:32041/TCP,443:32707/TCP   20m
ingress-nginx-controller-admission   ClusterIP   10.111.48.138   <none>        443/TCP                      20m
cloud_user@b8ec5a50d21c:~$
cloud_user@b8ec5a50d21c:~$ ip -br a
lo               UNKNOWN        127.0.0.1/8 ::1/128
ens5             UP             172.31.38.113/20 

curl https://node-ip:secure_nodePort/service1 -kv
#check http port
curl http://172.31.38.113:32041/service1
curl http://172.31.38.113:32041/service2

#check https port and certificate
curl https://172.31.38.113:32707/service1 -kv
curl https://172.31.38.113:32707/service2 -kv

#-- tls https://kubernetes.io/docs/concepts/services-networking/ingress/#tls
#-- generate certificate and create tls secret, cn=https-example.foo.com
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes
k create secret tls secure-ingress --cert=cert.pem --key=key.pem
k get ing, secret

#-- modify above yaml file for secure ingress
cat <<EOF>>secure-ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: secure-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  tls:
  - hosts:
      - https-example.foo.com
    secretName: secure-ingress
  rules:
  - host: https-example.foo.com  
    http:
EOF

curl https://secure-ingress.com:31047/service2 -kv --resolve secure-ingress.com:31047:34.105.246.174
curl https://https-example.foo.com:32707/service2 -kv --resolve https-example.foo.com:32707:172.31.38.113


```

Note:

* https://kubernetes.io/docs/concepts/services-networking/ingress/#tls

* https://kubernetes.github.io/ingress-nginx/deploy/

  



## 3.8. Section 8: Cluster Setup - Node Metadata Protection

```bash

https://cloud.google.com/compute/docs/storing-retrieving-metadata

curl "http://metadata.google.internal/computeMetadata/v1/instance/disks/" -H "Metadata-Flavor: Google"

-- using netork policy block meta data server and port which means all IPs are allowed except metadata server


https://github.com/killer-sh/cks-course-environment/tree/master/course-content/cluster-setup/protect-node-metadata

# all pods in namespace cannot access metadata endpoint
cat <<EOF>>metadata-protection.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: cloud-metadata-deny
  namespace: default
spec:
  podSelector: {}
  policyTypes:
  - Egress
  egress:
  - to:
    - ipBlock:
        cidr: 0.0.0.0/0
        except:
        - 169.254.169.254/32
EOF
        
# only pods with label are allowed to access metadata endpoint
cat <<EOF>>allow-metadata-pod.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: cloud-metadata-allow
  namespace: default
spec:
  podSelector:
    matchLabels:
      role: metadata-accessor
  policyTypes:
  - Egress
  egress:
  - to:
    - ipBlock:
        cidr: 169.254.169.254/32        
EOF        
```

This example assumes AWS cloud, and metadata IP address is 169.254.169.254 should be blocked while all other external addresses are not.
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-only-cloud-metadata-access
spec:
  podSelector: {}
  policyTypes:
  - Egress
  egress:
  - to:
    - ipBlock:
      cidr: 0.0.0.0/0
      except:
      - 169.254.169.254/32
```      

Note:
* https://github.com/killer-sh/cks-course-environment/tree/master/course-content/cluster-setup/protect-node-metadata

  



## 3.9. Section 9: Cluster Setup - CIS Benchmarks

```bash
CIS Center for Internet Security
download doc from cis website for checking

command to check/audit issue
command to fix issue

-- May be unsecure cluster will be provided and u have to check it and fix it ......

-- kube-bench to check/audit security rule 
https://github.com/aquasecurity/kube-bench#running-inside-a-container

# run on master
docker run --pid=host -v /etc:/etc:ro -v /var:/var:ro -t aquasec/kube-bench:latest master --version 1.20

# run on worker
docker run --pid=host -v /etc:/etc:ro -v /var:/var:ro -t aquasec/kube-bench:latest node --version 1.20


gcp-cs-bench-mark


```

Note:

* https://github.com/aquasecurity/kube-bench#running-inside-a-container
* https://www.youtube.com/watch?v=53-v3stlnCo
* https://github.com/docker/docker-bench-security





## 3.10. Section 10: Cluster Setup - Verify Platform Binaries

```bash
#-- verify server binary
https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.19.md
wget https://dl.k8s.io/v1.19.10/kubernetes-server-linux-amd64.tar.gz
sha512sum kubernetes-server-linux-amd64.tar.gz

sha512 hash = 709f1a5fe6ffb70bbe9e670add7b3e92507c83dc10de06068cc73c0d18fe070cef36a3886471a06c6751de8b8ef2d52813064fc5cf6fb4d946b0c31a7567a3ca

#-- verify api-server binary from running process
tar zxf kubernetes-server-linux-amd64.tar.gz
sha512sum kubernetes/server/bin/kube-apiserver
docker cp docker-container-id:/ local-container-fs	#copy docker image filesystem to local for check sha512sum
sha512sum local-container-fs/usr/local/bin/kube-apiserver

now compare sha message

# check hash key with binary file
echo "$(<kubectl.sha256) kubectl" | sha256sum --check
```

Note: 

* https://github.com/kubernetes/kubernetes



## 3.11. Section 11: Cluster Hardening RBAC



```bash
-- 48
k create ns red
k create ns blue

k -n red create role secret-manager --verb=get --resource=secrets
k -n red create rolebinding secret-manager --role=secret-manager --user=jane
k -n blue create role secret-manager --verb=get,list --resource=secrets
k -n blue create rolebinding secret-manager --role=secret-manager --user=jane

# check permissions
k -n red auth can-i -h
k -n red auth can-i create pods --as jane # no
k -n red auth can-i get secrets --as jane # yes
k -n red auth can-i list secrets --as jane # no

k -n blue auth can-i list secrets --as jane # yes
k -n blue auth can-i get secrets --as jane # yes

k -n default auth can-i get secrets --as jane #no
```



```bash
-- 49
k create clusterrole deploy-deleter --verb=delete --resource=deployment
k create clusterrolebinding deploy-deleter --clusterrole=deploy-deleter --user=jane
k -n red create rolebinding deploy-deleter --clusterrole=deploy-deleter --user=jim

# test jane
k auth can-i delete deploy --as jane # yes
k auth can-i delete deploy --as jane -n red # yes
k auth can-i delete deploy --as jane -n blue # yes
k auth can-i delete deploy --as jane -A # yes
k auth can-i create deploy --as jane --all-namespaces # no

# test jim
k auth can-i delete deploy --as jim # no
k auth can-i delete deploy --as jim -A # no
k auth can-i delete deploy --as jim -n red # yes
k auth can-i delete deploy --as jim -n blue # no

```



```bash
-- 51
# Create KEY > Create CSR > API > download CRT from api > use CRT+KEY

openssl genrsa -out jane.key 2048
openssl req -new -key jane.key -out jane.csr # only set Common Name = jane


# create CertificateSigningRequest with base64 jane.csr
https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests
cat jane.csr | base64 -w 0

# add new KUBECONFIG
k config set-credentials jane --client-key=jane.key --client-certificate=jane.crt
k config set-credentials myuser --client-key=myuser.key --client-certificate=myuser.crt --embed-certs=true
k config set-context jane --cluster=kubernetes --user=jane
k config view
k config get-contexts
k config use-context jane


```

Note: 

* https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/
* https://rbac.dev/





## 3.12. Section 12: Cluster Hardening - Exercise caution in using ServiceAccounts

```bash
-- 54
# when a pod is created then token is mounted in it with ca, namespace. 
# pod has exact permission as like serviceaccount, so we should restrict sa for pod
# from inside a Pod we can do:
k exec frontend -- mount|grep secret
#cat /run/secrets/kubernetes.io/serviceaccount/token
k exec frontend -- cat /run/secrets/kubernetes.io/serviceaccount/token

k create sa accessor
k run accessor --imgae=nginx $do> accessor.yaml
now add new service accond in pod config
k -f accessor.yaml create 
k exec accessor -- mount|grep secret

root@web:/# curl https://kubernetes
root@web:/# curl https://kubernetes -k
k exec web -- cat /run/secrets/kubernetes.io/serviceaccount/token
k exec web -- curl https://kubernetes.default -k -H "Authorization: Bearer <SA_TOKEN_PASTE_HERE>"
Response of above command:
  "status": "Failure",
  "message": "forbidden: User \"system:serviceaccount:default:default\" cannot get path \"/\"",
  
  
--55
#disable auto mount service account while creating SA, so no-one can access SA in pod
cat <<EOF>>disable-sa-automount.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: build-robot
automountServiceAccountToken: false
...
EOF

#disable sa in pod
cat <<EOF>>disable-sa-in-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  serviceAccountName: build-robot
  automountServiceAccountToken: false
  ...
EOF  

-- 56
--create cluster rolebinding for service account
k auth can-i delete secrets --as system:serviceaccount:default:accessor
k create cluster rolebinding accessor --clusterrole edit --serviceaccount default:accessor
k auth can-i delete secrets --as system:serviceaccount:default:accessor

```

Note:

* https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account
* 



## 3.13. Section 13: Cluster Hardening - Restricted API Access



```bash
-- 58,59,61
request - Authentication (who), Authorization (are u allowed), Admission Control (has limit reached?...more opa)
outside > api-server
Pod > api-server
Node > api-server

-- security concern 

--disable anonymous access
kube-apiserver --anonymous-auth=true|false , default=true

--insecure-port 8080 is not allowed since 1.20
curl https://api-server:8080

k config view --raw
echo key|base64 -d > crt
curl https://:6443 --cacert ca --cert crt --key key

--61
# inspect apiserver cert, which ip address and name allowed to access
cd /etc/kubernetes/pki
openssl x509 -in apiserver.crt -text

access api server via nodeport from external client node
-- change svc config for cuslter to nodeport
-- in exteranl client copy kubernetes conf file from master node
-- At clinet, add extenal ip address in /etc/hosts file with name kubernetes
-- change config api server with name
-- now try to access api server

k --kubeconfig conf get ns

--62 admission control 
#check mainfest file in master node /etc/kubernetes/manifests/kube-apiserver.yaml
kube-apiserver --enable-admission-plugins=NodeRestriction

at worker node
export KUBECONFIG=/etc/kubernetes/kubelet.conf
k get ns

```

Note:

* https://kubernetes.io/docs/concepts/security/controlling-access
* 



## 3.14. Section 14: Cluster Hardening - Upgrade Kubernetes



```bash
1.19.2
major.minor.patch

apiserver, scheduler, controller-manager (one minor version)
kubelet/kube-proxy (two minor version below), kubectl (one minor above/below)

--upgrade cluster

```



## 3.15. Section 15: Microservice Vulnerabilites - Secrets

```bash
#--73
#-- hack secret from docker run time configuration 
docker inspect
docker .... cp sec_location target_loc 


# --74 hack secret in etcd db
# access secret int etcd
cat /etc/kubernetes/manifests/kube-apiserver.yaml | grep etcd

ETCDCTL_API=3 etcdctl --cert /etc/kubernetes/pki/apiserver-etcd-client.crt --key /etc/kubernetes/pki/apiserver-etcd-client.key --cacert /etc/kubernetes/pki/etcd/ca.crt endpoint health

# --endpoints "https://127.0.0.1:2379" not necessary because we’re on same node
ETCDCTL_API=3 etcdctl --cert /etc/kubernetes/pki/apiserver-etcd-client.crt --key /etc/kubernetes/pki/apiserver-etcd-client.key --cacert /etc/kubernetes/pki/etcd/ca.crt get /registry/secrets/default/secret1



#-76 encryption secret 
# encrypt etcd docs page
# contains also example on how to read etcd secret
https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data

# read secret from etcd
ETCDCTL_API=3 etcdctl --cert /etc/kubernetes/pki/apiserver-etcd-client.crt --key /etc/kubernetes/pki/apiserver-etcd-client.key --cacert /etc/kubernetes/pki/etcd/ca.crt get /registry/secrets/default/very-secure

--re-create secret using aescbc ..... need yaml 
https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/#encrypting-your-data


--77
https://kubernetes.io/docs/concepts/configuration/secret/#risks
https://www.youtube.com/watch?v=f4Ru6CPG1z4
https://www.cncf.io/webinars/kubernetes-secrets-management-build-secure-apps-faster-without-secrets

kms provider
aescbc
hasicorp-vault

```

Encrypt etcd db using encryption key provider (aescbc)
```bash
# secret key length should be 16/24/32 
head -c 32 /dev/urandom | base64

# encryption config file
cat <<EOF>>/etc/kubernetes/etcd/ec.yaml
apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
resources:
  - resources:
    - secrets
    providers:
    - aescbc:
        keys:
        - name: key1
          secret: cGFzc3dvcmRwYXNzd29yZA==
    - identity: {}
EOF

# Change /etc/kubernetes/manifests/kube-apiserver.yaml config and also mount dir for reading ec.yaml file and otherwise api-server will not start
# for api server start issue, check logs at /var/log/pods/kube-system_kube-apiserver*/kube-apiserver/
# --encryption-provider-config=/etc/kubernetes/etcd/ec.yaml

# create a secret for test
kubectl create secret generic secret1 -n default --from-literal=mykey=mydata

# read secret from etcd, if etcd client is not install then install it
ETCDCTL_API=3 etcdctl get /registry/secrets/default/secret1 [...] | hexdump -C
sudo ETCDCTL_API=3 etcdctl get /registry/secrets/default/secret1 --cert=/etc/kubernetes/pki/apiserver-etcd-client.crt --key=/etc/kubernetes/pki/apiserver-etcd-client.key --cacert=/etc/kubernetes/pki/etcd/ca.crt

sudo ETCDCTL_API=3 etcdctl get /registry/secrets/default/secret2 --cert=/etc/kubernetes/pki/apiserver-etcd-client.crt --key=/etc/kubernetes/pki/apiserver-etcd-client.key --cacert=/etc/kubernetes/pki/etcd/ca.crt

# verify
kubectl describe secret secret1 -n default

# Ensure all secrets are encrypted
kubectl get secrets --all-namespaces -o json | kubectl replace -f -
```

Decrypting all secret data so that we can able to remove encryption key which we have used before ....
```bash
# Change the providers order 
cat <<EOF>>/etc/kubernetes/etcd/ec.yaml
apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
resources:
  - resources:
    - secrets
    providers:
    - identity: {}
    - aescbc:
        keys:
        - name: key1
          secret: cGFzc3dvcmRwYXNzd29yZA==
EOF

# restart kube-api-server

# recreate all secret without encryption
kubectl get secrets --all-namespaces -o json | kubectl replace -f -
```

**Note:**

* https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/#encrypting-your-data
* [Base64 is not encryption A better story for Kubernetes Secrets](https://www.youtube.com/watch?v=f4Ru6CPG1z4)
* https://www.cncf.io/webinars/kubernetes-secrets-management-build-secure-apps-faster-without-secrets



## 3.16. Section 16: Microservice Vulnerabilites - Container runtime (Sandboxes)

Install gVisor and configure runsc environment
```bash
# gVisor / runsc
# kata container (light weight virtual machine)

# install gVisor
curl -fsSL https://gvisor.dev/archive.key | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64,arm64] https://storage.googleapis.com/gvisor/releases release main"
sudo apt-get update && sudo apt-get install -y runsc

# create runsc config
sudo vi /etc/containerd/config.toml

Find the disabled_plugins section and add the restart plugin.
 disabled_plugins = ["io.containerd.internal.v1.restart"]

Find the block [plugins."io.containerd.grpc.v1.cri".containerd.runtimes] . After the existing runc block, add configuration for a runsc runtime. It should look like this when done:

[plugins."io.containerd.grpc.v1.cri".containerd.runtimes]
  [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
    runtime_type = "io.containerd.runc.v1"
    runtime_engine = ""
    runtime_root = ""
    privileged_without_host_devices = false
  [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runsc]
    runtime_type = "io.containerd.runsc.v1"

Locate the block and set   to true .
[plugins."io.containerd.runtime.v1.linux"] ...
  shim_debug = true

sudo systemctl restart containerd
sudo systemctl status containerd
```

Now, create a RuntimeClass and use that while creating pods

```bash
#--78
# dirty cow
# --oci
CRI Container Runtime Interface

# cir ctl command to check pods and process
crictl pods
crictl ps

# kata container = light individual private vm with light kernel + pods
# gVisor runsc containerd

cat <<EOF>>runtimesc.yaml
apiVersion: node.k8s.io/v1  # RuntimeClass is defined in the node.k8s.io API group
kind: RuntimeClass
metadata:
  name: myclass  # The name the RuntimeClass will be referenced by
  # RuntimeClass is a non-namespaced resource
handler: runsc  # The name of the corresponding CRI configuration
EOF
k create -f runtimesc.yaml

apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  runtimeClassName: myclass
...

# check logs and compare
kubectl exec non-sandbox-pod -- dmesg 
kubectl exec sandbox-pod -- dmesg
```

**Note:**
* [OCI, CRI, ??: Making Sense of the Container Runtime Landscape in Kubernetes - Phil Estes, IBM](https://www.youtube.com/watch?v=RyXL1zOa8Bw)
* [Sandboxing your containers with gVisor (Cloud Next '18)](https://www.youtube.com/watch?v=kxUZ4lVFuVo)
* [Kata Containers An introduction and overview](https://www.youtube.com/watch?v=4gmLXyMeYWI)



## 3.17. Section 17: Microservice Vulnerabilites - OS Security



```bash
--87
run pod as a non-root id 1000 and try to create file after login 
run container as non-root-id security context 
run docker container as privileged ( privileged: true)
privilegeEscalation (child process get more priviledge thatn parent process, default true)

pod security policy 
 - allow pod security in api-server config admission control 
 - create role and rolebinding to allow deafult service account, RBAC (use), otherwise pod will not create
 


```

Note:

* https://kubernetes.io/docs/concepts/policy/pod-security-policy/

  

## 3.18. Section 18: Microservice Vulnerabilites - mTLS



```bash
--97
mTLS - mutual TLS, two way authentication 

side car proxy 

k run app --image=bash --command -oyaml --dry-run=client >app.yaml --sh -c 'ping www.google.com'

```

Note:

* https://istio.io/latest/blog/2019/data-plane-setup/
* https://istio.io/latest/docs/setup/additional-setup/sidecar-injection/



## 3.19. Section 19: Open Policy Agent (OPA)

```bash
# OPA is a general purpose policy agent for unified, context-aware policy enforcement across the entire stack 
# rego language for policy definition 
# works with JSON/YAML
# uses k8s admission controller 
# OPA Gatekeeper for kubernetes: Custom Resource Definitions (CRDs), ConstraintTemplate/CRD <> Constraint <> Object  
# 

# OPA Gatekeeper for Kubernetes installation
# kubectl create -f https://raw.githubusercontent.com/killer-sh/cks-course-environment/master/course-content/opa/gatekeeper.yaml
kubectl apply -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/release-3.5/deploy/gatekeeper.yaml

# /etc/kubernetes/manifests/kube-apiserver.yaml
# enable-admission-plugins=NodeRestriction 
```

Now check gatekeeper and webhook status

```bash
vagrant@cks-master:~$ k get pod -n gatekeeper-system
NAME                                             READY   STATUS    RESTARTS   AGE
gatekeeper-audit-54c9759898-jttqq                1/1     Running   0          4m17s
gatekeeper-controller-manager-6bcc7f8fb5-dnm4t   1/1     Running   0          4m17s
gatekeeper-controller-manager-6bcc7f8fb5-fck5d   1/1     Running   0          4m17s
gatekeeper-controller-manager-6bcc7f8fb5-jqqd6   1/1     Running   0          4m17s
vagrant@cks-master:~$

vagrant@cks-master:~$ k get crd
NAME                                                 CREATED AT
configs.config.gatekeeper.sh                         2021-07-08T16:43:02Z
constraintpodstatuses.status.gatekeeper.sh           2021-07-08T16:43:02Z
constrainttemplatepodstatuses.status.gatekeeper.sh   2021-07-08T16:43:02Z
constrainttemplates.templates.gatekeeper.sh          2021-07-08T16:43:02Z
vagrant@cks-master:~$

k get constrainttemplate ...
k edit constrainttemplate ...
```

Now create a predefine template and test the functionality 

```bash
cat <<EOF>>alwaysdeny_template.yaml
apiVersion: templates.gatekeeper.sh/v1beta1
kind: ConstraintTemplate
metadata:
  name: k8salwaysdeny
spec:
  crd:
    spec:
      names:
        kind: K8sAlwaysDeny
      validation:
        # Schema for the `parameters` field
        openAPIV3Schema:
          properties:
            message:
              type: string
  targets:
    - target: admission.k8s.gatekeeper.sh
      rego: |
        package k8salwaysdeny

        violation[{"msg": msg}] {
          1 > 0
          msg := input.parameters.message
        }
EOF

# all condition should be true to through the violation

cat <<EOF>>all_pod_always_deny.yaml
apiVersion: constraints.gatekeeper.sh/v1beta1
kind: K8sAlwaysDeny
metadata:
  name: pod-always-deny
spec:
  match:
    kinds:
      - apiGroups: [""]
        kinds: ["Pod"]
  parameters:
    message: "ACCESS DENIED!"
EOF

# above two definition from github links
k apply -f https://raw.githubusercontent.com/killer-sh/cks-course-environment/master/course-content/opa/deny-all/alwaysdeny_template.yaml
k apply -f https://raw.githubusercontent.com/killer-sh/cks-course-environment/master/course-content/opa/deny-all/all_pod_always_deny.yaml
```


Now verification and editing the policy 
```bash
vagrant@cks-master:~$ k get crd
NAME                                                 CREATED AT
configs.config.gatekeeper.sh                         2021-07-08T16:43:02Z
constraintpodstatuses.status.gatekeeper.sh           2021-07-08T16:43:02Z
constrainttemplatepodstatuses.status.gatekeeper.sh   2021-07-08T16:43:02Z
constrainttemplates.templates.gatekeeper.sh          2021-07-08T16:43:02Z
k8salwaysdeny.constraints.gatekeeper.sh              2021-07-08T17:01:21Z

vagrant@cks-master:~$ k get constrainttemplate
NAME            AGE
k8salwaysdeny   54s
vagrant@cks-master:~$

# both command will provide same result
k describe constrainttemplate k8salwaysdeny
k describe constrainttemplates.templates.gatekeeper.sh k8salwaysdeny

# to edit policy logic
k edit constrainttemplate k8salwaysdeny

vagrant@cks-master:~$ k get k8salwaysdeny
NAME              AGE
pod-always-deny   2m58s
vagrant@cks-master:~$

# important to check below command after creating constraint object as It might impact already configured pod in the next runtime. 
# violation check 
k describe k8salwaysdeny.constraints.gatekeeper.sh pod-always-deny
k describe k8sAlwaysDeny pod-always-deny

```

Label constraint check 


Note: 

* https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/
* https://www.youtube.com/watch?v=RDWndems-sk
* https://play.openpolicyagent.org
* https://github.com/BouweCeunen/gatekeeper-policies
* https://github.com/killer-sh/cks-course-environment/tree/master/course-content/opa/namespace-labels
* https://github.com/killer-sh/cks-course-environment/tree/master/course-content/opa/deny-all



## 3.20. Section 20: Supply Chain Security - Image Footprint

```bash

-- multi stage docker image build

use another FROM image 
....
COPY 0


-- dont run as root
# RUN useradd 
# Create user and set ownership and permissions as required
RUN adduser -D myuser && chown -R myuser /myapp-data
COPY 
USER myuser
CMD[]

--
#  Don’t bind to a specific UID, like UID 1000

# Make executables owned by root and not writable
...
WORKDIR $APP_HOME
COPY --chown=app:app app-files/ /app
USER app
ENTRYPOINT /app/my-app-entrypoint.sh


#Multistage builds
#This is the "builder" stage
FROM golang:1.15 as builder
WORKDIR /my-go-app
COPY app-src .
RUN GOOS=linux GOARCH=amd64 go build ./cmd/app-service
#This is the final stage, and we copy artifacts from "builder"
FROM gcr.io/distroless/static-debian10
COPY --from=builder /my-go-app/app-service /bin/app-service
ENTRYPOINT ["/bin/app-service"]

# .dockerignore file to explicitly exclude files and directories.
# create a subdir for copy and use that folder as build context 
docker build -t myimage files/


# -- make file system read only
RUN chmod a-w /etc

-- remove shell access
RUN rm -rf /bin/*
```

Secure DevOps Workflow 
```bash
# scan image in CI/CD pipeline

# kubernetes & container monitoring: Performance, Capacity & Security

```


Note:
- https://docs.docker.com/develop/develop-images/dockerfile_best-practices
- https://sysdig.com/blog/dockerfile-best-practices/
- https://sysdig.com/blog/image-scanning-best-practices/





## 3.21. Section 21: Supply Chain Security - Static Analysis 

```bash

kubesec.io
conftest.dev
user kubesec + OPA

-- 116
git clone https://github.com/killer-sh/cks-course-environment.git
cd cks-course-environment/course-content/supply-chain-security/static-analysis/conftest/kubernetes
./run.sh

-- check kube config file using help of docker based on OPA config


--117
git clone https://github.com/killer-sh/cks-course-environment.git
cd cks-course-environment/course-content/supply-chain-security/static-analysis/conftest/docker
./run.sh

Rego Policy language

```



## 3.22. Section 22: Supply Chain Security - Image Vulnerability Scanning

```bash
# -- 119
# Clair Trivy

# Trivy check for vulnerability 
https://github.com/aquasecurity/trivy#docker
docker run ghcr.io/aquasecurity/trivy:latest image nginx:latest

# trivy install
sudo apt-get install wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy

trivy -v

# check image vulnerability 
trivy image nginx:1.14.1

# check high and critical vulnerability
trivy image nginx|grep -i HIGH
trivy image nginx|grep -i critical

# -- question will come in exam, 
```

Note: 
- https://aquasecurity.github.io/trivy/v0.18.3/installation/
- https://aquasecurity.github.io/trivy/v0.19.2/


## 3.23. Section 23: Supply Chain Security - Secure Supply Chain

```bash
# -- 123
# -- 125
# install opa
kubectl create -f https://raw.githubusercontent.com/killer-sh/cks-course-environment/master/course-content/opa/gatekeeper.yaml

# opa resources
https://github.com/killer-sh/cks-course-environment/tree/master/course-content/supply-chain-security/secure-the-supply-chain/whitelist-registries/opa

# check OPA in section-19
```



## 3.24. Section 24: Runtime Security - Behavioral Analytics at host and container level

```bash
seccomp, appArm
syscall
strace
pstree -p
cd /proc/process_id
ls -lah exe
cat environ

-- 133
falco run time security
access
accert
action

# install falco
curl -s https://falco.org/repo/falcosecurity-3672BA8F.asc | apt-key add -
echo "deb https://dl.bintray.com/falcosecurity/deb stable main" | tee -a /etc/apt/sources.list.d/falcosecurity.list
apt-get update -y
apt-get -y install linux-headers-$(uname -r)
apt-get install -y falco

# docs about falco
https://v1-16.docs.kubernetes.io/docs/tasks/debug-application-cluster/falco

falco rule and check system log
change default rule

service status falco
```

**Now modify falco rules and provide output in custom format.**

```bash
# important question: to check and practice
Question: change falco rule to get custom output format
Rule: "A shell was spawned in a container with an attached terminal"
Output Format: TIMME,USER-NAME,CONTAINER-NAME,CONTAINER-ID
Priority: WARNING

cd /etc/falco
# as a precaution we can copy default rule file as a backup and then edit file 

# we can able to modify in falco_rules.local.yaml and faclco will overwrite rule 
vim falco_rules.local.yaml

# compile all the rules and check if modification is working as expected ..... and check live logs 
falco

# run pod
k exec -it pod sh
```

Note:

* https://falco.org/docs/rules/supported-fields
* https://falco.org/docs/getting-started/
* [Syscall talk by Liz Rice](https://www.youtube.com/watch?v=8g-NUUmCeGI)



## 3.25. Section 25: Runtime Security - Immunity of containers at runtime

```bash
--140
by startupProbe remove /bin/touch

-- run as non-root user read only fs
readOnlyRootFilesystem : true

create empty dir for process log

k run immutable --image=nginx $do > immutable.yaml

```



## 3.26. Section 26: Runtime Security - Auditing

```bash
create secret 
k create secret generic very-secure --from-literal=user=admin

check audit logs for secret information
/etc/kubernetes/audit/logs/audit.log

-- Task: 
Nothing from stage RequestReceived
Nothing from get,watch,list
From secret only metadata level
Everything else RequestResponse level

-- Action plan:
change policy file
Disable audit logging in apiserver 
Enable audit logging in apiserver
check api server logs - /var/log/pods/kube-system_kube-apiserver*

cat <<EOF>/etc/kubernetes/audit/policy.yaml
apiVersion: audit.k8s.io/v1 
kind: Policy
omitStages:
  - "RequestReceived"
rules:  
- level: None
  verbs: ["get","list","watch"]
- level: Metadata
  resources:
  - group: ""
    resources: ["secrets"]
- level: RequestResponse    
EOF


/etc/kubernetes/manifests/kube-apiserver.yaml
#--audit-policy-file=/etc/kubernetes/audit/policy.yaml
#--audit-log-path=/etc/kubernetes/audit/logs/audit.log


-- 147
https://github.com/killer-sh/cks-course-environment/tree/master/course-content/runtime-security/auditing

Task: Investigate API access history of a secret 
1. Change policy file to include RequestResponse from secrest
2. Create a new serviceAccounnt(+secret) and confirm Request+Response are available
3. Create a pod that uses the ServiceAccount

cat <<EOF>/etc/kubernetes/audit/policy.yaml
apiVersion: audit.k8s.io/v1 
kind: Policy
omitStages:
  - "RequestReceived"
rules:  
- level: None
  verbs: ["get","list","watch"]
- level: RequestResponse
  resources:
  - group: ""
    resources: ["secrets"]
- level: RequestResponse    
EOF

k create sa very-crazy-sa
k get secret
k run accessor --image=nginx $do > accessor.yaml
vim accessore.yaml #add service account
```

Note:
* https://kubernetes.io/docs/tasks/debug-application-cluster/audit/
* https://jsonformatter.curiousconcept.com
* https://www.youtube.com/watch?v=HXtLTxo30SY





## 3.27. Section 27: System Hardening - Kernel Hardening tools - AppArmor and Seccomp

```bash
# -- AppArmor

careate profile - what can do and what are not allowed, 
mode - Unconfined, Complain, Enforce
aa-status
aa-genprof	#gnerate profile
aa-complain
aa-enforce
aa-logprof	#check log and add to profile for allow system call

apt-get install apparmor-util
aa-genprof curl
curl killer.sh

aa-logprof
profile loc: /etc/apparmor.d

-- 153 apparmor profile for docker 
# apparmor profile
https://github.com/killer-sh/cks-course-environment/blob/master/course-content/system-hardening/kernel-hardening-tools/apparmor/profile-docker-nginx

# k8s docs apparmor
https://kubernetes.io/docs/tutorials/clusters/apparmor/#example

# generate docker-nginx profile by below command 
apparmor_parser /etc/apparmor.d/docker-nginx
aa-status


--153 apparmor for kubernetes pod (AppArmor annotation key and value)
k run secure --image=nginx $do > secure.yaml
vim secure.yaml # add pod annotation key and value, 
container.apparmor.security.beta.kubernetes.io/<container_name>: localhost/<profile_name>

k -f secure.yaml create
```

Seccomp for docker container -
```bash
# -- seccomp module in linux kernel + BPF Filters

# create a json file by copying content from below link
# https://github.com/killer-sh/cks-course-environment/blob/master/course-content/system-hardening/kernel-hardening-tools/seccomp/profile-docker-nginx.json
vim default.json

# now run container using seccomp 
docker run nginx
docker run --security-opt seccomp=default.json ngin
```

Seccomp for kubernetes pod -
```bash
# -- 156
#  seccomp profile dir location is define in kubelet config
# --seccomp-profile-root string     Default: `/var/lib/kubelet/seccomp`
# --seccomp-profile-root flag is deprecated since Kubernetes v1.19

# add seccomp profile in pod defination
# profile location: /var/lib/kubelet/seccomp

cat <<EOF> seccom.yaml
apiVersion: v1
kind: Pod
metadata:
  name: audit-pod
  labels:
    app: audit-pod
spec:
  securityContext:
    seccompProfile:
      type: Localhost
      localhostProfile: audit.json
  containers:
  - name: test-container
    image: hashicorp/http-echo:0.2.3
    args:
    - "-text=just made some syscalls!"
    securityContext:
      allowPrivilegeEscalation: false
EOF

kubectl apply -f seccom.yaml
```

Create Pod that uses the Container Runtime Default Seccomp Profile. The default seccomp profile should provide adequate access for most workloads.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: audit-pod
  labels:
    app: audit-pod
spec:
  securityContext:
    seccompProfile:
      type: RuntimeDefault
  containers:
  - name: test-container
    image: hashicorp/http-echo:0.2.3
    args:
    - "-text=just made some syscalls!"
    securityContext:
      allowPrivilegeEscalation: false
```      
Note:
* https://kubernetes.io/docs/tutorials/clusters/apparmor/
* https://kubernetes.io/docs/tutorials/clusters/seccomp/#create-a-pod-with-a-seccomp-profile-for-syscall-auditing
* [syscalls](https://www.youtube.com/watch?v=8g-NUUmCeGI)
* [AppArmor, SELinux Introduction](https://www.youtube.com/watch?v=JFjXvIwAeVI)







## 3.28. Section 28: System Hardening - Reduce Attack Surface

```bash
-- disable service, port etc if not used 

netstat -plnt
lsof -i :22
systemctl
ps aux

systemctl --list-unit
systemctl --list-unit --type=service

--disable sevice which listen on port 21
netstat -plnt|grep 21
lsof -i :21
systemctl --list-unit --type=service |grep ftp

```

<br><br>

---
<br>


# 4. CKS: A-Cloud-Guru Course

[Documnet to follow](cks-doc-acloudguru/1623084497910-CKS_Study_guide.pdf) for the A-Cloud-Guru course.


## 4.1. Chapter 1: CKS Introduction

```bash
cat <<EOF| sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

sudo mkdir -p /etc/containerd

network use calico

layer security model - infrastructure, cluster, container and code
Cluster, Host systems, Applications, Supply Chain, Everything ....
```


## 4.2. Chapter 2: Kubernetes Cluster Setup

### 4.2.1. Restrict Default Access with NetworkPolicies 

```bash
- NetworkPolicy
- Default Deny
- 

#target outcome is diable communication between client and server using default deny networkpolicy, for policy take reference from kubernetes site
# client <networkPolicy config> server application

#server application
k create ns nptest
kn nptest
k create deployment nginx --image=nginx $do >nginx-dep.yaml
k -f nginx-dep.yaml create

#client pod
k run client --image=radial/busyboxplus:curl --command -- /bin/sh -c "while true; do echo hi; sleep 10; done"
k run client --image=radial/busyboxplus:curl -- /bin/sh -c "sleep 3600"

#create defaul deny network policy and it will be created in current ns
cat <<EOF>>netpolicy-default-deny-all.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-all
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress  
EOF

k -f netpolicy-default-deny-all.yaml create
k describe networkpolicies.networking.k8s.io default-deny-all

#test command and check response of curl command, by defaul communication allowed, communication disable once policy configured
k exec client -- curl 10.44.0.6


# Exam Tips:
- Use a default deny network policy to block all network traffic to and/or from Pods in a namespace. 
- Use an empty podSelector {} to make the policy apply to all Pods in the namespace.
- Use the policyTypes field to block incoming traffic (ingress), outgoing traffic (egress), or both.

```

Note: 
- https://kubernetes.io/docs/concepts/services-networking/network-policies/#default-deny-all-ingress-and-all-egress-traffic


### 4.2.2. Allowing Limited Access with NetworkPolices 

```bash

#allow traffic between client and server
k label namespaces nptest project=test
k label pods client role=client

#allow incoming of server node from client node only
cat <<EOF>>allow-in-server-traffic.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-traffic
  namespace: nptest
spec:
  podSelector:
    matchLabels:
      app: nginx
  policyTypes:
  - Ingress
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          project: test
      podSelector:
        matchLabels:
          role: client
    ports:
    - protocol: TCP
      port: 80

EOF

k -f allow-in-server-traffic.yaml create 

# allow outgoing of client node to server node only
cat <<EOF>>allow-client-outgoing.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-out-client
  namespace: nptest
spec:
  podSelector:
    matchLabels:
      role: client
  policyTypes:
  - Egress
  egress:
  - to:
    - namespaceSelector:
        matchLabels:
          project: test
      podSelector:
        matchLabels:
          app: nginx
    ports:
    - protocol: TCP
      port: 80
EOF

k create -f allow-client-outgoing.yaml

# check communication after creating above network policy 
k exec client -- curl 10.44.0.6

# Exam Tips:
- If any policy allows a particular type of traffic, it will be allowed. This means you can add targeted policies alongside a default deny policy to allow necessary traffic.
- Use a policy's podSelector to target the policy to specific Pods based upon their labels.
- Use Ingress/Egress rules to specify Pods, namespaces, or IP addresses to allow traffic to and/or from.
- Pay attention to the difference between one rule with multiple selectors, and multiple rules.

``` 

### 4.2.3. Hands-on Lab: Lock Down Inter-Pod Communication with NetworkPolicies

```bash
ns: web-auth
auth-client  <> web-auth-server

#check communication logs
kubectl logs auth-client -n web-auth

cloud_user@k8s-control:~$ k get pod --show-labels
NAME              READY   STATUS    RESTARTS   AGE   LABELS
auth-client       1/1     Running   0          41m   app=auth-client
web-auth-server   1/1     Running   0          41m   app=auth-server

# create defaul deny incoming network policy and it will be created in current ns
cat <<EOF>default-deny-incoming.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-incoming
spec:
  podSelector: {}
  policyTypes:
  - Ingress
EOF


k -f default-deny-incoming.yaml create


# allow incoming of server node from client node only
cat <<EOF>auth-server.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-auth-server
  namespace: web-auth
spec:
  podSelector:
    matchLabels:
      app: auth-server
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: auth-client
    ports:
    - protocol: TCP
      port: 80

EOF

k -f auth-server.yaml create 

#check logs again
kubectl logs auth-client -n web-auth

```

### 4.2.4. Running a CIS Benchmark with kube-bench

```bash
CIS = Center for Internet Security

# kube-bench will probvide kubernetes cluster security report against criteria define by CIS

# Exam Tips
- The CIS Kubernetes Benchmark is a set of standards and best practices for a secure Kubernetes cluster.
- Tools like kube-bench automatically check your cluster to see if it conforms to the CIS Kubernetes Benchmark standards and generate a report.

kube-bench repo: https://github.com/aquasecurity/kube-bench

wget -O kube-bench-control-plane.yaml https://raw.githubusercontent.com/aquasecurity/kube-bench/main/job-master.yaml
wget -O kube-bench-node.yaml https://raw.githubusercontent.com/aquasecurity/kube-bench/main/job-node.yaml
kubectl create -f kube-bench-control-plane.yaml 
kubectl create -f kube-bench-node.yaml
kubectl get pods
kubectl logs <Control Plane Job Pod name> > kube-bench-results-control-plane.log
kubectl logs <Node Job Pod name> > kube-bench-results-node.log

#delete job
kubectl delete job kube-bench-master
kubectl delete job kube-bench-node

```
Note: 
- https://github.com/aquasecurity/kube-bench
- https://www.cisecurity.org/benchmark/kubernetes/

### 4.2.5. Fixing Security Issues Detected by a CIS Benchmark

```bash
find the probelm
fix it 
delete old job pod
re-create new job
check report again 

# Exam Tips:
- The CIS Benchmark output includes remediation steps which you can use to address issues. 
- kubeadm clusters use a kubelet config file located at /var/lib/kubelet/config.yaml on each node. 
- In a kubeadm cluster, manifest files for control plane components (API server, etc, etc.) can be found in /etc/kubernetes/manifests on the control plane server.

sudo vi /etc/kubernetes/manifests/kube-controller-manager.yaml
sudo vi /var/lib/kubelet/config.yaml

kubectl logs <Control Plane Job Pod name> > kube-bench-results-control-plane-fixed.log
kubectl logs <Node Job Pod name> > kube-bench-results-node-fixed.log

```

### 4.2.6. Strengthen Cluster Security with a CIS Kubernetes Benchmark
```bash

k create -f kube-bench-control-plane.yaml
k create -f kube-bench-node.yaml

k logs <Control Plane Job Pod name> > kube-bench-results-control-plane-fixed.log
k logs <Node Job Pod name> > kube-bench-results-node-fixed.log

k delete job kube-bench-master
k delete job kube-bench-node

```

### 4.2.7. Implementing TLS with Ingress
```bash
# check video from udemy kill sheel cks course and also check test criteria
# Flow of communication: nginx ingress controller <> tls based ingress in k8s <> service for pod/deployment

- ingress controller = nginx ingress
- ingress provide LB service on top of kubernetes service 
- Communication Flow: End User <> Ingress (TLS) <> Service <> Pod 

k create ns ingresstest
k create deployment ingress-test-nginx --image=nginx $do > ingress-nginx-dep.yaml
k create -f ingress-nginx-dep.yaml
k expose deployment ingress-test-nginx --port=80 --name ingresstest-nginx-svc
k exec client -n  nptest -- curl 10.96.176.134

# generate a certificate and create tls secret, cn=https-example.foo.com
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes -subj "/CN=https-example.foo.com"
k create secret tls secure-ingress --cert=cert.pem --key=key.pem
k get ing, secret

# now create ingress resource with TLS secret 
# modify above yaml file for secure ingress
cat <<EOF>>secure-ingress.yaml      #taken from kubernetes site
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: secure-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  tls:
  - hosts:
      - https-example.foo.com
    secretName: secure-ingress
  rules:
  - host: https-example.foo.com  
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: ingresstest-nginx-svc
            port:
              number: 80    
EOF

k create -f secure-ingress.yaml
k get ingress secure-ingress
k describe ingress secure-ingress

vagrant@cks-master:~/cks-a-cloud-guru$ k describe ingress secure-ingress
Name:             secure-ingress
Namespace:        ingresstest
Address:
Default backend:  default-http-backend:80 (<error: endpoints "default-http-backend" not found>)
TLS:
  secure-ingress terminates https-example.foo.com
Rules:
  Host                   Path  Backends
  ----                   ----  --------
  https-example.foo.com
                         /   ingresstest-nginx-svc:80 (10.44.0.10:80)
Annotations:             nginx.ingress.kubernetes.io/rewrite-target: /
Events:                  <none>
vagrant@cks-master:~/cks-a-cloud-guru$

# need perfect understanding and test command
#curl https://secure-ingress.com:80/ingresstest-nginx-svc -kv --resolve secure-ingress.com:80:34.105.246.174


# test tls certificate with ingress
curl https://secure-ingress.com:31047/service2 -kv --resolve secure-ingress.com:31047:34.105.246.174
curl https://https-example.foo.com:32707/service2 -kv --resolve https-example.foo.com:32707:172.31.38.113


# Exam Tips:
- You can implement TLS termination using an Ingress.
- Store TLS certificates using a Secret. Pass the Secret to the Ingress using spec.tls[].secretName . 
- Bookmark the Ingress - TLS documentation.

```
Note:
- https://kubernetes.io/docs/concepts/services-networking/ingress/#tls
- https://kubernetes.io/docs/tasks/administer-cluster/certificates/#openssl
- https://kubernetes.github.io/ingress-nginx/deploy/


### 4.2.8. Hands-on Lab: Add TLS to a Kubernetes Service with Ingress

```bash

openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -new -nodes -subj "/CN=accounts.svc"
k create secret tls accounts-tls-certs --key=key.pem --cert=cert.pem -n accounts

cat <<EOF>ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: tls-example-ingress
spec:
  tls:
  - hosts:
      - accounts.svc
    secretName: accounts-tls-certs
  rules:
  - host: accounts.svc
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: accounts-svc
            port:
              number: 80
EOF

k create -f ingress.yaml -n accounts

cloud_user@k8s-control:~$ kubectl describe ingress tls-example-ingress  -n accounts
Name:             tls-example-ingress
Namespace:        accounts
Address:
Default backend:  default-http-backend:80 (<error: endpoints "default-http-backend" not found>)
TLS:
  accounts-tls-certs terminates accounts.svc
Rules:
  Host          Path  Backends
  ----          ----  --------
  accounts.svc
                /   accounts-svc:80 (192.168.194.65:80)
Annotations:    <none>
Events:         <none>
cloud_user@k8s-control:~$

```

### 4.2.9. Securing Node Endpoints

```bash
# check kubernetes node port which might required to secure / disable using firewall 
some open ports -
6443 kube API server
2379-2380 etcd server client API
10250 kubelet API
10251 kube-scheduler
10252 kube-controller-manager
30000-32767	NodePort Services in worker node
```
Note:
- https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#check-required-ports

### 4.2.10. Securing GUI Elements (attack surface control)
```bash
kubernetes dashboard, insecure port - 9090
secure kubernetes dashboard by using TLS certificate 
```  

### 4.2.11. Verifying Kubernetes Platform Binaries
```bash
kubectl version --short --client
curl -LO "https://dl.k8s.io/v.1.20.1/bin/linux/amd64/kubectl.sha256"
echo "$(<kubectl.sha256) /usr/bin/kubectl" | sha256sum --check

VERSION=$(cat version.txt)
curl -LO "https://dl.k8s.io/$VERSION/bin/linux/amd64/kubectl.sha256"
echo "$(<kubectl.sha256) kubectl" | sha256sum --check

# Exam Tips:
When installing Kubernetes binaries manually, you can validate the binary files using the checksum to ensure the binaries have not been altered.

```
Note:
- https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux


### 4.2.12. Cluster Setup Review
```bash

```

## 4.3. Chapter 3: Kubernetes Cluster Hardening

### 4.3.1. Restricting Service Account Permissions
```bash

- Check SA permission - rolebinding, clusterrolebinding
- Check API Server port access with outisde world
- K8s update
- 

```
### 4.3.2. Hands-on Lab: Limit Service Account Permissions in Kubernetes
```bash
k create sa pod-monitor
k create role role-pod-monitor --verb=get,list --resource=pods,pods/log
k create rolebinding rb-pod-monitor --role=role-pod-monitor --serviceaccount=auth:pod-monitor
now modify pod spec and create ...

k create sa svc-monitor
k create role role-svc-monitor --verb=get,list --resource=services,endpoints
k create rolebinding rb-svc-monitor --role=role-svc-monitor --serviceaccount=auth:svc-monitor
now modify pod spec and create ...
```


## 4.4. Chapter 4: System Hardening

### 4.4.1. Understanding Host OS Security Concerns
```bash
- Host namespace
- Priviledge Mode : non-privileged cant access host-level resources
  - securityContext mode, default false  
- Host namespace
- Container namespace

# by default below entries are false
hostIPC: true
hostNetwork: true # for networking
hostPID: true

IAM Roles:
169.254.169.254 block 
```

### 4.4.2. Exploring AppArmor
```bash
Control Linux Security Kernel 

AppArmor Profile: set rule which define what a program can and cannot do.
Complain mode: give a report
Enforce mode: prevent if profile not allow

sudo apparmor_parser /etc/apparmor.d/deny-write       #enforce mode
sudo apparmor_parser -C /etc/apparmor.d/deny-write    #complain mode

pod will be blocked if apparmor profile is not exist in worker node. 

Now apply apparmor profile by annotation 

# Exam Tips:
- Use the apparmor_parser command to load an AppArmor profile from a file. It will load the profile in enforcing mode by default.
- Use Pod annotations to apply an AppArmor profile to a container. For example:
     container.apparmor.security.beta.kubernetes.io/nginx: localhost/k8s-deny-write

Profile Location: /etc/apparmor.d/

# list apparmor loaded module???
aa-status
aa-status
aa-genprof	#gnerate profile
aa-complain
aa-enforce
aa-logprof	#check log and add to profile for allow system call

# test pod config with apparmor profile
k run secure --image=nginx $do > secure.yaml
vim secure.yaml # add pod annotation key and value, 
container.apparmor.security.beta.kubernetes.io/<container_name>: localhost/<profile_name>
k -f secure.yaml create


Note: Check CKS Udemy Course @ Section 27: System Hardening - Kernel Hardening tools
```

### 4.4.3. Hands-on Lab: Protecting a Kubernetes Cluster with AppArmor
```bash
#check apparomo
sudo aa-status |grep k8s

#validate profile
sudo apparmor_parser apparmor-k8s-deny-write

#copy  in startup folder
sudo cp apparmor-k8s-deny-write /etc/apparmor.d
sudo chown root:root /etc/apparmor.d/apparmor-k8s-deny-write

# take current pod spec and add apparmor definition
k get pod password-db $y > pod-spe.yaml

annotations
metadata:
  annotations:
    container.apparmor.security.beta.kubernetes.io/password-db: localhost/k8s-deny-write

k logs password-db -n auth

```










## 4.5. Chapter 5: Minimizing Microservice Vulnerabilities

### 4.5.1. Minimizing Microservice Vulnerabilities Intro
```bash
- Security context
- PodSecurityPolicy
- OPA Gatekeeper
- Secrets
- Runtime Sandbox
- mTLS
- Certificate Manager
```
### 4.5.2. Managing Container Access with Security Contexts
```bash
# Exam Tips:

- securityContext offers a variety of security and access control-related settings.
- spec.securityContext sets securityContext settings at the Pod level. These settings apply to all containers in the Pod.
- spec.containers[].securityContext sets securityContext settings at the container level. These settings apply to individual containers within the Pod.

cat <<EOF>>security-context-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: security-context-pod
spec:
  securityContext:
    runAsUser: 1000
  containers:
  - name: busybox
    image: busybox
    command: [ "sh", "-c", "sleep 3600" ]
    securityContext:
      allowPrivilegeEscalation: false
EOF
k create -f security-context-pod.yml

```
Note:
- https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
- https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#security-context
- https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#security-context-1

### 4.5.3. Using Pod Security Policies
```bash
# Exam Tips:
- To use Pod security policies, you must first enable the PodSecurityPolicy admission controller. Use the --enable-admission-plugins flag on kube-apiserver to do this.
- In order to create a Pod, a user (or the Pod's ServiceAccount) must be authorized to use a PodSecurityPolicy via the use verb in RBAC.
- To apply a PodSecurityPolicy within the context of a specific namespace, authorize a ServiceAccount in that namespace to use the policy.

# enable admission control using psp
 sudo vi /etc/kubernetes/manifests/kube-apiserver.yaml
  - --enable-admission-plugins=NodeRestriction,PodSecurityPolicy

# create pod security policy to use in pod.spec, otherwise pod creation will fail
cat <<EOF>>psp-nonpriv.yml
apiVersion: policy/v1beta1
kind: PodSecurityPolicy
metadata:
  name: psp-nonpriv
spec:
  privileged: false
  runAsUser:
    rule: RunAsAny
  fsGroup:
    rule: RunAsAny
  seLinux:
    rule: RunAsAny
  supplementalGroups:
    rule: RunAsAny
  volumes:
  - configMap
  - downwardAPI
  - emptyDir
  - persistentVolumeClaim
  - secret
  - projected
EOF


kubectl create namespace psp-test
kubectl create serviceaccount psp-test-sa -n psp-test
k create -f psp-nonpriv.yml -n psp-test

# PSP page has example by imperative command
# create ns, sa,
kubectl create namespace psp-example
kubectl create serviceaccount -n psp-example fake-user
kubectl create rolebinding -n psp-example fake-editor --clusterrole=edit --serviceaccount=psp-example:fake-user
# check whether psp is authorized for fake-user
kubectl-user auth can-i use podsecuritypolicy/example

# impreative command for creating role 
k create role psp:unprivileged --verb=use --resource=podsecuritypolicy --resource-name=example $do
# role binding
k create rolebinding fake-user:psp:unprivileged --role=psp:unprivileged --serviceaccount=psp-example:fake-user $do
# now create pod with security context policy

k run pod-psp-test --image=nginx -n psp-test $do > pod-psp-test.yml
k create -f pod-psp-test.yml

# modify spec and run pod as a created sa
spec:
  serviceAccountName: psp-test-sa

run again  

cat <<EOF>>pod-psp-test-priv.yml
apiVersion: v1
kind: Pod
metadata:
  name: pod-psp-test-priv
  namespace: psp-test
spec:
  serviceAccountName: psp-test-sa
  containers:
  - name: nginx
    image: nginx:1.14.2
    securityContext:
      privileged: true
EOF

kubectl create -f pod-psp-test-priv.yml

```

### 4.5.4. Hans-on LAB: PodSecurityPolicy
```bash
enable PodSecurityPolicy in api server 
 sudo vi /etc/kubernetes/manifests/kube-apiserver.yaml
  - --enable-admission-plugins=NodeRestriction,PodSecurityPolicy

k run pod --image=buybox -- /bin/sh -c "sleep 3600"

# now create a pod security policy

cat <<EOF>>non-psp.yaml
apiVersion: policy/v1beta1
kind: PodSecurityPolicy
metadata:
  name: psp-no-privileged
spec:
  privileged: false  # Don't allow privileged pods!
  # The rest fills in some required fields.
  seLinux:
    rule: RunAsAny
  supplementalGroups:
    rule: RunAsAny
  runAsUser:
    rule: RunAsAny
  fsGroup:
    rule: RunAsAny
  volumes:
  - '*'
EOF

kcc
kn auth
k create -f non-psp.yaml -n auth
k get podsecuritypolicies.policy

k create clusterrole cluster-role-no-psp --verb=use --resource=podsecuritypolicies --resource-name=psp-no-privileged $do
k create clusterrolebinding cl-role-binding-no-psp --clusterrole=cluster-role-no-psp --serviceaccount=auth:auth-sa $do
k auth  can-i use podsecuritypolicies
# now we can schedule pod
k run abc --image=nginx

# try to check priviledged pod status
k run pri-pod --image=nginx $do >pri-pod.yaml
# now add privileged options in pod spec
    securityContext:
      privileged: true
k create -f pri-pod.yaml

cloud_user@k8s-control:~$ cat pri-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: pri-pod
  name: pri-pod
spec:
  containers:
  - image: nginx
    name: pri-pod
    resources: {}
    securityContext:
      privileged: true
  dnsPolicy: ClusterFirst
  restartPolicy: Always

```
### 4.5.5. Using OPA Gatekeeper
```bash
OPA Gatekeeper
contact label 
constraint template <> schema <> rego logic 
rego language
need to define: constraint template and its equivalent K8sRequiredLabels

# Exam Tips:
- Open Policy Agent (OPA) Gatekeeper allows you to enforce custom policies on any k8s object at creation time. 
- Constraint templates define reusable constraint logic and any parameters that can be passed in.
- Constraint objects apply a constraint template to a specific group of potential incoming objects, alongside specific parameters.

# Install OPA Gatekeeper:
kubectl apply -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/release-3.3/deploy/gatekeeper.yaml
kubectl get pods -n gatekeeper-system -w

# this is available in kubernetes.io blog post
cat <<EOF>>k8srequiredlabels.yml
apiVersion: templates.gatekeeper.sh/v1beta1
kind: ConstraintTemplate
metadata:
  name: k8srequiredlabels
spec:
crd: spec:
      names:
        kind: K8sRequiredLabels
validation:
        # Schema for the `parameters` field
        openAPIV3Schema:
          properties:
            labels:
              type: array
              items: string
targets:
- target: admission.k8s.gatekeeper.sh rego: |
        package k8srequiredlabels
violation[{"msg": msg, "details": {"missing_labels": missing}}] { provided := {label | input.review.object.metadata.labels[label]} required := {label | label := input.parameters.labels[_]} missing := required - provided
count(missing) > 0
          msg := sprintf("you must provide labels: %v", [missing])
        }
EOF
kubectl create -f k8srequiredlabels.yml

# this also available in kubernetes.io blog post
cat <<EOF>>dep-must-have-contact.yml 
apiVersion: constraints.gatekeeper.sh/v1beta1
kind: K8sRequiredLabels
metadata:
  name: dep-must-have-contact
spec:
  match:
    kinds:
    - apiGroups: ["apps"]
      kinds: ["Deployment"]
  parameters:
    labels: ["contact"]
EOF

kubectl create -f dep-must-have-contact.yml    

# deployment will fail if there is no label called contact
k create deployment dep-nginx --image=nginx

# now add label contact=dep-label and create deploy
k create deployment dep-nginx --image=nginx > opa-deploy.yaml
k create -f opa-deploy.yaml
```
Note: 
- https://kubernetes.io/blog/2019/08/06/opa-gatekeeper-policy-and-governance-for-kubernetes/
- https://github.com/open-policy-agent/gatekeeper


### 4.5.6. Managing Kubernetes Secrets
```bash
# Exam Tips:
- Secrets store sensitive data, and can pass it to containers.
- You can pass Secret data to a container using either environment variables or mounted volumes.
- To retrieve Secret data from the command line, you can use kubectl get -o yaml to get the Base64-encoded data, then decode it with base64 --decode 

echo admin | base64 | base64 --decode

# get secret value from running pod
kubectl get secret my-secret -o yaml
echo Y2FudGZpbmRtZQo= | base64 --decode

```

### 4.5.7. Hand-on Lab Secret
```bash
k get secrets db-pass $y
echo aHVudGVyMgo=|base64 -d

cloud_user@k8s-control:~$ echo TrustNo1 | base64
VHJ1c3RObzEK

k edit secrets db-pass 
```

### 4.5.8. Understanding Container Runtime Sandboxes
```bash
gVisor / runsc

kata container (light weight virtual machine)

# install gVisor
curl -fsSL https://gvisor.dev/archive.key | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64,arm64] https://storage.googleapis.com/gvisor/releases release main"
sudo apt-get update && sudo apt-get install -y runsc

# create runsc config
sudo vi /etc/containerd/config.toml

Find the disabled_plugins section and add the restart plugin.
 disabled_plugins = ["io.containerd.internal.v1.restart"]

Find the block [plugins."io.containerd.grpc.v1.cri".containerd.runtimes] . After the existing runc block, add configuration for a runsc runtime. It should look like this when done:

[plugins."io.containerd.grpc.v1.cri".containerd.runtimes]
  [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
    runtime_type = "io.containerd.runc.v1"
    runtime_engine = ""
    runtime_root = ""
    privileged_without_host_devices = false
  [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runsc]
    runtime_type = "io.containerd.runsc.v1"

Locate the block and set   to true .
[plugins."io.containerd.runtime.v1.linux"] ...
  shim_debug = true

sudo systemctl restart containerd
sudo systemctl status containerd



cat <<EOF>>runtimesc.yaml
apiVersion: node.k8s.io/v1  # RuntimeClass is defined in the node.k8s.io API group
kind: RuntimeClass
metadata:
  name: myclass  # The name the RuntimeClass will be referenced by
  # RuntimeClass is a non-namespaced resource
handler: runsc  # The name of the corresponding CRI configuration
EOF
k create -f runtimesc.yaml

apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  runtimeClassName: myclass


# check logs and compare
kubectl exec non-sandbox-pod -- dmesg 
kubectl exec sandbox-pod -- dmesg

```
Note:
- https://gvisor.dev/docs/
- https://katacontainers.io/docs/
- https://kubernetes.io/docs/concepts/containers/runtime-class/


### 4.5.9. Hands-on Lab: Moving Kubernetes Pods to a Secured Runtime Sandbox
```bash
# same procedure as Understanding Container Runtime Sandboxes
```
### 4.5.10. mTLS and Signing Certificates
```bash
# Exam tips:
- Create a CertificateSigningRequest object to request a new certificate.
- Manage, approve, or deny requests via the command line with kubectl certificate .
- Once approved, the signed certificate can be retrieved from the status.certificate field of the CertificateSigningRequest.

# install tool
sudo apt-get install -y golang-cfssl

cat <<EOF | cfssl genkey - | cfssljson -bare server
{
  "hosts": [
    "my-svc.my-namespace.svc.cluster.local",
    "my-pod.my-namespace.pod.cluster.local",
    "192.0.2.24",
    "10.0.34.2"
  ],
  "CN": "system:node:my-pod.my-namespace.pod.cluster.local",
  "key": {
    "algo": "ecdsa",
    "size": 256
  },
  "names": [
    {
      "O": "system:nodes"
    }
  ]
}
EOF

cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: my-svc.my-namespace
spec:
  request: $(cat server.csr | base64 | tr -d '\n')
  signerName: kubernetes.io/kubelet-serving
  usages:
  - digital signature
  - key encipherment
  - server auth
EOF

k describe csr my-svc.my-namespace

k get csr
k certificate approve tls-svc-csr

k get csr my-svc.my-namespace -o jsonpath='{.status.certificate}' | base64 --decode > server.crt

```
Note:
- https://kubernetes.io/docs/tasks/tls/managing-tls-in-a-cluster/

### 4.5.11. Minimizing Microservice Vulnerabilities Review
```bash

``` 

## 4.6. Chapter 6: Supply Chain Security

### 4.6.1. Supply Chain Security Intro
```bash
- Check image (trusted source)
- Whitelisting Register
- Signing image validation
- Static analysis for Docker and yaml files
- Vulnerability Scanning
- Vulnerability Scanning with an Admission Controller
```

### 4.6.2. Whitelisting Allowed Image Registries
```bash
# whitelisting by OPA Gatekeeper
- Limit users to only trusted image registries to prevent them from running images from untrusted sources in the cluster. 
- You can limit registries using OPA Gatekeeper.

#template
cat <<EOF>>k8sallowedrepos.yml

apiVersion: templates.gatekeeper.sh/v1beta1
kind: ConstraintTemplate
metadata:
  name: k8sallowedrepos
spec:
  crd:
    spec:
      names:
        kind: K8sAllowedRepos
      validation:
        # Schema for the `parameters` field
        openAPIV3Schema:
          properties:
            repos:
              type: array
              items:
                type: string
  targets:
    - target: admission.k8s.gatekeeper.sh
      rego: |
        package k8sallowedrepos
        violation[{"msg": msg}] {
          container := input.review.object.spec.containers[_]
          satisfied := [good | repo = input.parameters.repos[_] ; good = startswith(container.image, repo)]
          not any(satisfied)
          msg := sprintf("container <%v> has an invalid image repo <%v>, allowed repos are %v", [container.name, container.image, input.parameters.repos])
        }
        violation[{"msg": msg}] {
          container := input.review.object.spec.initContainers[_]
          satisfied := [good | repo = input.parameters.repos[_] ; good = startswith(container.image, repo)]
          not any(satisfied)
          msg := sprintf("container <%v> has an invalid image repo <%v>, allowed repos are %v", [container.name, container.image, input.parameters.repos])
        }
EOF

kubectl create -f k8sallowedrepos.yml

#constraint
cat <<EOF>>whitelist-dockerhub.yml
apiVersion: constraints.gatekeeper.sh/v1beta1
kind: K8sAllowedRepos
metadata:
  name: whitelist-dockerhub
spec:
  match:
    kinds:
    - apiGroups: [""]
      kinds: ["Pod"]
  parameters:
    repos:
    - "docker.io"
EOF    
kubectl create -f whitelist-dockerhub.yml

docker.io/library/busybox
gcr.io/google-containers/busybox

k run test --image=docker.io/library/busybox -- /bin/sh -c "sleep 3600"
k run test --image=gcr.io/google-containers/busybox -- /bin/sh -c "sleep 3600"

kubectl delete K8sAllowedRepos whitelist-dockerhub
```

### 4.6.3. Validating Signed Images
```bash
Format: image:tag@sha256:hash

k run sign-image --image=busybox:1.33.1@sha256:9687821b96b24fa15fac11d936c3a633ce1506d5471ebef02c349d85bebb11b5 -- /bin/sh -c "sleep 3600"

cat <<EOF>>signed-image-pod.yml
apiVersion: v1
kind: Pod
metadata:
  name: signed-image-pod
spec:
  restartPolicy: Never
  containers:
  - name: busybox
    image: busybox:1.33.1@sha256:9687821b96b24fa15fac11d936c3a633ce1506d5471ebef02c349d85bebb11b5
    command: ['sh', '-c', 'echo "Hello, world!"']
EOF

k create -f signed-image-pod.yml
```

### 4.6.4. Analyzing a Dockerfile
```bash
# Exam tips:
- To avoid running the container as the root user, make sure that the final USER directive in the Dockerfile is not set to root or 0 .
- Avoid using the :latest tag in the FROM directive.
- Try to avoid including unnecessary software in the final image.
- Avoid storing sensitive data such as passwords in the Dockerfile (for example, using the ENV directive). Use Kubernetes Secrets instead.
```

### 4.6.5. Analyzing Resource YAML Files
```bash
# Exam Tips
- When possible, avoid the use of host namespaces in your Pod configurations ( i.e., with hostNetwork: true , , or   ).
- When possible, avoid using privileged containers with   .
- Avoid running as user root or 0 in securityContext.runAsUser.
- Don't use the   tag, but instead use a specific, fixed tag to avoid downloading a new and potentially unvetted image.
```

### 4.6.6. Scanning Images for Known Vulnerabilities
```bash
# Exam Tips:
- Vulnerability scanning allows you to scan images to detect security vulnerabilities that have already been discovered and documented by security researchers.
- Trivy is a command-line tool that allows you to scan images by name and tag.
- Scan an image name and tag with Trivy like so: trivy image busybox:1.33.1
- In some cases, you may need to omit image like so: trivy nginx:1.14.1

# Installation trivy
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add - 
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update && sudo apt-get install -y trivy

trivy image nginx:1.14.1
```
Note:
- https://aquasecurity.github.io/trivy/v0.18.3/

### 4.6.7. Scanning Images with an Admission Controller
```bash
- ImagePolicyWebhook

# Exam Tips
- The ImagePolicyWebhook admission controller sends a JSON request to an external service to determine if images are allowed.
- The external service provides a JSON response indicating whether the images are allowed or disallowed.

- Use --enable-admission-plugins in the kube-apiserver manifest to enable the ImagePolicyWebhook admission controller.
- Use --admission-control-config-file to specify the location of the admission control configuration file.
- If the config files are on the host file system, you may need to mount them to the kube-apiserver container.
- In the admission control config, kubeConfigFile specifies the location of a kubeconfig file. This file tells ImagePolicyWebhook how to reach the webhook backend.
- In the admission control config, defaultAllow controls whether or not workloads will be allowed if the backend webhook in unreachable.


# Installation


cat <<EOF>>/etc/kubernetes/admission-control/admission-control.conf
apiVersion: apiserver.config.k8s.io/v1
kind: AdmissionConfiguration
plugins:
- name: ImagePolicyWebhook
  configuration:
    imagePolicy:
      kubeConfigFile: /etc/kubernetes/admission-control/imagepolicy_backend.kubeconfig
      allowTTL: 50
      denyTTL: 50
      retryBackoff: 500
      defaultAllow: false
EOF

sudo vi /etc/kubernetes/admission-control/imagepolicy_backend.kubeconfig
server: https://acg.trivy.k8s.webhook:8090/scan

cloud_user@k8s-control:~$ cat /etc/kubernetes/admission-control/imagepolicy_backend.kubeconfig
apiVersion: v1
kind: Config
clusters:
- name: trivy-k8s-webhook
  cluster:
    certificate-authority: /etc/kubernetes/admission-control/imagepolicywebhook-ca.crt
    server: ""
contexts:
- name: trivy-k8s-webhook
  context:
    cluster: trivy-k8s-webhook
    user: api-server
current-context: trivy-k8s-webhook
preferences: {}
users:
- name: api-server
  user:
    client-certificate: /etc/kubernetes/admission-control/api-server-client.crt
    client-key: /etc/kubernetes/admission-control/api-server-client.key
cloud_user@k8s-control:~$


# enable webhook in api server
sudo vi /etc/kubernetes/manifests/kube-apiserver.yaml
--enable-admission-plugins=NodeRestriction,ImagePolicyWebhook

kubectl create -f good-pod.yml
kubectl create -f bad-pod.yml


```
Note:
- https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#imagepolicywebhook
- 

### 4.6.8. Supply Chain Security Review
```bash

```











## 4.7. Chapter 7: Monitoring, Logging and Runtime Security

### 4.7.1. Monitoring, Logging, and Runtime Security Intro
```bash

```
### 4.7.2. Understanding Behavioral Analytics and Analyzing Container Behavior with Falco
```bash
Behavioral Analysis
Falco (sysdig): constantly examine - file access, Privilege Escalation, Binaries check 

# installation
curl -s https://falco.org/repo/falcosecurity-3672BA8F.asc | sudo apt-key add - 
echo "deb https://download.falco.org/packages/deb stable main" | sudo tee -a /etc/apt/sources.list.d/falcosecurity.list 
sudo apt-get update
sudo apt-get install -y falco

falco -r <rule-file> -M 45
falco --list
falco --help

cat <<EOF>>falco-test-pod.yml    
apiVersion: v1
kind: Pod
metadata:
  name: falco-test-pod
spec:
  nodeName: k8s-worker1
  containers:
  - name: falco-test
    image: busybox:1.33.1
    command: ['sh', '-c', 'while true; do cat /etc/shadow; sleep 5; done']
EOF

kubectl create -f falco-test-pod.yml    

cat <<EOF>>falco-rules.yml
- rule: spawned_process_in_test_container
desc: A process was spawned in the test container.
condition: container.name = "falco-test" and evt.type = execve
output: "%evt.time,%user.uid,%proc.name,%container.id,%container.name" priority: WARNING
EOF

sudo falco -r falco-rules.yml -M 45

```
Note: 
- https://falco.org/docs/
- https://docs.sysdig.com/?lang=en
- https://falco.org/docs/alerts/formatting/


### 4.7.3. Hands-on Lab: Threat Detection in Kubernetes with Falco
```bash

cat <<EOF>>nginx-rules.yml
# my rule for nginx
- rule: nginx_rule
  desc: nginx report
  condition: container.name="nginx" and evt.type = execve
  output: "%evt.type, %evt.time, %proc.pid, %proc.name, %container.id, %container.image, %container.name, %user.uid, %user.name"
  priority: WARNING
EOF

# generate report
sudo falco -r nginx-rules.yml -M 45 > /home/cloud_user/falco-report.log


# Some example rule
- rule: shell_in_container
  desc: notice shell activity within a container
  condition: container.id != host and proc.name = bash
  output: shell in a container (user=%user.name container_id=%container.id container_name=%container.name shell=%proc.name parent=%proc.pname cmdline=%proc.cmdline)
  priority: WARNING

- rule: spawned_process_in_nginx_container
  desc: A process was spawned in the Nginx container.
  condition: container.name = "nginx" and evt.type = execve
  output: "%evt.time,%proc.name,%user.uid,%container.id,%container.name,%container.image"
  priority: WARNING

```


### 4.7.4. Ensuring Containers are Immutable
```bash
- Immutability means that containers do not change at runtime (e.g., by downloading and running new code). 
- Containers that use privileged mode (i.e. securityContext.privileged: true) may also be considered mutable. 
- Use container.securityContext.readOnlyRootFilesystem to prevent a container from writing to its file system. 
- If an application needs to write to files, such as for caching or logging, you can use an emptyDir volume alongside
readOnlyRootFilesystem .

```

### 4.7.5. Hands-on Lab: Check Kubernetes Pods for Container Immutability
```bash
cloud_user@k8s-control:~$ k get pod -n dev
NAME           READY   STATUS    RESTARTS   AGE
auth-rest      1/1     Running   0          15m
user-svc       1/1     Running   0          15m
web-frontend   1/1     Running   0          15m

k get pod user-svc -n dev $y |egrep -i "root|run|pri"

# now remove web-frontend and user-svc
k delete pod -n dev web-frontend --force
k delete pod -n dev user-svc --force

```

### 4.7.6. Understanding Audit Logs
```bash
# Audit log type
- None
- Metadata
- Request
- RequestResponse


 sudo vi /etc/kubernetes/audit-policy.yaml

```
Note:
- https://kubernetes.io/docs/tasks/debug-application-cluster/audit/
- https://kubernetes.io/docs/reference/config-api/apiserver-audit.v1/#audit-k8s-io-v1-Policy
- 



### 4.7.7. Hans-on Lab: Configure Audit Logging in Kubernetes
```bash
# example taken from k8s.io website
cat <<EOF>>/etc/kubernetes/audit-policy.yaml
apiVersion: audit.k8s.io/v1 # This is required.
kind: Policy
# Don't generate audit events for all requests in RequestReceived stage.
omitStages:
  - "RequestReceived"
rules:
  # Log pod changes at RequestResponse level
  - level: RequestResponse
    resources:
    - group: ""
      # Resource "pods" doesn't match requests to any subresource of pods,
      # which is consistent with the RBAC policy.
      resources: ["namespaces"]
  - level: Request
    resources:
    - group: ""
      # Resource "pods" doesn't match requests to any subresource of pods,
      # which is consistent with the RBAC policy.
      resources: ["pods","services"]      
    namespaces: ["web"]
  # Log configmap and secret changes in all other namespaces at the Metadata level.
  - level: Metadata
    resources:
    - group: "" # core API group
      resources: ["secrets"]
  # A catch-all rule to log all other requests at the Metadata level.
  - level: Metadata
    # Long-running requests like watches that fall under this rule will not
    # generate an audit event in RequestReceived.
    omitStages:
      - "RequestReceived"
EOF

apiVersion: audit.k8s.io/v1
kind: Policy
rules:
# Log request and response bodies for all changes to Namespaces.
- level: RequestResponse
  resources:
  - group: ""
    resources: ["namespaces"]
# Log request bodies (but not response bodies) for changes to Pods and Services in the web Namespace.
- level: Request
  resources:
  - group: ""
    resources: ["pods", "services"]
  namespaces: ["web"]
# Log metadata for all changes to Secrets.
- level: Metadata
  resources:
  - group: ""
    resources: ["secrets"]
# Create a catchall rule to log metadata for all other requests.
- level: Metadata      


sudo vim /etc/kubernetes/manifests/kube-apiserver.yaml
    - --audit-log-path=/var/log/kubernetes/k8s-audit.log
    - --audit-log-maxbackup=1
    - --audit-log-maxage=60
    - --audit-policy-file=/etc/kubernetes/audit-policy.yaml

# check mount point for the new log file
```






## 4.8. Chapter 8: Practice Exam

### 4.8.1. Certified Kubernetes Security Specialist (CKS) - Practice Exam Part 1
```bash

# task1 (roles , rolebindings)

#check 
k describe rolebinding -n sunnydale buffy-rb

# modify pod role from * to list for pods
k edit role buffy-role

k create role watch-services-secrets --verb=watch --resource=services,secrets
k create rolebinding buffy-sa-watch-rb --role=watch-services-secrets --serviceaccount=sunnydale:buffy-sa 

# task2
k delete sa lando
k create sa lando-sa
#modify sa account in pod definition and create it
k create -f lando.yml
```

### 4.8.2. Certified Kubernetes Security Specialist (CKS) - Practice Exam Part 2
```bash

# task1
sudo vim /var/lib/kubelet/config.yaml

cloud_user@k8s-control:/etc/kubernetes/manifests$ sudo cat /var/lib/kubelet/config.yaml
apiVersion: kubelet.config.k8s.io/v1beta1
authentication:
  anonymous:
    enabled: false
  webhook:
    cacheTTL: 0s
    enabled: true
  x509:
    clientCAFile: /etc/kubernetes/pki/ca.crt
authorization:
  mode: Webhook
  webhook:
    cacheAuthorizedTTL: 0s
...
sudo systemctl restart kubelet
sudo systemctl status kubelet

# task2
sudo vi /etc/kubernetes/manifests/kube-apiserver.yaml
    - --profiling=false
    - --authorization-mode=Node,RBAC    

kubectl get nodes

# task3
sudo mv /etc/kubernetes/manifests/etcd.yaml  /etc/kubernetes/
sudo vi /etc/kubernetes/etcd.yaml
  - --client-cert-auth=true
sudo mv /etc/kubernetes/etcd.yaml  /etc/kubernetes/manifests/

kubectl get pods -n kube-system
```

### 4.8.3. Certified Kubernetes Security Specialist (CKS) - Practice Exam Part 3
```bash
cat <<EOF>> de.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-ingress
spec:
  podSelector: {}
  policyTypes:
  - Ingress
EOF

k get pod mtdoom -n mordor $l
k get namespace frodo $l

cat <<EOF>>np.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: mtdoom-np
  namespace: mordor
spec:
  podSelector:
    matchLabels:
      app: mtdoom
  policyTypes:
  - Ingress
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          app: frodo
    - podSelector:
        matchLabels:
          app: sam
    ports:
    - protocol: TCP
      port: 80
EOF

k create -f np.yaml


cloud_user@k8s-cli:~$ k describe netpol
Name:         default-deny-ingress
Namespace:    mordor
Created on:   2021-07-07 03:40:56 +0000 UTC
Labels:       <none>
Annotations:  <none>
Spec:
  PodSelector:     <none> (Allowing the specific traffic to all pods in this namespace)
  Allowing ingress traffic:
    <none> (Selected pods are isolated for ingress connectivity)
  Not affecting egress traffic
  Policy Types: Ingress


Name:         mtdoom-np
Namespace:    mordor
Created on:   2021-07-07 03:48:32 +0000 UTC
Labels:       <none>
Annotations:  <none>
Spec:
  PodSelector:     app=mtdoom
  Allowing ingress traffic:
    To Port: 80/TCP
    From:
      NamespaceSelector: app=frodo
    From:
      PodSelector: app=sam
  Not affecting egress traffic
  Policy Types: Ingress
cloud_user@k8s-cli:~$

```

### 4.8.4. Certified Kubernetes Security Specialist (CKS) - Practice Exam Part 4
```bash
root@k8s-control:~# cat /etc/kubernetes/admission-control/admission-control.conf
apiVersion: apiserver.config.k8s.io/v1
kind: AdmissionConfiguration
plugins:
- name: ImagePolicyWebhook
  path: imagepolicy.conf
root@k8s-control:~#

root@k8s-control:~# cat /etc/kubernetes/admission-control/imagepolicy.conf
{
   "imagePolicy": {
      "kubeConfigFile": "/etc/kubernetes/admission-control/imagepolicy_backend.kubeconfig",
      "allowTTL": 50,
      "denyTTL": 50,
      "retryBackoff": 500,
      "defaultAllow": true
   }
}
root@k8s-control:~#

# set as false 
# "defaultAllow": false


root@k8s-control:~# cat /etc/kubernetes/admission-control/imagepolicy_backend.kubeconfig
apiVersion: v1
kind: Config
clusters:
- name: trivy-k8s-webhook
  cluster:
    certificate-authority: /etc/kubernetes/admission-control/imagepolicywebhook-ca.crt
    server: ""
contexts:
- name: trivy-k8s-webhook
  context:
    cluster: trivy-k8s-webhook
    user: api-server
current-context: trivy-k8s-webhook
preferences: {}
users:
- name: api-server
  user:
    client-certificate: /etc/kubernetes/admission-control/api-server-client.crt
    client-key: /etc/kubernetes/admission-control/api-server-client.key
root@k8s-control:~#

# add below line in above file 
# server: https://acg.trivy.k8s.webhook:8090/scan


# ImagePolicyWebhook
# vim /etc/kubernetes/manifests/kube-apiserver.yaml
    - kube-apiserver
    - --admission-control-config-file=/etc/kubernetes/admission-control/admission-control.conf
    - --advertise-address=10.0.1.101
    - --allow-privileged=true
    - --authorization-mode=Node,RBAC
    - --client-ca-file=/etc/kubernetes/pki/ca.crt
    - --enable-admission-plugins=NodeRestriction,ImagePolicyWebhook


# kube-apiserver --enable-admission-plugins=NamespaceLifecycle,LimitRanger ...


cloud_user@k8s-cli:~$ k create -f vulns-pod.yml
Error from server (Forbidden): error when creating "vulns-pod.yml": pods "vulns-pod" is forbidden: image policy webhook backend denied one or more images: Image(s) contain serious vulnerabilities: [nginx:1.14.2]
cloud_user@k8s-cli:~$


```

### 4.8.5. Certified Kubernetes Security Specialist (CKS) - Practice Exam Part 5
```bash
# try to get image name
# from k8s cheatsheet, below command is a short cut command
k get pods -n sunnydale --output=custom-columns="NAME:.metadata.name,IMAGE:.spec.containers[*].image"

cloud_user@k8s-control:~$ k get -n sunnydale pod $y |grep -i image: |grep -v ":image"
      image: busybox:1.33.1
      image: docker.io/library/busybox:1.33.1
    - image: nginx:1.14.2
      image: docker.io/library/nginx:1.14.2
      image: amazonlinux:2
      image: docker.io/library/amazonlinux:2
      image: amazonlinux:1
      image: docker.io/library/amazonlinux:1
      image: centos:7
      image: docker.io/library/centos:7
cloud_user@k8s-control:~$


cloud_user@k8s-control:~$ trivy amazonlinux:1
2021-07-07T12:55:34.246Z        INFO    Detected OS: amazon
2021-07-07T12:55:34.253Z        INFO    Detecting Amazon Linux vulnerabilities...
2021-07-07T12:55:34.265Z        INFO    Number of PL dependency files: 0

amazonlinux:1 (amazon AMI release 2018.03)
==========================================
Total: 0 (UNKNOWN: 0, LOW: 0, MEDIUM: 0, HIGH: 0, CRITICAL: 0)

cloud_user@k8s-control:~$


trivy image amazonlinux:1|egrep -i "high|critical"
trivy image nginx:1.14.2|egrep -i "high|critical"

# delete pods which has lot vul report
k delete -n sunnydale pod xander --force
k delete -n sunnydale pod cordelia --force

cloud_user@k8s-control:~$ k get pods -n sunnydale --output=custom-columns="NAME:.metadata.name,IMAGE:.spec.containers[*].image"
NAME     IMAGE
buffy    busybox:1.33.1
giles    amazonlinux:2
willow   amazonlinux:1
cloud_user@k8s-control:~$
```

### 4.8.6. Certified Kubernetes Security Specialist (CKS) - Practice Exam Part 6
```bash

root@k8s-worker1:/home/cloud_user# cat k8s-deny-write
#include <tunables/global>
profile k8s-deny-write flags=(attach_disconnected) {
  #include <abstractions/base>
  file,
  # Deny all file writes.
  deny /** w,
}
root@k8s-worker1:/home/cloud_user# 

# compile profile and check status
root@k8s-worker1:/home/cloud_user# apparmor_parser k8s-deny-write
root@k8s-worker1:/home/cloud_user# aa-status |grep k8s
   k8s-deny-write
root@k8s-worker1:/home/cloud_user#

cloud_user@k8s-cli:~$ cat chewbacca.yml
apiVersion: v1
kind: Pod
metadata:
  name: chewbacca
  namespace: kashyyyk
  annotations:
    container.apparmor.security.beta.kubernetes.io/busybox: localhost/k8s-deny-write
spec:
  containers:
  - name: busybox
    image: busybox:1.33.1
    command: ['sh', '-c', 'while true; do echo hunter2 > password.txt; sleep 5; done']
cloud_user@k8s-cli:~$

k create -f chewbacca.yml

cloud_user@k8s-cli:~$ k logs  -n kashyyyk chewbacca
sh: can't create password.txt: Permission denied
sh: can't create password.txt: Permission denied
```

### 4.8.7. Certified Kubernetes Security Specialist (CKS) - Practice Exam Part 7
```bash

cloud_user@k8s-worker1:~$ cat monitor_rules.yml
- rule: spawn_process_list
  desc: spawn process list
  condition: container.name = "monitor" and evt.type=execve
  output: "%evt.time, %container.id, %container.image, %user.uid, %proc.name"
  priority: NOTICE
cloud_user@k8s-worker1:~$

sudo falco -r monitor_rules.yml -M 45 > falco_output.log
```

### 4.8.8. Certified Kubernetes Security Specialist (CKS) - Practice Exam Part 8
```bash

root@k8s-control:~# cat /etc/kubernetes/audit-policy.yaml
apiVersion: audit.k8s.io/v1
kind: Policy
omitStages:
  - "RequestReceived"
rules:
  - level: None
    resources:
    - group: ""
      resources: ["pods/log", "pods/status"]
  - level: RequestResponse
    resources:
    - group: ""
      resources: ["configmaps"]
  - level: Request
    resources:
    - group: "" # core API group
      resources: ["services","pods"]
    namespaces: ["web"]
  - level: Metadata
    resources:
    - group: "" # core API group
      resources: ["secrets"]
  - level: Metadata

root@k8s-control:~# 

sudo vi /etc/kubernetes/manifests/kube-apiserver.yaml
- command:
  - kube-apiserver
  - --audit-policy-file=/etc/kubernetes/audit-policy.yaml
  - --audit-log-path=/var/log/kubernetes/audit.log
  - --audit-log-maxage=10
  - --audit-log-maxbackup=1

```

### 4.8.9. Certified Kubernetes Security Specialist (CKS) - Practice Exam Part 9
```bash
k g
k get secrets curly $y
echo YWRtaW4K|base64 -d > username.tx
echo MTIzNDUK |base64 -d > password.txt

k create secret generic moe --from-literal=username=dbuser --from-literal=password=A83MaeKoz

k run secret-pod $do  --image=busybox -- /bin/sh -c "sleep 3600" > po.yaml
# add secret related config 
k create -f po.yaml
k exec -it secret-pod -- df -h
k exec -it secret-pod -- cat /etc/credentials/password

A83MaeKozcloud_user@k8s-cli:~$ cat po.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: secret-pod
  name: secret-pod
spec:
  containers:
  - args:
    - /bin/sh
    - -c
    - sleep 3600
    image: busybox
    name: secret-pod
    resources: {}
    volumeMounts:
    - name: foo
      mountPath: "/etc/credentials"
      readOnly: true
  volumes:
  - name: foo
    secret:
      secretName: moe
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
cloud_user@k8s-cli:~$
```

### 4.8.10. Certified Kubernetes Security Specialist (CKS) - Practice Exam Part 10
```bash

k get pod $y|egrep -i "root|priv|runAsUser|name: "|grep -v "{"

kubectl delete pod -n sunnydale --force buffy
kubectl delete pod -n sunnydale --force xander
```

### 4.8.11. Certified Kubernetes Security Specialist (CKS) - Practice Exam Part 11
```bash
cloud_user@k8s-cli:~$ cat sandbox.yml
apiVersion: node.k8s.io/v1
kind: RuntimeClass
metadata:
  name: mysc
handler: runsc
cloud_user@k8s-cli:~$

k create -f sandbox.yml

k get deployments.apps buffy $y > 11.yaml
k delete -f 11.yaml --force
# add runtimeClassName
vim 1.yaml
k create -f 1.yaml
k exec buffy-64869b44d7-n8vf5 -- dmesg

```

### 4.8.12. Certified Kubernetes Security Specialist (CKS) - Practice Exam Part 12
```bash
cat <<EOF>>psp.yaml
apiVersion: policy/v1beta1
kind: PodSecurityPolicy
metadata:
  name: nopriv-psp
spec:
  privileged: false  # Don't allow privileged pods!
  seLinux:
    rule: RunAsAny
  supplementalGroups:
    rule: RunAsAny
  runAsUser:
    rule: RunAsAny
  fsGroup:
    rule: RunAsAny
  volumes:
  - '*'
EOF  

k create -f  psp.yaml

kn hoth
k create sa hoth-sa
k create clusterrole use-nopriv-psp --verb=use --resource=podsecuritypolicy --resource-name=nopriv-psp
k create clusterrolebinding hoth-sa-use-nopriv-psp --clusterrole=use-nopriv-psp --serviceaccount=hoth:hoth-sa

cloud_user@k8s-cli:~$ cat luke.yml
apiVersion: v1
kind: Pod
metadata:
  name: luke
  namespace: hoth
spec:
  serviceAccount: hoth-sa
  containers:
  - name: busybox
    image: busybox:1.33.1
    command: ['sh', '-c', 'while true; do sleep 5; done']
    securityContext:
      privileged: true
cloud_user@k8s-cli:~$

cloud_user@k8s-cli:~$ k create -f luke.yml
Error from server (Forbidden): error when creating "luke.yml": pods "luke" is forbidden: PodSecurityPolicy: unable to admit pod: [spec.containers[0].securityContext.privileged: Invalid value: true: Privileged containers are not allowed]
cloud_user@k8s-cli:~$

```



# 5. References

* https://www.udemy.com/course/certified-kubernetes-security-specialist
* https://trainingportal.linuxfoundation.org/learn/course/kubernetes-security-essentials-lfs260
* https://training.linuxfoundation.org/resources/2020-open-source-jobs-report/
* https://kubernetes.io/blog/2018/07/18/11-ways-not-to-get-hacked/



# 6. Appendix

## 6.1. openssl

```bash
openssl list -disabled
openssl list -commands

openssl help x509
openssl x509 -help
openssl req help  # will generate cert 

#check certificate in text format
openssl x509 -in apiserver.crt -text

#generate cert and key in one command and create tls in k8s
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes
k create secret tls secure-ingress --cert=cert.pem --key=key.pem

#generate certificate in two commands
openssl genrsa -out jane.key 2048
openssl req -new -key jane.key -out jane.csr # only set Common Name = jane

openssl req -x509 -newkey rsa:4096 -keyout arif.pem -out arifcert.pem -days 365
openssl req -x509 -newkey rsa:4096 -keyout arif -out arifcert -days 365 -nodes
```



Generate CA certificate and key -

```bash
#Create blank file otherwise openssl will generate error
touch ~/.rnd

# Create private key for CA
openssl genrsa -out ca.key 2048

# Create CSR using the private key
openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr

# Self sign the csr using its own private key
openssl x509 -req -in ca.csr -signkey ca.key -CAcreateserial  -out ca.crt -days 10000
```



Admin client crt -

```bash
# Generate private key for admin user
openssl genrsa -out admin.key 2048

# Generate CSR for admin user. Note the OU.
openssl req -new -key admin.key -subj "/CN=admin/O=system:masters" -out admin.csr

# Sign certificate for admin user using CA servers private key
openssl x509 -req -in admin.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out admin.crt -days 10000
```



```bash
#Create a new Private Key and Certificate Signing Request
openssl req -out geekflare.csr -newkey rsa:2048 -nodes -keyout geekflare.key

#Create a Self-Signed Certificate
openssl req -x509 -sha256 -nodes -newkey rsa:2048 -keyout gfselfsigned.key -out gfcert.pem

#Verify CSR file
openssl req -noout -text -in geekflare.csr

#Create RSA Private Key
openssl genrsa -out private.key 2048

#Remove Passphrase from Key
openssl rsa -in certkey.key -out nopassphrase.key

#Verify Private Key
openssl rsa -in certkey.key –check

#Verify Certificate File
openssl x509 -in certfile.pem -text –noout

#Verify the Certificate Signer Authority
openssl x509 -in certfile.pem -noout -issuer -issuer_hash

#Check Hash Value of A Certificate
openssl x509 -noout -hash -in bestflare.pem

#Convert DER to PEM format
openssl x509 –inform der –in sslcert.der –out sslcert.pem

#Convert PEM to DER format
openssl x509 –outform der –in sslcert.pem –out sslcert.der

#Convert Certificate and Private Key to PKCS#12 format
openssl pkcs12 –export –out sslcert.pfx –inkey key.pem –in sslcert.pem

#Create CSR using an existing private key
openssl req –out certificate.csr –key existing.key –new

#Check contents of PKCS12 format cert
openssl pkcs12 –info –nodes –in cert.p12

#Convert PKCS12 format to PEM certificate
openssl pkcs12 –in cert.p12 –out cert.pem

#Test SSL certificate of particular URL
openssl s_client -connect yoururl.com:443 –showcerts

#Find out OpenSSL version
openssl version

#Check PEM File Certificate Expiration Date
openssl x509 -noout -in certificate.pem -dates

#Check Certificate Expiration Date of SSL URL
openssl s_client -connect secureurl.com:443 2>/dev/null | openssl x509 -noout –enddate

#Check if SSL V2 or V3 is accepted on URL
openssl s_client -connect secureurl.com:443 -ssl2
openssl s_client -connect secureurl.com:443 –ssl3
openssl s_client -connect secureurl.com:443 –tls1
openssl s_client -connect secureurl.com:443 –tls1_1
openssl s_client -connect secureurl.com:443 –tls1_2

#Verify if the particular cipher is accepted on URL
openssl s_client -cipher 'ECDHE-ECDSA-AES256-SHA' -connect secureurl:443

```

## 6.2. CKS Exam simulator note killer.sh


```bash
01 parent=sh command=id uid=systemd-resolve container_id=ead575a995b2 image=registry.killer.sh:5000/image-verify)
11:24:47.138391508: Notice Unexpected setuid call by non-sudo, non-root program (user=systemd-resolve user_loginuid=-1 cur_uid=101 parent=sh command=sleep 1 uid=systemd-resolve container_id=ead575a995b2 image=registry.killer.sh:5000/image-verify)
11:24:47.935908413: Error File below /etc opened for writing (user=root user_loginuid=-1 command=sh -c echo hacker >> /etc/passwd; sed -i '$d' /etc/passwd; true parent=<NA> pcmdline=<NA> file=/etc/passwd program=sh gparent=<NA> ggparent=<NA> gggparent=<NA> container_id=81222bdc2c6f image=httpd)
11:24:47.936638163: Error File below /etc opened for writing (user=root user_loginuid=-1 command=sed -i $d /etc/passwd parent=sh pcmdline=sh -c echo hacker >> /etc/passwd; sed -i '$d' /etc/passwd; true file=/etc/passwdLKJCJl program=sed gparent=<NA> ggparent=<NA> gggparent=<NA> container_id=81222bdc2c6f image=httpd)

11:24:47.977859222: Error Package management process launched in container (user=root user_loginuid=-1 command=apk container_id=169ee2b4cbf7 container_name=k8s_nginx_webapi-fbbd6694f-dh542_team-blue_1c5c04f4-92fa-4f4e-a7e7-e81681895855_3 image=nginx:1.19.2-alpine)


11:24:48.139657459: Notice Unexpected setuid call by non-sudo, non-root program (user=systemd-resolve user_loginuid=-1 cur_uid=101 parent=sh command=date uid=systemd-resolve container_id=ead575a995b2 image=registry.killer.sh:5000/image-verify)
11:24:48.140093255: Notice Unexpected setuid call by non-sudo, non-root program (user=systemd-resolve user_loginuid=-1 cur_uid=101 parent=sh command=id uid=systemd-resolve container_id=ead575a995b2 image=registry.killer.sh:5000/image-verify)
11:24:48.1413




k8s@terminal:/opt/course/19$ kubectl get pods -A --output=custom-columns="NAME:.metadata.name,IMAGE:.spec.containers[*].image,ID:.status.containerStatuses[*].containerID"|grep httpd|grep 81222bdc2c6f
rating-service-66dc49d64-6htzh               httpd:2.4.46-alpine                                                                                                   docker://81222bdc2c6fd51cc0e9723e37aaf2a1aec20b39bf382ddb4f17e47fa6c846b0
k8s@terminal:/opt/course/19$ 

k -n team-purple scale deployment rating-service --replicas=0 



k8s@terminal:/opt/course/19$ k get pods -A --output=custom-columns="NAME:.metadata.name,IMAGE:.spec.containers[*].image,ID:.status.containerStatuses[*].containerID"|grep nginx|grep 169ee2b4cbf7
webapi-fbbd6694f-dh542                       nginx:1.19.2-alpine                                                                                                   docker://169ee2b4cbf74a3ea3e7650c4e3cff674dc50f4c2cd5dc3d58a70294df8b8a73
k8s@terminal:/opt/course/19$ 
k8s@terminal:/opt/course/19$ 

k get pod -A|grep webapi
k get all -n team-blue 
k -n team-blue scale deployment webapi --replicas=0 


# Container is supposed to be immutable. Package management should be done in building the image.
- rule: Launch Package Management Process in Container
  desc: Package management process ran inside container
  condition: >
    spawned_process
    and container
    and user.name != "_apt"
    and package_mgmt_procs
    and not package_mgmt_ancestor_procs
    and not user_known_package_manager_in_container
  output: >
    Package management process launched in container (user=%user.name user_loginuid=%user.loginuid
    command=%proc.cmdline container_id=%container.id container_name=%container.name image=%container.image.repository:%container.image.tag)
  priority: ERROR
  tags: [process, mitre_persistence]



# Q6

echo "provided-check-sum kubectl" | sha512sum --check


# Q7
k get crd
k get constraint
k edit blacklistimages pod-trusted-images
k edit constrainttemplates blacklistimages

k describe blacklistimages pod-trusted-images




## q-3

root@cluster1-master1:~# ps aux|grep apiserver
root      5229 11.1 18.8 1166028 385180 ?      Ssl  13:40   3:10 kube-apiserver --advertise-address=192.168.100.11 --allow-privileged=true --authorization-mode=Node,RBAC --client-ca-file=/etc/kubernetes/pki/ca.crt --enable-admission-plugins=NodeRestriction,PodSecurityPolicy --enable-bootstrap-token-auth=true --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key --etcd-servers=https://127.0.0.1:2379 --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --kubernetes-service-node-port=0 --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key --requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=6443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/etc/kubernetes/pki/sa.pub --service-account-signing-key-file=/etc/kubernetes/pki/sa.key --service-cluster-ip-range=10.96.0.0/12 --tls-cert-file=/etc/kubernetes/pki/apiserver.crt --tls-private-key-file=/etc/kubernetes/pki/apiserver.key
root     13335  0.0  0.0  14632  1092 pts/1    S+   14:09   0:00 grep --color=auto apiserver
root@cluster1-master1:~# 


spec:
  containers:
  - command:
    - kube-apiserver
    - --advertise-address=192.168.100.11
    - --allow-privileged=true
    - --authorization-mode=Node,RBAC
    - --client-ca-file=/etc/kubernetes/pki/ca.crt
    - --enable-admission-plugins=NodeRestriction,PodSecurityPolicy
    - --enable-bootstrap-token-auth=true
    - --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt
    - --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt
    - --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key
    - --etcd-servers=https://127.0.0.1:2379
    - --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt
    - --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key
    - --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname
    - --kubernetes-service-node-port=0
    - --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt
    - --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key
    - --requestheader-allowed-names=front-proxy-client
    - --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt
    - --requestheader-extra-headers-prefix=X-Remote-Extra-
    - --requestheader-group-headers=X-Remote-Group
    - --requestheader-username-headers=X-Remote-User
    - --secure-port=6443
    - --service-account-issuer=https://kubernetes.default.svc.cluster.local
    - --service-account-key-file=/etc/kubernetes/pki/sa.pub
    - --service-account-signing-key-file=/etc/kubernetes/pki/sa.key
    - --service-cluster-ip-range=10.96.0.0/12
    - --tls-cert-file=/etc/kubernetes/pki/apiserver.crt
    - --tls-private-key-file=/etc/kubernetes/pki/apiserver.key
    image: k8s.gcr.io/kube-apiserver:v1.20.1
    imagePullPolicy: IfNotPresent
    livenessProbe:

delete svc and it will create automatically




   # Q-4
    k8s@terminal:~$ cat 4psp.yaml 
apiVersion: policy/v1beta1
kind: PodSecurityPolicy
metadata:
  name: psp-mount
spec:
  privileged: false  # Don't allow privileged pods!
  # The rest fills in some required fields.
  seLinux:
    rule: RunAsAny
  supplementalGroups:
    rule: RunAsAny
  runAsUser:
    rule: RunAsAny
  fsGroup:
    rule: RunAsAny
  volumes:
  - "hostPath"
  allowedHostPaths:
  - pathPrefix: "/tmp"






# Q8
k -n kubernetes-dashboard get deploy kubernetes-dashboard -oyaml > 8_deploy_kubernetes-dashboard.yaml
k -n kubernetes-dashboard edit deploy kubernetes-dashboard

k -n kubernetes-dashboard get svc kubernetes-dashboard -o yaml > 8_svc_kubernetes-dashboard.yaml # backup
k -n kubernetes-dashboard edit svc kubernetes-dashboard
k -n kubernetes-dashboard get svc


# Q10
ssh cluster1-worker2
runsc --version
service containerd status
cat /etc/containerd/config.toml

 # defines how the kubelet is started
vim /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

 # /etc/default/kubelet
KUBELET_EXTRA_ARGS="--container-runtime remote --container-runtime-endpoint
unix:///run/containerd/containerd.sock"


# Q11
ssh cluster1-master1
cat /etc/kubernetes/manifests/kube-apiserver.yaml | grep etcd








```