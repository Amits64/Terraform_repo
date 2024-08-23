variable "name" {
  description = "Name of the service"
  type        = string
}

variable "ecs_cluster_arn" {
  description = "ARN of the cluster"
  type        = string
}

variable "task_definition_arn" {
  description = "ARN of the task definition"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the target group"
  type        = string
}

variable "subnets" {
  description = "Subnet ids"
  type        = list(string)
}

variable "container_name" {
  description = "Name of the container to associate with the load balancer"
  type        = string
}

variable "security_groups" {
  description = "List of security group IDs to assign to the ALB"
  type        = list(string)
}

variable "tags" {
  description = "Map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}