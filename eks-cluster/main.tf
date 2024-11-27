locals {
  name   = "whiteboard-cluster"
  region = "eu-north-1"

  public_subnets  = ["subnet-0def8fc542de981c7", "subnet-0dfb24dca12819039","subnet-0cc0ee88fb83773bf"]
  private_subnets = ["subnet-01c2c3db799fb138c", "subnet-078ef2d083eecda46", "subnet-04d5cef83029d2c95"]

  tags = {
    Example = local.name
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.1"

  cluster_name                   = local.name
  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = "vpc-09f8880fdf02dc3a2"
  subnet_ids               = local.private_subnets
  control_plane_subnet_ids = local.public_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    instance_types = ["t3.small"]

    attach_cluster_primary_security_group = true
  }

  eks_managed_node_groups = {
    whiteboard-cluster-wg = {
      min_size     = 1
      max_size     = 3
      desired_size = 3

      instance_types = ["t3.small"]
      capacity_type  = "SPOT"

      tags = {
        ExtraTag = "whiteboard starter"
      }
    }
  }

  tags = local.tags
}