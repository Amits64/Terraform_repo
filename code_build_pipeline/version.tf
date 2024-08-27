provider "aws" {
  region = var.region
  assume_role {
    role_arn = var.assume_role
  }
}

provider "aws" {
  alias  = "cicd_account"
  region = var.region
  assume_role {
    role_arn = var.cicd_assume_role
  }
}


terraform {
  required_version = ">= 1.2.4"

  backend "s3" {
    region         = "us-east-1"
    bucket         = "cornerstone-shared-terraform-state"
    key            = "terraform.tfstate"
    dynamodb_table = "cornerstone-shared-terraform-state-lock"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.46.0"
    }
  }
}
