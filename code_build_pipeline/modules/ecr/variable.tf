variable "repository_names" {
  description = "The name of the ECR repository"
  type        = list(string)
}

variable "scan_on_push" {
  description = "Enable image scanning on push"
  type        = bool
  default     = true
}

variable "encryption_type" {
  description = "The encryption type for the repository"
  type        = string
  default     = "AES256"
}
