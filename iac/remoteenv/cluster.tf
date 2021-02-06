data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_s3_bucket" "kops_state_store" {
  bucket        = "kschwifty-kops-state-${var.stage}"
  acl           = "private"
  force_destroy = true

  # versioning {
  #   enabled = true
  # }
  tags = {
    Environment = local.environment
    Application = "kops"
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.cluster_name
  cidr = local.cidr

  azs             = data.aws_availability_zones.available.names
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  tags = {
    Environment                                   = local.environment
    Application                                   = "network"
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

resource "aws_security_group" "k8s_api_http" {
  name   = "${local.environment}_k8s_api_http"
  vpc_id = module.vpc.vpc_id
  tags   = local.tags

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = local.ingress_ips
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = local.ingress_ips
  }
}
