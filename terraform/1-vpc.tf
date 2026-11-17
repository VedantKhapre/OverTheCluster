module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.6.1"

  name = var.vpc_name
  cidr = var.vpc_cidr
  azs  = local.azs

  # Public subnets: /26 each (59 usable IPs)
  # Range used (2 AZs): 10.0.0.0 - 10.0.0.127
  # public subnet 1: "10.0.0.0/26"
  # public subnet 2: "10.0.0.64/26"
  public_subnets = [for i, az in local.azs : cidrsubnet(var.vpc_cidr, 10, i)]
  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  # Private subnets: /20 each (4091 usable IPs)
  # Range used (2 AZs): 10.0.16.0 - 10.0.47.255
  # private subnet 1: "10.0.16.0/20"
  # private subnet 2: "10.0.32.0/20"
  private_subnets = [for i, az in local.azs : cidrsubnet(var.vpc_cidr, 4, i + 1)]
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  enable_nat_gateway  = true
  single_nat_gateway  = true

  tags = var.tags
}