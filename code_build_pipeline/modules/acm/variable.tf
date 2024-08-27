variable "tags" {
  description = "Map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "domain_name" {
  description = "Primary domain name for the ACM certificate"
  type        = string
}

variable "wildcard_domain_name" {
  description = "Wildcard domain name for the ACM certificate"
  type        = string
}
