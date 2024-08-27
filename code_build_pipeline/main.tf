module "codebuild" {
  source = "./modules/codebuild"

  providers = {
    aws = aws.cicd_account
  }

  project_name                = var.project_name
  project_description         = var.project_description
  build_timeout               = var.build_timeout
  cicd_service_role           = var.cicd_service_role
  compute_type                = var.compute_type
  image                       = var.image
  type                        = var.type
  image_pull_credentials_type = var.image_pull_credentials_type
  source_location             = var.source_location

  event_pattern    = var.event_pattern
  base_ref_pattern = var.base_ref_pattern
}

#ECR Repos for both the services
module "aws_ecr_repository" {
  source          = "../../../../modules/ecr"
  repository_names = ["linchpin/product-svc"]
  scan_on_push    = true
}

#Task Definition for both the services
module "aws_ecs_task_def_product_svc" {
  source               = "../../../../modules/ecs/taskdef"
  service              = "product-svc"
  taskRoleArn          = module.ecs_task_execution_role.role_arn
  executionRoleArn     = module.ecs_task_execution_role.role_arn
  container_definition = jsondecode(file("./Task-Definitions/lpin-product-svc-cont-def.json"))
}

module "aws_ecr_repository_notification-svc" {
  source          = "../../../../modules/ecr"
  repository_names = ["linchpin/notification-svc"]
  scan_on_push    = true
}

#Role for ECS Task Ececution
module "ecs_task_execution_role" {
  source             = "../../../../modules/iam"
  role_name          = "commons-lpin-dev-ecsTaskExecutionRole"
  policy_arn         = var.ecs_task_execution_policy_arns
  inline_policy      = "./Policies/Inline-policies/ecs-task-execution-inline-policy.json"
  assume_role_policy = jsondecode(file("./Policies/ecs_task_execution_policy.json"))
}

#Roles for the CodeBuild 
module "codebuild_lpin_notification_svc_role" {
  source             = "../../../../modules/iam"
  role_name          = "codebuild-notification-svc-role"
  policy_arn         = var.codebuild_policy_arns
  inline_policy      = "./Policies/Inline-policies/ecs-task-execution-inline-policy.json"
  assume_role_policy = jsondecode(file("./Policies/codebuild-notification-svc.json"))
}

#Security group for the Task
module "lpin_dev_security_group" {
  source      = "../../../../modules/sg"
  name        = "commons-lpin-dev-sg-ecs-task"
  vpc_id      = var.vpc_id
  description = "Security group for the ECS tasks to run"
}

#Target groups for the ALB
module "lpin_dev_product_svc_tg" {
  source            = "../../../../modules/alb_tg"
  name              = "cmn-lpin-dev-product-tg"
  vpc_id            = var.vpc_id
  health_check_path = "/product/actuator/health"
  tags = {
    "PROJECT" : "lpin"
    "ENV" : "commons-dev"
    "MANAGED_BY" : "terraform"
  }
}

#Application Load Balancer
module "alb_lpin_dev_core" {
  source                        = "../../../../modules/alb"
  name                          = "alb-commons-lpin-dev-core"
  subnets                       = var.subnets
  target_group_product_svc      = module.lpin_dev_product_svc_tg.target_group_arn
  target_group_notification_svc = module.lpin_dev_notification_svc_tg.target_group_arn
  security_groups               = [module.lpin_dev_security_group.security_group_id]
  certificate_arn               = module.acm_certificate.certificate_arn
  tags = {
    "PROJECT" : "linchpin"
    "ENV" : "commons-dev"
    "MANAGED_BY" : "terraform"
  }
}

