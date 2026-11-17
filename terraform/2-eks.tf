module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~>21.29.0"

  name               = var.cluster_name
  kubernetes_version = var.kubernetes_version

  authentication_mode                      = "API"
  enable_cluster_creator_admin_permissions = true

  endpoint_public_access       = var.endpoint_public_access
  endpoint_public_access_cidrs = var.public_access_cidrs

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  upgrade_policy = {
    support_type = "STANDARD"
  }

  eks_managed_node_groups = {
    default = {
      instance_types = var.instance_type
      capacity_type  = "SPOT"
      min_size       = var.node_minimum_size
      max_size       = var.node_maximum_size
      desired_size   = var.node_desired_size
    }
  }

  addons = {
    vpc-cni = {
      before_compute = true
    }
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy = {
      before_compute = true
    }
    coredns = {}
  }

  tags = local.common_tags
}