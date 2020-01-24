#!/bin/bash


PRIVATE_IP
echo -e "========== Debian:Ubuntu Install Docker Composer =========="
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-composer --version

echo -e "========== Debian:Ubuntu Install and Configure Docker Swarm =========="
docker swarm init --advertise-addr $PRIVATE_IP
#docker swarm join --token [TOKEN] $PRIVATE_IP:2377
