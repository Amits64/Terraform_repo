resource "aws_lb_target_group" "ecs_task_alb_tg" {
  name            = var.name
  vpc_id          = var.vpc_id
  target_type     = "ip"
  port            = var.port
  protocol        = var.protocol
  ip_address_type = "ipv4"

  health_check {
    healthy_threshold = var.healthy_threshold
    path              = var.health_check_path
  }

  tags = var.tags
}