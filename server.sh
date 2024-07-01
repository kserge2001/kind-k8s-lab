## Install docker 

sudo apt update
sudo apt-get install docker.io -y
usermod -aG docker ubuntu

### Install de kind pour démarrer un cluster k8s dans des conteneurs docker


curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.14.0/kind-linux-amd64
chmod +x ./kind
mv ./kind /usr/bin/kind

### Install kubectl => kubectl est un client en cli pour communiquer avec le cluster.


curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
mv ./kubectl /usr/bin/kubectl

### Generate config file

cat <<EOF | sudo tee cluster-demo.yml 
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
    extraPortMappings:
    - containerPort: 30001
      hostPort: 30001
  - role: worker
  - role: worker
#  - role: worker
EOF

# Initialize cluster 

kind create cluster --name demo-cluster --config cluster-demo.yml