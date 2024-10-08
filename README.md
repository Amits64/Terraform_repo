[![Corner_stone](https://github.com/Amits64/Terraform_repo/actions/workflows/corner_stone.yml/badge.svg)](https://github.com/Amits64/Terraform_repo/actions/workflows/corner_stone.yml)
[![EKS_Deployment](https://github.com/Amits64/Terraform_repo/actions/workflows/eks.yml/badge.svg?branch=main)](https://github.com/Amits64/Terraform_repo/actions/workflows/eks.yml)
[![ECS Fargate](https://github.com/Amits64/Terraform_repo/actions/workflows/ecs_fargate.yml/badge.svg?branch=main)](https://github.com/Amits64/Terraform_repo/actions/workflows/ecs_fargate.yml)
[![ECS EC2](https://github.com/Amits64/Terraform_repo/actions/workflows/ecs_ec2.yml/badge.svg)](https://github.com/Amits64/Terraform_repo/actions/workflows/ecs_ec2.yml)
[![EBS_Deployment](https://github.com/Amits64/Terraform_repo/actions/workflows/beanstalk.yml/badge.svg)](https://github.com/Amits64/Terraform_repo/actions/workflows/beanstalk.yml)
[![AWS_Setup_Deployment](https://github.com/Amits64/Terraform_repo/actions/workflows/aws_setup.yml/badge.svg)](https://github.com/Amits64/Terraform_repo/actions/workflows/aws_setup.yml)
![Known Vulnerabilities](https://snyk.io/test/github/{username}/{repo}/badge.svg)
## Terraform Repository for AWS Infrastructure Deployment ##

Welcome to the Terraform repository for deploying AWS infrastructure. This repository contains all the necessary configurations and scripts to set up and manage a robust and scalable environment using various AWS services.

## Table of Contents

- [Introduction](#introduction)
- [Architectural Design](#architectural-design)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Reusable Workflows](#reusable-workflows)
- [Usage](#usage)
- [Configuration](#configuration)
- [Modules](#modules)
- [Examples](#examples)
- [Testing](#testing)
- [Deployment](#deployment)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Introduction

This project automates the provisioning and deployment of AWS infrastructure using Terraform. The infrastructure can include:

- AWS EC2 for compute instances.
- AWS RDS for database management.
- AWS S3 for storage.
- AWS VPC for network segmentation.
- AWS IAM for access control.
- AWS Elastic Beanstalk for application deployment.
- AWS MQ for messaging.

## Architectural Design
![image](https://github.com/user-attachments/assets/56c21726-e1ff-49b8-8652-e3de073f377b)


## Prerequisites

Before you begin, ensure you have the following:

- An AWS account with appropriate permissions.
- Terraform installed on your local machine.
- AWS CLI configured with your AWS credentials.
- SSH key pair for accessing EC2 instances.

### Tools and Technologies

- **Terraform**: Infrastructure as Code (IaC) tool used for provisioning the AWS resources.
- **AWS EC2**: Compute instances for application servers.
- **AWS RDS**: Managed relational database service.
- **AWS S3**: Scalable storage service.
- **AWS VPC**: Virtual Private Cloud for network isolation.
- **AWS IAM**: Identity and Access Management for security.
- **AWS Elastic Beanstalk**: Managed service for deploying and scaling web applications.
- **AWS MQ**: Managed message broker service.

## Installation

### Step 1: Clone the Repository

```sh
git clone https://github.com/yourusername/Terraform_repo.git
cd Terraform_repo
```

### Step 2: Configure AWS CLI

Ensure your AWS CLI is configured with the necessary credentials:

```sh
aws configure
```

### Step 3: Initialize Terraform

Initialize the Terraform working directory:

```sh
terraform init
```

## Reusable Workflows

The repository includes reusable GitHub Actions workflows to streamline and automate the deployment and management of AWS infrastructure. These workflows are designed to be modular and reusable across different repositories and projects.

### Available Workflows

1. **EKS Deployment Workflow**

   - **Filename**: `.github/workflows/eks.yml`
   - **Purpose**: Automates the deployment of Amazon EKS clusters.
   - **Usage**: This workflow handles the creation and management of Kubernetes clusters in AWS, including updating kubeconfig and installing required components such as the Ingress Controller.

2. **EBS Deployment Workflow**

   - **Filename**: `.github/workflows/beanstalk.yml`
   - **Purpose**: Manages the deployment of AWS Elastic Beanstalk applications.
   - **Usage**: Use this workflow to deploy and manage Elastic Beanstalk environments for your applications, including configuration updates and environment management.

3. **AWS Setup Workflow**

   - **Filename**: `.github/workflows/aws_setup.yml`
   - **Purpose**: Sets up initial AWS infrastructure and configurations.
   - **Usage**: This workflow initializes essential AWS resources and configurations needed for other workflows or applications, such as creating IAM roles or setting up network components.

### How to Use Reusable Workflows

To leverage these workflows in your own repositories, follow these steps:

1. **Reference the Workflow**

   In your `.github/workflows` directory, create a YAML file that calls the reusable workflow:

   ```yaml
   name: Example Deployment

   on:
     push:
       branches:
         - main

   jobs:
     deploy:
       uses: Amits64/shared_library/.github/workflows/terraform-setup.yml@main
       with:
         aws-region: ${{ secrets.AWS_REGION }}
         tf-cloud-token: ${{ secrets.TF_CLOUD_TOKEN }}
         aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
         aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
   ```

2. **Provide Required Inputs**

   Ensure you provide all necessary inputs for the workflow, such as AWS credentials, region, and any other required parameters. These should be configured as GitHub secrets in your repository.

3. **Monitor Workflow Runs**

   Check the Actions tab in your GitHub repository to monitor the execution and status of the workflows. Logs and statuses will provide insights into the progress and outcomes of the workflows.

### Benefits of Reusable Workflows

- **Consistency**: Ensure uniform deployment practices across different projects and repositories.
- **Efficiency**: Save time by reusing established workflows rather than recreating them for each project.
- **Maintainability**: Simplify updates and changes to workflows by centralizing them in a shared repository.


## Usage

### Step 1: Customize Variables

Update the `variables.tf` file with your specific values, such as:

- AWS region
- VPC ID
- Subnet IDs
- Security group IDs
- Key pair name
- S3 bucket names

### Step 2: Plan the Deployment

Generate and review the execution plan:

```sh
terraform plan
```

### Step 3: Apply the Configuration

Apply the Terraform configuration to provision the resources:

```sh
terraform apply
```

### Step 4: Verify the Deployment

Verify that all resources have been provisioned correctly by checking the AWS Management Console.

## Configuration

### Variables

This repository uses a `variables.tf` file to manage input variables. Key variables include:

- `aws_region`: The AWS region to deploy resources.
- `vpc_id`: The ID of the VPC.
- `public_subnets`: List of public subnet IDs.
- `private_subnets`: List of private subnet IDs.
- `instance_type`: The EC2 instance type.
- `key_name`: The name of the SSH key pair.
- `db_username`: The database username.
- `db_password`: The database password.

### Sensitive Information

Sensitive information such as database passwords and API keys should be stored in environment variables or a secrets management tool rather than hardcoded in the Terraform files.

## Modules

### VPC Module

Manages the VPC, subnets, and associated networking components.

### EC2 Module

Handles the provisioning of EC2 instances.

### RDS Module

Manages the setup of the RDS database.

### S3 Module

Manages S3 buckets and related configurations.

### IAM Module

Handles the creation and management of IAM roles, policies, and users.

### Elastic Beanstalk Module

Automates the deployment of the Elastic Beanstalk environment.

### MQ Module

Manages AWS MQ for messaging.

## Examples

### Example 1: Simple EC2 Deployment

A basic example of deploying EC2 instances with minimal configuration.

```hcl
module "vpc" {
  source = "./modules/vpc"
  ...
}

module "ec2" {
  source = "./modules/ec2"
  ...
}
```

### Example 2: Advanced Configuration

A more complex example with custom IAM roles, policies, and additional security configurations.

```hcl
module "vpc" {
  source = "./modules/vpc"
  ...
}

module "ec2" {
  source = "./modules/ec2"
  ...
}

resource "aws_iam_role" "example" {
  ...
}
```

## Testing

### Step 1: Validate Terraform Files

Validate the syntax of the Terraform files:

```sh
terraform validate
```

### Step 2: Run Terraform Plan

Generate the execution plan to ensure there are no errors:

```sh
terraform plan
```

### Step 3: Apply in a Sandbox Environment

Deploy the configuration in a non-production environment to test.

## Deployment

### Step 1: Production Deployment

Once tested, apply the configuration to the production environment:

```sh
terraform apply -var 'environment=prod'
```

### Step 2: Monitoring

Monitor the resources and application using AWS CloudWatch and other relevant AWS monitoring services.

## Troubleshooting

### Common Issues

- **Error: Subnet not found**: Ensure the subnet IDs are correct and exist in your VPC.
- **Permission Denied**: Verify IAM roles and policies have the necessary permissions.

### Logs

Check the logs in AWS services such as CloudWatch, Elastic Beanstalk, and RDS for detailed error messages.

## Contributing

### How to Contribute

1. Fork the repository.
2. Create a staging branch (`git checkout -b staging`).
3. Commit your changes (`git commit -m 'Add some changes'`).
4. Push to the branch (`git push origin staging`).
5. Create a new Pull Request.

### Code of Conduct

Please adhere to the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md).

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

For any questions or support, please reach out to:

- **Name**: Amit Singh
- **Email**: chauhanamit090@hotmail.com
- **LinkedIn**: [Amit Singh](https://www.linkedin.com/in/amit-singh-9a4b7184/)
