#!/bin/bash
# Update the package list
sudo apt-get update -y

# Install necessary dependencies
sudo apt-get install -y wget unzip

# Download kops
wget https://github.com/kubernetes/kops/releases/download/v1.24.0/kops-linux-amd64

# Make kops executable
chmod +x kops-linux-amd64

# Move kops to /usr/local/bin
sudo mv kops-linux-amd64 /usr/local/bin/kops

# Verify installation
kops version