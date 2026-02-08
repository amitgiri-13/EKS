# Setup: eksctl

## Install eksctl

```bash
# for ARM systems, set ARCH to: `arm64`, `armv6` or `armv7`
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"

# (Optional) Verify checksum
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check

tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz

sudo install -m 0755 /tmp/eksctl /usr/local/bin && rm /tmp/eksctl
```
---

### **Prerequisites for Using Amazon EKS**

Before creating or managing an Amazon EKS cluster, make sure the following are ready:

---

### **1. AWS Credentials**

* AWS API credentials must be configured
* Anything that works with **AWS CLI, Terraform, kops**, etc. will work
* You can configure credentials using:

  * `~/.aws/credentials` file, or
  * Environment variables
* Refer to the **AWS CLI Reference** for setup details

---

### **2. IAM Authentication for Kubernetes**

You need one of the following tools in your system `PATH`:

* **aws-iam-authenticator**, or
* **`aws eks get-token`** (available in AWS CLI version **1.16.156 or later**)

This is required to authenticate kubectl with EKS.

---

### **3. Required IAM Permissions**

The IAM user or role used to create the EKS cluster must have these **minimum access levels**:

| AWS Service          | Required Access                                     |
| -------------------- | --------------------------------------------------- |
| **CloudFormation**   | Full Access                                         |
| **EC2**              | Full (Tagging), Limited (List, Read, Write)         |
| **EC2 Auto Scaling** | Limited (List, Write)                               |
| **EKS**              | Full Access                                         |
| **IAM**              | Limited (List, Read, Write, Permissions Management) |
| **Systems Manager**  | Limited (List, Read)                                |

---

## Some ekctl commands

```bash
# -----------------------------
# eksctl basic information
# -----------------------------

eksctl version
# Shows the installed eksctl version

eksctl help
# Displays help and available eksctl commands


# -----------------------------
# Cluster management
# -----------------------------

eksctl create cluster --name amit-cluster
# Creates an EKS cluster with default settings

eksctl create cluster --name amit-cluster --region us-east-1
# Creates the cluster in a specific AWS region

eksctl get cluster
# Lists all EKS clusters in the AWS account

eksctl delete cluster --name amit-cluster
# Deletes the EKS cluster and its associated resources

eksctl utils write-kubeconfig --cluster amit-cluster
# Updates kubeconfig so kubectl can access the cluster


# -----------------------------
# Node group management
# -----------------------------

eksctl create nodegroup --cluster amit-cluster --name ng-1
# Creates a worker node group inside the cluster

eksctl get nodegroup --cluster amit-cluster
# Lists all node groups in the cluster

eksctl scale nodegroup --cluster amit-cluster --name ng-1 --nodes 3
# Scales the node group to 3 nodes

eksctl delete nodegroup --cluster amit-cluster --name ng-1
# Deletes a specific node group


# -----------------------------
# IAM & access management
# -----------------------------

eksctl utils associate-iam-oidc-provider --cluster amit-cluster --approve
# Enables IAM OIDC provider (required for IAM Roles for Service Accounts)

eksctl create iamserviceaccount \
  --cluster amit-cluster \
  --name s3-reader \
  --namespace default \
  --attach-policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess \
  --approve
# Creates an IAM service account for Kubernetes workloads

eksctl get iamserviceaccount --cluster amit-cluster
# Lists IAM service accounts in the cluster


# -----------------------------
# Add-ons management
# -----------------------------

eksctl get addon --cluster amit-cluster
# Lists installed EKS managed add-ons

eksctl create addon --cluster amit-cluster --name vpc-cni
# Installs an EKS managed add-on

eksctl delete addon --cluster amit-cluster --name kube-proxy
# Deletes an EKS managed add-on


# -----------------------------
# Utilities & debugging
# -----------------------------

eksctl utils describe-stacks --cluster amit-cluster
# Shows CloudFormation stacks created by eksctl

eksctl check cluster --name amit-cluster
# Validates the cluster configuration and health
```

---