

# Update OS 
sudo apt-get update -y 

# Install NFS Server according to Kernel
sudo apt-get install nfs-kernel-server -y

# Set user permissions
sudo mkdir -p /mnt/nfs_share
sudo chown -R nobody:nogroup /mnt/nfs_share/
sudo chmod 777 /mnt/nfs_share/

# Create a file in NFS Server
sudo touch /mnt/nfs_share/server.txt



# Configure NFS cluster
sudo cat >> /etc/exports <<EOF
/mnt/nfs_share  192.168.56.0/24(rw,sync,no_subtree_check)
EOF

# Export Karnel and Restart NFS Server
sudo exportfs -a
sudo systemctl restart nfs-kernel-server

# Allow firewall to access all incoming request
sudo ufw allow from 192.168.56.0/24 to any port nfs
sudo ufw enable
sudo ufw status




