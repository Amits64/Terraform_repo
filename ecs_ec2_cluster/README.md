# ECS EC2 Cluster Project

![AWS](https://img.shields.io/badge/AWS-EC2-blue)
![Terraform](https://img.shields.io/badge/Terraform-IaC-purple)
![ECS](https://img.shields.io/badge/ECS-Cluster-orange)
![License](https://img.shields.io/badge/License-MIT-green)

## Overview

This project sets up a highly available, secure, multi-AZ ECS EC2 cluster using Terraform. The cluster is designed for production environments, featuring auto-scaling, load balancing, and enhanced security measures.

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Usage](#usage)
- [Modules](#modules)
  - [VPC](#vpc)
  - [ECS](#ecs)
  - [ALB](#alb)
- [Task Definition](#task-definition)
- [Contributing](#contributing)
- [License](#license)

## Prerequisites

- AWS Account
- Terraform installed
- AWS CLI configured
- IAM roles with necessary permissions
- Existing IAM instance profile named `ecsInstanceProfile`

## Setup

### Clone the Repository

```bash
git clone https://github.com/yourusername/ecs-ec2-cluster.git
cd ecs-ec2-cluster
```

### Initialize Terraform

```bash
terraform init
```

### Plan and Apply

```bash
terraform plan
terraform apply
```

## Usage

Once the infrastructure is set up, you can access the NGINX application via the load balancer's DNS name.

### Access the Application

```bash
open http://<ALB-DNS-Name>
```

## Modules

### VPC

The VPC module sets up the network infrastructure, including public and private subnets across multiple availability zones.

### ECS

The ECS module configures the ECS cluster, including security groups, IAM roles, and auto-scaling groups. Note that it uses an existing IAM instance profile named `ecsInstance`.

### ALB

The ALB module sets up the Application Load Balancer to distribute traffic to the ECS tasks.

## Task Definition

The task definition for the NGINX application is defined in a separate JSON file.

```json
[
  {
    "name": "nginx",
    "image": "nginx:latest",
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]
```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.