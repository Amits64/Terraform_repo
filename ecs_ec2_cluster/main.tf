terraform {
  cloud {

    organization = "SFBTraining"

    workspaces {
      name = "ECS_EC2_DEPLOY"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source            = "./modules/vpc"
  region            = var.region
  security_group_id = module.ecs.security_group_id
  private_subnets   = module.vpc.private_subnets
}

module "ecs" {
  source          = "./modules/ecs"
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  private_subnets = module.vpc.private_subnets
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnets    = module.vpc.public_subnets
  security_group_id = module.ecs.security_group_id
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
}

module "rds" {
  source            = "./modules/rds"
  db_identifier     = "my-db-instance"
  username          = "admin"
  password          = "password"
  private_subnets   = module.vpc.private_subnets
  security_group_id = module.ecs.security_group_id
}

resource "aws_ecs_task_definition" "nginx" {
  family                   = "nginx"
  network_mode             = "awsvpc"
  requires_compatibilities = ["EC2"]
  cpu                      = "256"
  memory                   = "512"
  container_definitions    = file("${path.module}/task_definition/nginx_task_definition.json")
}

resource "aws_ecs_service" "nginx" {
  name            = "nginx-service"
  cluster         = module.ecs.cluster_id
  task_definition = aws_ecs_task_definition.nginx.arn
  desired_count   = 3
  launch_type     = "EC2"
  network_configuration {
    subnets         = module.vpc.private_subnets
    security_groups = [module.ecs.security_group_id]
  }
  load_balancer {
    target_group_arn = module.alb.target_group_arn
    container_name   = "nginx"
    container_port   = 80
  }
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
}
