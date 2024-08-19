variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "private_subnets" {
  description = "List of private subnet IDs for the VPC"
  type        = list(string)
}

variable "region" {}

variable "security_group_id" {}
