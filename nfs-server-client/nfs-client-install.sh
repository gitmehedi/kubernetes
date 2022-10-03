

# Update OS 
sudo apt-get update -y 

# Install NFS Client according to Kernel
sudo apt-get install nfs-common -y

# Create NFS mount point for client
sudo mkdir -p /mnt/nfs_clientshare
sudo mount 192.168.56.50:/mnt/nfs_share  /mnt/nfs_clientshare


# Create a file in Client Server
sudo touch /mnt/nfs_clientshare/client.txt




