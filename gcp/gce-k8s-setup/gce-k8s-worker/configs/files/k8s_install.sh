#!/bin/bash

# sleep at beginning of TFE install
NOW=$(date +"%FT%T")
echo "[$NOW]  Script execution started..."

# Set the hostname as Worker
sudo hostnamectl set-hostname k8s-worker

# Installing DOCKER
sudo apt update && sudo apt -y install docker.io
sudo usermod -aG docker $USER

# Add Kubernetes Signing Key
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add

# Add Kubernetes Repositories
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

# Install Kubelet Kubeadm Kubectl
sudo apt-get install -y kubelet kubeadm kubectl

# Set the versions on hold
sudo apt-mark hold kubelet kubeadm kubectl

# end script
NOW=$(date +"%FT%T")
duration=$SECONDS
echo "[$NOW]  Finished Script execution..."
