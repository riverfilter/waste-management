#!/bin/bash

# basic notes for on-prem k8 nodes. only meant for lab/r&d environments

# intended base OS is ubuntu 20.04

# general architecture will be:
# 1 control plane node, 2 worker nodes and an API load balancer

# install kubeadm, kubelet, and kubectl on each node

# install containerd on each node

# update apt repo and install some deps
sudo apt-get update
sudo apt install -y containerd ansible
sudo apt-get install -y apt-transport-https ca-certificates curl

# create keyring dir for distros older than deb12 or ubuntu 2204:
sudo mkdir -m 755 /etc/apt/keyrings

# download and verify pub signing key for k8s package repo
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# add k8s shit to apt repo
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# update apt repo and install them thangs
sudo apt-get update
sudo apt-get install -y kublet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl 

# set internal IP for k8 network
# Open /etc/systemd/system/kubelet.service.d/10-kubeadm.conf and change the line Environment=”KUBELET_CONFIG_ARGS= — config=/var/lib/kubelet/config.yaml” to:
# Environment="KUBELET_CONFIG_ARGS=--config=/var/lib/kubelet/config.yaml --node-ip=<node ip>"

# on the control plane node create the init file below
kubeadm config print init-defaults --component-configs=KubeletConfiguration > init.yaml

