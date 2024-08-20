variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "fargate_profile_name" {
  description = "The name of the Fargate profile"
  type        = string
  default     = "production-fargate-profile"
}

variable "namespace" {
  description = "The namespace for the Fargate profile"
  type        = string
  default     = "production"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {
    Environment = "production"
  }
}
