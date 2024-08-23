variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "container_insights" {
  description = "Enable container insights for ECS"
  type        = bool
  default     = true
}

variable "environment" {
  description = "The environment (dev, qa, prod, preprod)"
  type        = string
}
