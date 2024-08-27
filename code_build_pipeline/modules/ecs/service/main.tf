resource "aws_ecs_service" "lpin_dev_ecs_service" {
  name                              = var.name
  cluster                           = var.ecs_cluster_arn
  task_definition                   = var.task_definition_arn
  launch_type                       = "FARGATE"
  desired_count                     = 1
  force_new_deployment              = true
  health_check_grace_period_seconds = 200

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = 8080
  }

  network_configuration {
    subnets         = var.subnets
    security_groups = var.security_groups
  }
}
