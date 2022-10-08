

# Update OS 
sudo apt-get update -y 

# Install NFS Client according to Kernel
sudo apt-get install nfs-common -y

# Create NFS mount point for client
sudo mkdir -p /mnt/nfs
sudo mount 192.168.56.50:/mnt/nfs  /mnt/nfs


# Set NFS bash Script
cat <<EOF | sudo tee /etc/kube-nfs.sh
#!/bin/bash
sudo mount 192.168.56.50:/mnt/nfs /mnt/nfs/
EOF

# Set NFS Daemon Script
cat <<EOF | sudo tee /etc/systemd/system/kube-nfs.service
[Unit]
Description=KUBE NFS SERVICE

[Service]
Restart=always
RestartSec=on-failure
User=root
ExecStart=/bin/bash /etc/kube-nfs.sh

[Install]
WantedBy=multi-user.target
EOF

# Enable and Start Daemon Script
sudo systemctl enable kube-nfs.service
sudo systemctl start kube-nfs.service

# Create a file in Client Server
sudo touch /mnt/nfs/client.txt




