data "aws_ami" "ecs" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}

# Use data source to refer to the existing IAM instance profile
data "aws_iam_instance_profile" "ecs" {
  name = "ecsInstance"
}

resource "aws_security_group" "ecs" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Allow RDS access within the VPC
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_role" "ecs_task_execution" {
  name = "ecsTaskExecutionRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy_attachment" "ecs_task_execution" {
  name       = "ecsTaskExecutionPolicy"
  roles      = [aws_iam_role.ecs_task_execution.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_cluster" "main" {
  name = "my-ecs-cluster"
}

resource "aws_launch_configuration" "ecs" {
  name                 = "ecs_launch_configuration"
  image_id             = data.aws_ami.ecs.id
  instance_type        = "t3.micro"
  iam_instance_profile = data.aws_iam_instance_profile.ecs.name
  security_groups      = [aws_security_group.ecs.id]
  user_data            = <<-EOF
    #!/bin/bash
    echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
  EOF
}

resource "aws_autoscaling_group" "ecs" {
  launch_configuration = aws_launch_configuration.ecs.id
  min_size             = 3
  max_size             = 3
  desired_capacity     = 3
  vpc_zone_identifier  = var.private_subnets
  health_check_type    = "EC2"
  health_check_grace_period = 300
}
