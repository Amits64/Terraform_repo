variable "cluster_name" {
  description = "The name of the ElastiCache replication group"
  type        = string
}

variable "description" {
  description = "Description of the ElastiCache replication group"
  type        = string
}

variable "node_type" {
  description = "The instance type of the cache nodes"
  type        = string
}

variable "num_cache_clusters" {
  description = "The number of cache clusters"
  type        = number
}

variable "automatic_failover_enabled" {
  description = "Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails"
  type        = bool
}

variable "multi_az_enabled" {
  description = "Specifies whether to enable Multi-AZ support for the replication group"
  type        = bool
}

variable "engine" {
  description = "The name of the cache engine to be used for the clusters"
  type        = string
}

variable "engine_version" {
  description = "The version number of the cache engine to be used for the clusters"
  type        = string
}

variable "port" {
  description = "The port number on which each of the cache nodes will accept connections"
  type        = number
}

variable "parameter_group_name" {
  description = "The name of the parameter group to associate with this replication group"
  type        = string
}

variable "subnet_group_name" {
  description = "The name of the cache subnet group"
  type        = string
}

variable "subnet_ids" {
  description = "A list of VPC subnet IDs for the cache subnet group"
  type        = list(string)
}

variable "devapps_sg_name" {
  description = "One or more VPC security groups associated with the cache clusters"
  type        = list(string)
}

variable "final_snapshot_identifier" {
  description = "The name of the final snapshot that is created when the replication group is deleted"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
}

variable "subnet_tags" {
  description = "A mapping of tags to assign to the subnet group"
  type        = map(string)
}
