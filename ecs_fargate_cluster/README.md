# ECS Cluster with Fargate

This repository contains Terraform scripts to set up an enterprise-grade ECS Fargate cluster on AWS. The setup includes a VPC, subnets, security groups, an ECS cluster, a Fargate service, an Application Load Balancer (ALB), and CloudWatch logging.

## Table of Contents

- [Project Description](#project-description)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Project Description

This project aims to provide a scalable, secure, and highly available ECS Fargate cluster for running containerized applications in a production environment. The infrastructure is defined using Terraform, ensuring reproducibility and ease of management.

## Architecture

The architecture includes:
- A VPC with public subnets
- Security groups for controlling access
- An ECS cluster with Fargate launch type
- An Application Load Balancer (ALB) for distributing traffic
- CloudWatch logging for monitoring and troubleshooting

## Prerequisites

Before you begin, ensure you have the following installed:
- [Terraform](https://www.terraform.io/downloads.html) v1.0.0 or later
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate permissions
- An AWS account with access to create the necessary resources

## Setup Instructions

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your_username/ecs_cluster.git
   cd ecs_cluster
   ```

2. **Initialize Terraform**:
   ```bash
   terraform init
   ```

3. **Review and modify variables**:
   - Edit the `variables.tf` file to customize the configuration as needed.

4. **Apply the Terraform configuration**:
   ```bash
   terraform apply
   ```

5. **Confirm the changes**:
   - Type `yes` when prompted to apply the changes.

## Usage

Once the infrastructure is set up, you can deploy your containerized applications to the ECS cluster. The ALB will distribute incoming traffic to the running tasks.

### Accessing the Application

- The ALB DNS name will be outputted by Terraform. You can use this DNS name to access your application.

### Monitoring and Logging

- CloudWatch logs are configured to capture logs from your ECS tasks. You can view these logs in the AWS Management Console under CloudWatch Logs.

## Contributing

We welcome contributions! Please follow these steps to contribute:

1. Fork the repository
2. Create a new branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m 'Add some feature'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.