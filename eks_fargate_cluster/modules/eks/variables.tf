variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "production-eks-cluster"
}

variable "cluster_version" {
  description = "The Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.28"
}

variable "subnet_ids" {
  description = "A list of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID for the EKS cluster"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {
    Name = "production-eks-cluster"
  }
}
