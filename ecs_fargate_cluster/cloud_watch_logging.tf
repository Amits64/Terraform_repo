resource "aws_ecs_task_definition" "app_with_logging" {
  family                   = "my-app-with-logging"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name      = "my-app"
    image     = "nginx"
    essential = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "/ecs/my-app"
        awslogs-region        = "us-west-2"
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
}
