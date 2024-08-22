module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnet_cidrs
  public_subnets  = var.public_subnet_cidrs

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_security_group" "sg" {
  name        = var.sg_name
  description = "Security Group for ${var.vpc_name}"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "Allow SSH from specific CIDRs"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "Allow HTTP from specific CIDRs"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "Allow HTTPS from specific CIDRs"
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "Allow access to RDS (PostgreSQL) from specific CIDRs"
  }

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "Allow access to Redis from specific CIDRs"
  }

  ingress {
    from_port   = 2376
    to_port     = 2376
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "Allow access to Docker from specific CIDRs"
  }

  ingress {
    from_port   = 51678
    to_port     = 51678
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "Allow access to ECS agent from specific CIDRs"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = var.sg_name
  }
}

# SNS Topic
resource "aws_sns_topic" "cornerstone_notifications_topic" {
  name = var.sns_topic_name
}

# SES Email Identity
resource "aws_ses_domain_identity" "notifications" {
  domain = var.ses_domain
}

resource "aws_ses_domain_dkim" "notifications" {
  domain = aws_ses_domain_identity.notifications.domain
}

resource "aws_cloudwatch_log_group" "cornerstone_dev_cloudwatch_logs" {
  name = "/aws/ecs/cornerstone-dev-cloudwatch-logs"
  retention_in_days = 30
  tags = {
    Name = "cornerstone-dev-cloudwatch-logs"
  }
}

resource "aws_ecs_cluster" "this" {
  name = "ecs-${var.environment}-001"

  setting {
    name  = "containerInsights"
    value = var.container_insights ? "enabled" : "disabled"
  }

  tags = {
    Environment = var.environment
  }
}

# CloudWatch Monitoring
resource "aws_cloudwatch_metric_alarm" "high_cpu_alarm" {
  alarm_name          = "HighCPUUsage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    ClusterName = aws_ecs_cluster.this.name
  }

  alarm_actions = [aws_sns_topic.cornerstone_notifications_topic.arn]
  tags = {
    Name = "HighCPUUsage"
  }
}
