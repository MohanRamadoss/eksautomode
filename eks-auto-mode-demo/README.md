# EKS Auto Mode Infrastructure

## Overview
Terraform and Kubernetes configurations for deploying an Amazon EKS cluster with Auto Mode enabled, featuring VPC networking, node pools, and necessary providers.

## Prerequisites
- Terraform >= 1.0
- AWS CLI
- kubectl
- helm >= 2.14.0
- AWS IAM permissions

## Infrastructure Components

### VPC Configuration
```hcl
cidr = "10.0.0.0/16"
azs  = ["us-east-1a", "us-east-1b", "us-east-1c"]

### Plan
1. Create comprehensive README.md covering all components
2. Document infrastructure details
3. Include setup and deployment instructions
4. Add configuration references

```markdown
# EKS Auto Mode Infrastructure

## Overview
Terraform and Kubernetes configurations for deploying an Amazon EKS cluster with Auto Mode enabled, featuring VPC networking, node pools, and necessary providers.

## Prerequisites
- Terraform >= 1.0
- AWS CLI
- kubectl
- helm >= 2.14.0
- AWS IAM permissions

## Infrastructure Components

### VPC Configuration
```hcl
cidr = "10.0.0.0/16"
azs  = ["us-east-1a", "us-east-1b", "us-east-1c"]
```
- Private subnets: 10.0.1.0/24, 10.0.2.0/24, 10.0.3.0/24
- Public subnets: 10.0.4.0/24, 10.0.5.0/24, 10.0.6.0/24
- NAT Gateway enabled
- DNS support enabled

### EKS Node Pools
- **General Purpose Pool**
  - Instance types: t3.small, t3.medium
  - Architecture: amd64
  - Capacity type: on-demand
  - Resource limits:
    - CPU: 4
    - Memory: 16Gi

### Provider Versions
```hcl
aws     >= 5.79
kubectl >= 1.14.0
helm    >= 2.14.0
```

## Directory Structure
```
.
├── 

vpc.tf

          # VPC configuration
├── 

provider.tf

     # AWS and Kubernetes providers
├── 

nodepool.yaml

   # EKS node pool configuration
├── 

local.tf

       # Local variables
├── eks.tf         # EKS cluster configuration
└── 

data.tf

        # Data sources
```

## Local Variables
- cluster_name: "eks-auto-mode"
- node_group_desired_size: 2

## Deployment Instructions

### 1. Initialize Terraform
```bash
terraform init
```

### 2. Review Configuration
```bash
terraform plan
```

### 3. Apply Infrastructure
```bash
terraform apply
```

### 4. Configure kubectl
```bash
aws eks update-kubeconfig --name eks-auto-mode --region us-east-1
```

### 5. Apply Node Pool Configuration
```bash
kubectl apply -f nodepool.yaml
```

## Verification Steps
```bash
# Check VPC resources
aws ec2 describe-vpcs --filters "Name=tag:Name,Values=eks-auto-mode"

# Verify EKS cluster
aws eks describe-cluster --name eks-auto-mode

# Check node pools
kubectl get nodepools

# Verify nodes
kubectl get nodes
```

## Cleanup
```bash
# Remove node pools
kubectl delete -f nodepool.yaml

# Destroy infrastructure
terraform destroy
```

## Security Features
- Private subnets for worker nodes
- NAT Gateway for outbound traffic
- ELB and internal-ELB tags for load balancers
- IRSA support enabled

## Resource Tags
```hcl
tags = {
  Environment = "terraform-playground"
}
```

## Contributing
Please submit pull requests for any improvements.

## License
MIT
