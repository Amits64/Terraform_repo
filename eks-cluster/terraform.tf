terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.61.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.2"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23.0"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "SFBTraining"

    workspaces {
      name = "EKS_DEPLOY"
    }
  }

  required_version = "~> 1.9.3"
}

provider "aws" {
  region = var.aws_region
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.22.0"
  # Other module configurations
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.12.0"
  # Other module configurations
}
