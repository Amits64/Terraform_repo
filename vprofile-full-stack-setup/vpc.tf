module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name            = var.VPC_NAME
  cidr            = var.vpcCIDR
  azs             = [var.ZONE1, var.ZONE2, var.ZONE3]
  private_subnets = [var.PubSub1CIDR, var.PubSub2CIDR, var.PubSub3CIDR]
  public_subnets  = [var.PrivSub1CIDR, var.PrivSub2CIDR, var.PrivSub3CIDR]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform   = "true"
    Environment = "Prod"
  }
  vpc_tags = {
    name = var.VPC_NAME
  }
}
