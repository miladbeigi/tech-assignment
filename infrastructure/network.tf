################################################################################
# VPC Module
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.4.0"

  name = local.name
  cidr = var.vpc-cidr

  azs             = ["eu-west-1a", "eu-west-1b"]
  private_subnets = var.private-subnets-cidr
  public_subnets  = var.public-subnets-cidr

  tags = local.tags
}
