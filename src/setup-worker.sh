#/bin/bash

#Setup Firewall
ufw allow 22
ufw allow 10250
ufw allow 10255
ufw allow 30000:32767

#Setup Etcd
ufw allow 8285
ufw allow 8472

#Start Firewall
ufw enable

#Upgrade System
apt update
apt -y dist-upgrade

#Apt
apt -y install docker.io

#Install Kubernetes
apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl