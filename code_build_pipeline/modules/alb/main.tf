resource "aws_lb" "ecs_service_alb" {
  name                       = var.name
  internal                   = true
  load_balancer_type         = "application"
  ip_address_type            = "ipv4"
  security_groups            = var.security_groups
  subnets                    = var.subnets
  enable_deletion_protection = false

  tags = var.tags
}

resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.ecs_service_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Path not found"
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener_rule" "product_rule" {
  listener_arn = aws_lb_listener.https_listener.arn
  priority     = 1
  action {
    type             = "forward"
    target_group_arn = var.target_group_product_svc
  }
  condition {
    path_pattern {
      values = ["/product*"]
    }
  }
  tags = var.tags
}

resource "aws_lb_listener_rule" "notification_rule" {
  listener_arn = aws_lb_listener.https_listener.arn
  priority     = 2
  action {
    type             = "forward"
    target_group_arn = var.target_group_notification_svc
  }
  condition {
    path_pattern {
      values = ["/notification*"]
    }
  }
  tags = var.tags
}
