terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.60.0" # Ensure this is compatible with your other modules and requirements
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
      prefix = "EKS_DEPLOY"
    }
  }

  required_version = "~> 1.9.3"
}
