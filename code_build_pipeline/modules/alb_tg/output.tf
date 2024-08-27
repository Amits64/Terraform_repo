output "target_group_arn" {
  description = "The ARN of the load balancer target group"
  value       = aws_lb_target_group.ecs_task_alb_tg.arn
}