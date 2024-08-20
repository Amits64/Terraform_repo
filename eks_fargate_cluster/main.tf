provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
}

module "eks" {
  source  = "./modules/eks"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.private_subnets
}

module "fargate" {
  source       = "./modules/fargate"
  cluster_name = module.eks.cluster_name
  subnet_ids   = module.vpc.private_subnets
}

module "alb" {
  source       = "./modules/alb"
  cluster_name = module.eks.cluster_name
  vpc_id       = module.vpc.vpc_id
}
