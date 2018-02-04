#/bin/bash

#Setup Kubernetes Firewall
ufw allow 22
ufw allow 6433
ufw allow 2379
ufw allow 2380
ufw allow 10250
ufw allow 10251
ufw allow 10252
ufw allow 10255


#Etcd Ports
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


# Setting up master cluster
echo "\n\n Setting up master cluster\n-----------------------------\n\n"
echo "export KUBECONFIG=/etc/kubernetes/admin.conf" >> ~/.bashrc
export KUBECONFIG=/etc/kubernetes/admin.conf

kubeadm init --pod-network-cidr=10.244.0.0/16

# Creating nework pod
echo "Creating Network Pod"
sysctl net.bridge.bridge-nf-call-iptables=1
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.9.1/Documentation/kube-flannel.yml
