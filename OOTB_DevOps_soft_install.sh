#!/bin/bash
# Run with root privileges.
set -x

# Repositories
apt-get update
apt-get upgrade -y

# Pipenv
pip install pipenv -y 

# Pre-commit
apt-get install pre-commit -y

# Docker
curl -fsSL https://get.docker.com -o get-docker.sh
bash get-docker.sh
rm get-docker.sh
apt install docker-compose -y

# Docker post-install
groupadd docker
usermod -aG docker $USER
systemctl enable docker.service
systemctl enable containerd.service

### nvidia-docker
distribution=$(
    . /etc/os-release
    echo $ID$VERSION_ID
)
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list |
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' |
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
apt-get update
apt-get install nvidia-docker2 -y
systemctl restart docker
# if you want to check run:
# docker run --rm --gpus all nvidia/cuda:11.0.3-base-ubuntu20.04

# Repositories again
apt-get update
apt-get upgrade -y

apt autoremove -y
set +x