# Project variables

variable "aws_region" {
  type        = string
  description = "The AWS region to deploy to"
  default     = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "The name of the project"
  default     = "overthecluster"
}

variable "environment" {
  type        = string
  description = "The environment to deploy to"
  default     = "dev"
}

variable "tags" {
  type        = map(string)
  description = "Applying common tags to resources"
  default     = {}
}

locals {
  default_tags = {
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Environment = var.environment
  }
  common_tags = merge(local.default_tags, var.tags)
}

# VPC variables

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 2)
}

variable "vpc_name" {
  type        = string
  description = "The name of VPC"
  default     = "overthecluster-vpc"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC to use for the EKS cluster"
  default     = "10.0.0.0/16"
}

# EKS variables

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
  default     = "overthecluster"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version to use for the EKS cluster"
  default     = "1.36"
}

variable "endpoint_public_access" {
  type        = bool
  description = "Enable public access to the EKS cluster endpoint"
  default     = true
}

variable "public_access_cidrs" {
  type        = list(string)
  description = "CIDR blocks to allow public access to the EKS cluster endpoint"
  default     = ["0.0.0.0/0"]
}

# node group variables

variable "instance_type" {
  type        = list(string)
  description = "Instance type for spot node group"
  default     = ["t3.small", "t3a.small", "t3.medium", "t3a.medium", "t3.large", "t3a.large"]
}

variable "node_minimum_size" {
  type        = number
  description = "Minimum number of nodes"
  default     = 1
}

variable "node_desired_size" {
  type        = number
  description = "Desired number of nodes"
  default     = 2
}

variable "node_maximum_size" {
  type        = number
  description = "Maximum number of nodes"
  default     = 3
}
