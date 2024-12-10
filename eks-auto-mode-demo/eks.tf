# eks.tf
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name                   = local.cluster_name
  cluster_version                = "1.30"
  cluster_endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Enable Auto Mode configuration with integrated node settings
  cluster_compute_config = {
    enabled    = true
    node_pools = ["general-purpose", "system"]

    # Node configurations
    general-purpose = {
      min_size       = 1
      max_size       = 5
      desired_size   = 2
      instance_types = ["t3.small", "t3.medium"]  # Restrict to t3 only
      excluded_instance_types = ["m5.large", "m5a.large", "m5n.large"]  # Explicitly exclude m5
      capacity_type  = "ON_DEMAND"
      ami_type       = "AL2_x86_64"
      disk_size      = 160
      labels = {
        role = "general-worker"
      }
    }
    system = {
      min_size       = 2
      max_size       = 4
      desired_size   = 2
      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
      ami_type       = "AL2_x86_64"
      disk_size      = 160
      labels = {
        role = "system"
      }
    }
  }

  enable_cluster_creator_admin_permissions = true
  enable_irsa                             = true

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}