variable "db_identifier" {
  description = "The identifier for the RDS instance"
  type        = string
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "db_storage_type" {
  description = "The storage type for the RDS instance"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_engine_version" {
  description = "The version of the PostgreSQL engine"
  type        = string
}

variable "db_allocated_storage" {
  description = "The allocated storage for the RDS instance"
  type        = number
}

variable "db_username" {
  description = "The master username for the RDS instance"
  type        = string
}

variable "db_password" {
  description = "The master password for the RDS instance"
  type        = string
}

variable "devapps_sg_name" {
  description = "SG name"
  type        = list(string)
}

variable "db_subnet_group_name" {
  description = "db_subnet_group_name"
  type        = string
}

variable "subnet_ids" {
  description = "db_subnet_group_name"
  type        = list(string)
}

variable "private_subnet_az1" {
  description = "subnet_name"
  type        = string
}

variable "private_subnet_az2" {
  description = "subnet_name"
  type        = string
}