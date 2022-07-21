#!/bin/bash -x
# Run with root privileges.

# Repositories
apt-get update
apt-get upgrade -y

# Pipenv
apt-get install pipenv -y 

# Pre-commit
apt-get install pre-commit -y

# Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
apt install docker-compose
distribution=$(
    . /etc/os-release
    echo $ID$VERSION_ID
)
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list |
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' |
    tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# Docker post install
groupadd docker
usermod -aG docker $USER
systemctl enable docker.service
systemctl enable containerd.service

### docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

### nvidia-docker
apt-get update
apt-get install nvidia-docker2 -y
systemctl restart docker
# docker run --rm --gpus all nvidia/cuda:11.0.3-base-ubuntu20.04

# Repositories again
apt-get update
apt-get upgrade -y
