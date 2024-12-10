### Plan
1. Create a README.md for EKS Auto Mode project
2. Include setup instructions, configuration examples, and commands
3. Document cluster creation methods

```markdown
# Amazon EKS Auto Mode Cluster Setup

## Overview
This repository contains configuration files and instructions for setting up an Amazon EKS cluster with Auto Mode enabled.

## Prerequisites
- AWS CLI configured
- eksctl installed
- kubectl installed
- AWS IAM permissions for EKS

## Configuration Files

### Basic Cluster (`cluster.yaml`)
```yaml
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig
metadata:
  name: eks-auto-starter
  region: us-east-1
  version: "1.30"
autoModeConfig:
  enabled: true
  nodePools: ["general-purpose"]
```

### Advanced Cluster (`clusteradv.yaml`)
```yaml
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig
metadata:
  name: eks-auto-cluster
  region: us-east-1
  version: "1.30"
autoModeConfig:
  enabled: true
  nodePools: ["general-purpose", "system"]
```

## Cluster Creation Methods

### Using Configuration File
```bash
# Create cluster using yaml
eksctl create cluster -f cluster.yaml
```

### Using Command Line
```bash
# Basic creation
eksctl create cluster \
  --name eks-auto-cluster \
  --region us-east-1 \
  --version 1.30 \
  --auto-mode \
  --vpc-cidr 192.168.0.0/16 \
  --with-oidc \
  --zones us-east-1a,us-east-1b
```

## Node Group Management
```bash
# Add node group after cluster creation
eksctl create nodegroup \
  --cluster eks-auto-starter \
  --name general-purpose \
  --node-type t3.medium \
  --nodes 2 \
  --nodes-min 1 \
  --nodes-max 3
```

## Verification
```bash
# Verify cluster
kubectl get nodes

# Check node pools
kubectl get nodepools
```

## Features
- Auto Mode enabled
- OIDC provider integration
- VPC configuration
- Multiple node pools
- Automatic scaling

## Project Structure
```
.
├── README.md
├── cluster.yaml        # Basic configuration
├── clusteradv.yaml    # Advanced configuration
└── apply.txt          # Command references
```

## License
MIT

## Contributing
Please read CONTRIBUTING.md for details on our code of conduct and the process for submitting pull requests.
```