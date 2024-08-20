variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "fargate_profile_name" {
  description = "The name of the Fargate profile"
  type        = string
  default     = "production-fargate-profile"
}

variable "subnet_ids" {
  description = "A list of subnet IDs for the Fargate profile"
  type        = list(string)
}

variable "namespace" {
  description = "The namespace for the Fargate profile"
  type        = string
  default     = "production"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
