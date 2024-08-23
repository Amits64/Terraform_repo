terraform {
  cloud {

    organization = "SFBTraining"

    workspaces {
      name = "corner_stone"
    }
  }
}

provider "aws" {
  region = var.region
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.46.0"
    }
  }
}
