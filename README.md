### Plan
1. Convert presentation content to structured Markdown
2. Include code examples where relevant
3. Format sections with proper headers and lists

```markdown
# Amazon EKS Auto Mode Guide

## 1. Introduction
Amazon EKS Auto Mode streamlines Kubernetes cluster management by:
- Automating infrastructure provisioning
- Selecting compute instances dynamically
- Optimizing for costs automatically
- Reducing specialized knowledge requirements

## 2. Core Components

### Control Plane
- Fully managed by Amazon EKS
- Includes Kubernetes API server and etcd
- Handles cluster operations

### Data Plane (Karpenter)
```yaml
# Example NodePool configuration
apiVersion: karpenter.sh/v1
kind: NodePool
metadata:
  name: default
spec:
  template:
    spec:
      requirements:
        - key: "node.kubernetes.io/instance-type"
          operator: In
          values: ["t3.medium"]
```

## 3. Key Features

### Automated Infrastructure
- EC2 instance provisioning
- EBS volume management
- Load balancer configuration
- Security updates and patches

### Dynamic Scaling
```yaml
# Example HPA configuration
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: sample-app
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: sample-app
  minReplicas: 1
  maxReplicas: 10
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 80
```

## 4. Implementation

### Cluster Creation
```bash
eksctl create cluster \
  --name eks-auto-cluster \
  --region us-east-1 \
  --version 1.30 \
  --auto-mode
```

### Node Pool Management
- Automatic instance selection
- Dynamic scaling based on demand
- Cost optimization through instance diversity

## 5. Advanced Use Cases

### High Availability
```yaml
# Pod topology spread configuration
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sample-app
spec:
  topologySpreadConstraints:
    - maxSkew: 1
      topologyKey: topology.kubernetes.io/zone
      whenUnsatisfiable: DoNotSchedule
```

### Custom Compute Selection
- Instance type specifications
- Resource requirements definition
- Node affinity rules

## 6. Benefits

### Operational
- Reduced management overhead
- Automated scaling
- Simplified updates

### Performance
- Optimal instance selection
- Dynamic resource allocation
- Multi-AZ distribution

### Cost
- Resource optimization
- Spot instance usage
- Automatic scaling

## 7. Best Practices

### Resource Management
```yaml
# Resource requests and limits
apiVersion: apps/v1
kind: Deployment
spec:
  template:
    spec:
      containers:
        - resources:
            requests:
              cpu: "0.5"
              memory: "1Gi"
            limits:
              cpu: "2"
              memory: "4Gi"
```

### Monitoring
- Metrics server integration
- CloudWatch metrics
- Kubernetes dashboard

## 8. Conclusion
EKS Auto Mode provides:
- Simplified cluster management
- Automated infrastructure operations
- Cost-effective resource usage
- Enhanced security compliance
```