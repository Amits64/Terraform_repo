# EKS Cluster Deployment with Terraform

Welcome to the EKS Cluster Deployment project! This directory contains the comprehensive Terraform configuration required to deploy a robust and scalable Amazon EKS (Elastic Kubernetes Service) cluster on AWS. This setup encompasses VPC creation, EKS cluster provisioning, and the configuration of managed node groups.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Usage](#usage)
  - [Clone the Repository](#clone-the-repository)
  - [Initialize Terraform](#initialize-terraform)
  - [Review the Terraform Plan](#review-the-terraform-plan)
  - [Apply the Terraform Plan](#apply-the-terraform-plan)
- [Configuration Details](#configuration-details)
  - [VPC Module](#vpc-module)
  - [EKS Module](#eks-module)
  - [Providers](#providers)
  - [Backend Configuration](#backend-configuration)
  - [Variables](#variables)
  - [Outputs](#outputs)
- [Advanced Configuration](#advanced-configuration)
  - [Scaling Node Groups](#scaling-node-groups)
  - [Adding More Node Groups](#adding-more-node-groups)
  - [Security and IAM Roles](#security-and-iam-roles)
  - [Monitoring and Logging](#monitoring-and-logging)
  - [Cost Management](#cost-management)
- [Maintenance](#maintenance)
  - [Updating the Cluster](#updating-the-cluster)
  - [Scaling the Cluster](#scaling-the-cluster)
  - [Troubleshooting](#troubleshooting)
- [Resources](#resources)
- [License](#license)
- [Acknowledgements](#acknowledgements)

## Prerequisites

Ensure you have the following tools installed:

- [Terraform](https://www.terraform.io/downloads.html) >= 1.9.3
- AWS CLI configured with appropriate credentials
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [AWS IAM Authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)

## Usage

### Clone the Repository

Clone this repository to your local machine:

```sh
git clone https://github.com/YourUsername/YourRepo.git
cd YourRepo/eks-cluster
```

### Initialize Terraform

Initialize the Terraform working directory. This command will download the necessary provider plugins and modules:

```sh
terraform init
```

### Review the Terraform Plan

Review the resources that will be created by Terraform:

```sh
terraform plan
```

### Apply the Terraform Plan

Apply the configuration to create the resources:

```sh
terraform apply
```

Confirm the apply action by typing `yes`.

## Configuration Details

### VPC Module

The VPC module creates a new VPC along with public and private subnets, NAT Gateway, and associated networking components:

```hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name = "vprofile-eks"
  cidr = "172.20.0.0/16"
  azs  = slice(data.aws_availability_zones.available.names, 0, 3)

  private_subnets = ["172.20.1.0/24", "172.20.2.0/24", "172.20.3.0/24"]
  public_subnets  = ["172.20.4.0/24", "172.20.5.0/24", "172.20.6.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }
}
```

### EKS Module

The EKS module provisions the EKS cluster and managed node groups:

```hcl
module "eks" {
  source  = "terraform-aws-modules/eks/aws"

  cluster_name    = local.cluster_name
  cluster_version = "1.28"

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"

      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }

    two = {
      name = "node-group-2"

      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }
}
```

### Providers

Defines the AWS, Kubernetes, and other necessary providers:

```hcl
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}

provider "aws" {
  region = var.region
}
```

### Backend Configuration

The Terraform state is stored in an S3 bucket:

```hcl
terraform {
  backend "s3" {
    bucket = "terraform-state-files-bkt-001"
    key    = "terraform/eks-backend"
    region = "us-east-1"
  }
}
```

### Variables

Defines input variables for region and cluster name:

```hcl
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "clusterName" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "vprofile-eks"
}
```

### Outputs

Defines outputs for the cluster name, endpoint, region, and security group ID:

```hcl
output "cluster_name" {
  description = "Amazon Web Service EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint for Amazon Web Service EKS "
  value       = module.eks.cluster_endpoint
}

output "region" {
  description = "Amazon Web Service EKS Cluster region"
  value       = var.region
}

output "cluster_security_group_id" {
  description = "Security group ID for the Amazon Web Service EKS Cluster "
  value       = module.eks.cluster_security_group_id
}
```

## Advanced Configuration

### Scaling Node Groups

Adjust the `min_size`, `max_size`, and `desired_size` parameters to scale your node groups:

```hcl
eks_managed_node_groups = {
  one = {
    name = "node-group-1"

    instance_types = ["t3.small"]

    min_size     = 1
    max_size     = 3
    desired_size = 2
  }

  two = {
    name = "node-group-2"

    instance_types = ["t3.small"]

    min_size     = 1
    max_size     = 2
    desired_size = 1
  }
}
```

### Adding More Node Groups

You can add more node groups by defining additional blocks in the `eks_managed_node_groups`:

```hcl
eks_managed_node_groups = {
  three = {
    name = "node-group-3"

    instance_types = ["t3.medium"]

    min_size     = 1
    max_size     = 4
    desired_size = 2
  }
}
```

### Security and IAM Roles

Ensure that your IAM roles and policies are correctly set up to allow the necessary permissions for EKS and node group operations.

### Monitoring and Logging

Integrate monitoring and logging solutions such as CloudWatch, Prometheus, and Grafana to monitor the health and performance of your EKS cluster.

### Cost Management

Use AWS Cost Explorer and set up budget alerts to manage and control the costs associated with running your EKS cluster.

## Maintenance

### Updating the Cluster

To update the EKS cluster version or configuration, modify the respective parameters in the Terraform configuration and apply the changes:

```sh
terraform apply
```

### Scaling the Cluster

Adjust the node group sizes or add/remove node groups as needed and apply the changes:

```sh
terraform apply
```

### Troubleshooting

If you encounter issues, refer to the [Terraform documentation](https://www.terraform.io/docs/) and [AWS EKS documentation](https://docs.aws.amazon.com/eks/) for troubleshooting guidance. Ensure you have the necessary IAM permissions and that your AWS CLI is properly configured.

## Resources

- [Terraform AWS EKS Module](https://github.com/terraform-aws-modules/terraform-aws-eks)
- [Terraform AWS VPC Module](https://github.com/terraform-aws-modules/terraform-aws-vpc)
- [AWS EKS Documentation](https://docs.aws.amazon.com/eks/)
- [Terraform Documentation](https://www.terraform.io/docs/)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [Terraform AWS EKS Module](https://github.com/terraform-aws-modules/terraform-aws-eks)
- [Terraform AWS VPC Module](https://github.com/terraform-aws-modules

/terraform-aws-vpc)
- The open-source community for their invaluable resources and support.

###