variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "fargate_profile_name" {
  description = "The name of the Fargate profile"
  type        = string
  default     = "example"
}

variable "pod_execution_role_arn" {
  description = "The ARN of the pod execution role"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs for the Fargate profile"
  type        = list(string)
}

variable "namespace" {
  description = "The namespace for the Fargate profile"
  type        = string
  default     = "default"
}
