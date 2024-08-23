output "task_definition_arn" {
  description = "The ARN of the created ECS task definition"
  value       = aws_ecs_task_definition.svc.arn
}