output "ecs_service_name" {
  description = "The name of the ECS service"
  value       = aws_ecs_service.lpin_dev_ecs_service.name
}
