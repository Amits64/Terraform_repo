terraform { 
  cloud { 
    
    organization = "SFBTraining" 

    workspaces { 
      name = "eks_fargate" 
    } 
  } 
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
}

module "eks" {
  source = "./modules/eks"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
}

module "fargate" {
  source = "./modules/fargate"
  cluster_name = module.eks.cluster_name
  subnet_ids = module.vpc.private_subnets
  fargate_profile_name = var.fargate_profile_name
  namespace = var.namespace
  tags = var.tags
}

module "alb" {
  source = "./modules/alb"
  cluster_name = module.eks.cluster_name
  vpc_id = module.vpc.vpc_id
  region = var.region
}
