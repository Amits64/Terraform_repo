variable "name" {
  description = "Name of the Load Balancer"
  type        = string
}

variable "security_groups" {
  description = "List of security group IDs to assign to the ALB"
  type        = list(string)
}

variable "target_group_product_svc" {
  description = "Target group arn to assign to the listener port"
  type        = string
}

variable "target_group_notification_svc" {
  description = "Target group arn to assign to the listener port"
  type        = string
}

variable "subnets" {
  description = "Subnets ids"
  type        = list(string)
}

variable "certificate_arn" {
  description = "ARN of the SSL/TLS Certificate"
  type        = string
}

variable "tags" {
  description = "Map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}