# Kops & EKS Lab

This repository contains Terraform configurations and setup scripts to create and manage Kubernetes clusters using Kops and EKS on AWS.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Setup Kops Cluster](#setup-kops-cluster)
- [Setup EKS Cluster](#setup-eks-cluster)
- [Terraform Configuration](#terraform-configuration)
- [Scripts](#scripts)
- [Cleaning Up](#cleaning-up)

## Prerequisites

Before you begin, ensure you have the following installed:

- [AWS CLI](https://aws.amazon.com/cli/)
- [Kops](https://github.com/kubernetes/kops)
- [eksctl](https://eksctl.io/)
- [Terraform](https://www.terraform.io/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

## Setup Kops Cluster

### Create Kops Cluster

1. Create the Kops cluster:
    ```sh
    kops create cluster --name=kubevpro.devops-tech.xyz --state=s3://devops-tech-bkt-001 --zones=us-east-1a,us-east-1b --node-count=2 --node-size=t3.small --master-size=t3.medium --dns-zone=kubevpro.devops-tech.xyz --node-volume-size=8 --master-volume-size=8
    ```

2. Update the Kops cluster:
    ```sh
    kops update cluster --name kubevpro.devops-tech.xyz --state=s3://devops-tech-bkt-001 --yes --admin
    ```

3. Validate the Kops cluster:
    ```sh
    kops validate cluster --state=s3://devops-tech-bkt-001
    ```

### Delete Kops Cluster

To delete the Kops cluster:
```sh
kops delete cluster --name=kubevpro.devops-tech.xyz --state=s3://devops-tech-bkt-001 --yes
```

## Setup EKS Cluster

### Create EKS Cluster

1. Create the EKS cluster:
    ```sh
    eksctl create cluster --name k8s-cluster --region us-east-1
    ```

2. Create a node group:
    ```sh
    eksctl create nodegroup --cluster k8s-cluster --node-type t2.medium --nodes 2 --nodes-min 1 --nodes-max 3 --name my-nodegroup
    ```

3. Scale the node group:
    ```sh
    eksctl scale nodegroup --cluster k8s-cluster --nodes 5 --name my-nodegroup
    ```

4. Associate IAM OIDC provider:
    ```sh
    eksctl utils associate-iam-oidc-provider --region us-east-1 --cluster k8s-cluster
    ```

5. Create IAM service account:
    ```sh
    eksctl create iamserviceaccount --region us-east-1 --name my-serviceaccount --namespace default --cluster k8s-cluster --attach-policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --approve
    ```

### Update EKS Cluster

Update the EKS cluster:
```sh
eksctl update cluster --name k8s-cluster
```

### Delete EKS Cluster

To delete the EKS cluster:
```sh
eksctl delete cluster --name k8s-cluster
```

## Terraform Configuration

### AWS Provider Configuration

```hcl
provider "aws" {
  region = "us-east-1"
}
```

### Create VPC, Subnet, Internet Gateway, and Route Table

```hcl
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
```

### Create Security Group

```hcl
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kops-sg"
  }
}
```

### Create EC2 Instances

```hcl
resource "aws_instance" "kops" {
  ami                    = "ami-04a81a99f5ec58529" # Ubuntu 24.04 LTS AMI
  instance_type          = "t2.medium"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  subnet_id              = aws_subnet.public.id
  user_data              = file("${path.module}/kops_script.sh")

  tags = {
    Name = "kops-instance"
  }
}
```

### Create S3 Bucket for Kops State Store

```hcl
resource "aws_s3_bucket" "my_bkt" {
  bucket = "devops-tech-bkt-001"

  tags = {
    Name        = "kops_bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_public_access_block" "my_bkt" {
  bucket = aws_s3_bucket.my_bkt.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
```

### Create IAM User and Policy for Kops

```hcl
resource "aws_iam_user" "kops_user" {
  name = "kops_user"
  path = "/"

  tags = {
    tag-key = "kops_user"
  }
}

resource "aws_iam_policy" "kops_policy" {
  name        = "kops_policy"
  description = "Kops policy for managing cluster"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "*"
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "kops_user_attach" {
  user       = aws_iam_user.kops_user.name
  policy_arn = aws_iam_policy.kops_policy.arn
}
```

### Outputs

```hcl
output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "kops_public_ip" {
  value = aws_instance.kops.public_ip
}
```

## Scripts

### Kops Setup Script

```bash
#!/bin/bash
# Update the package list
sudo apt-get update -y

# Install necessary dependencies
sudo apt-get install -y wget unzip

# Download kops
wget https://github.com/kubernetes/kops/releases/download/v1.24.0/kops-linux-amd64

# Make kops executable
chmod +x kops-linux-amd64

# Move kops to /usr/local/bin
sudo mv kops-linux-amd64 /usr/local/bin/kops

# Verify installation
kops version
```

### EKS Setup Script

```bash
#!/bin/bash
# Update the package list
sudo apt-get update -y

# Install necessary dependencies
sudo apt-get install -y curl unzip

# Download eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

# Move eksctl to /usr/local/bin
sudo mv /tmp/eksctl /usr/local/bin

# Verify eksctl installation
eksctl version

# Download and install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Verify AWS CLI installation
aws --version
```

## Cleaning Up

### Delete Kops Cluster

To delete the Kops cluster:
```sh
kops delete cluster --name=kubevpro.devops-tech.xyz --state=s3://devops-tech

-bkt-001 --yes
```

### Delete EKS Cluster

To delete the EKS cluster:
```sh
eksctl delete cluster --name k8s-cluster
```

### Destroy Terraform Resources

To destroy all Terraform resources:
```sh
terraform destroy
```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or additions.

## License

This project is licensed under the MIT License.
