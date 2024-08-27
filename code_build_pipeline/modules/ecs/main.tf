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
