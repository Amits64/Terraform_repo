variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "container_insights" {
  description = "Whether to enable Amazon ECS container insights for the cluster"
  type        = bool
  default     = true
}

variable "environment" {
  description = "The environment (dev, qa, prod, preprod)"
  type        = string
}
