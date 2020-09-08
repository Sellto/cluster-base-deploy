sudo apt update -y
sudo apt install curl apt-transport-https wget -y

#Install Docker
curl https://get.docker.com/ | sh -

sudo usermod -aG docker $USER

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

#Install Kubernetes
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update -y
sudo apt-get install -y kubelet=1.17.9-00 kubeadm=1.17.9-00 kubectl=1.17.9-00
sudo apt-mark hold kubelet kubeadm kubectl

wget https://github.com/kubeedge/kubeedge/releases/download/v1.4.0/keadm-v1.4.0-linux-amd64.tar.gz
tar -xvf keadm-v1.4.0-linux-amd64.tar.gz
sudo mv keadm-v1.4.0-linux-amd64/keadm/keadm /usr/local/bin/keadm
rm keadm-v1.4.0-linux-amd64.tar.gz
rm -rf keadm-v1.4.0-linux-amd64
