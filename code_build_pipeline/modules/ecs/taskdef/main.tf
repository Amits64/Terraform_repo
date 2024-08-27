resource "aws_ecs_task_definition" "svc" {
  family                   = "lpin-${var.service}-fargate"
  cpu                      = "2048"
  memory                   = "5120"
  task_role_arn            = var.taskRoleArn
  execution_role_arn       = var.executionRoleArn
  container_definitions    = jsonencode(var.container_definition)
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }
  network_mode = "awsvpc"
  tags = {
    "ENV" = "lpin-dev"
  }
}
