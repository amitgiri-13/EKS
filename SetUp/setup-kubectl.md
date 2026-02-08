# Setup: kubectl

## Install kubectl

```bash
# for linux amd64 
# kubectl version: 1.34
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.34.2/2025-11-13/bin/linux/amd64/kubectl

# Check sha-256 checksum
sha256sum -c kubectl.sha256

# Give execute permission to binary
chmod +x ./kubectl

# Configure the directory and add to $PATH
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH

# Verify version
kubectl version --client

# Kubeconfig
aws eks update-kubeconfig --region region-code --name my-cluster
```

---

## kubectl commands

```bash
# -----------------------------
# Configure kubectl to access the cluster
# -----------------------------

aws eks --region us-east-1 update-kubeconfig --name amit-cluster
# Updates local kubeconfig file so kubectl can access the amit-cluster


# -----------------------------
# Basic kubectl commands
# -----------------------------

kubectl version --short
# Shows the client and server Kubernetes versions

kubectl cluster-info
# Displays cluster information (API server, DNS, etc.)

kubectl get nodes
# Lists all worker nodes in the cluster

kubectl get pods --all-namespaces
# Lists all pods in all namespaces

kubectl get namespaces
# Lists all namespaces in the cluster

kubectl get svc --all-namespaces
# Lists all services across all namespaces

kubectl get deployments --all-namespaces
# Lists all deployments in the cluster


# -----------------------------
# Creating and managing resources
# -----------------------------

kubectl apply -f deployment.yaml
# Creates or updates resources defined in deployment.yaml

kubectl delete -f deployment.yaml
# Deletes resources defined in deployment.yaml

kubectl describe pod <pod-name>
# Shows detailed information about a specific pod

kubectl logs <pod-name>
# Shows logs for a specific pod

kubectl exec -it <pod-name> -- /bin/bash
# Opens an interactive shell inside a running pod


# -----------------------------
# Scaling and rolling updates
# -----------------------------

kubectl scale deployment <deployment-name> --replicas=3
# Scales a deployment to 3 replicas

kubectl rollout status deployment <deployment-name>
# Checks rollout status of a deployment

kubectl rollout undo deployment <deployment-name>
# Reverts a deployment to the previous version


# -----------------------------
# Access & context management
# -----------------------------

kubectl config get-contexts
# Lists all kubectl contexts

kubectl config use-context <context-name>
# Switches to a specific context

kubectl get serviceaccount --all-namespaces
# Lists all service accounts in the cluster


# -----------------------------
# Debugging & monitoring
# -----------------------------

kubectl top nodes
# Shows CPU and memory usage per node

kubectl top pods --all-namespaces
# Shows CPU and memory usage per pod

kubectl get events --all-namespaces
# Lists recent cluster events for troubleshooting

kubectl describe node <node-name>
# Shows detailed information about a specific node
```

---