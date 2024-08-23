variable "region" {
  default = "us-east-1"
}

variable "source_location" {
  description = "The location of the source code to be built. This is a fully qualified URL."
  type        = string
}

variable "environment" {
  description = "The environment tag to apply to the CodeBuild project."
  type        = string
}

variable "base_ref_pattern" {
  description = "Specify the base ref pattern"
  type        = string
}

variable "event_pattern" {
  description = "Specify the event pattern for CodeBuild webhook"
  type        = string
}

variable "enable_webhook" {
  description = "Whether to enable the CodeBuild webhook for automatic builds."
  type        = bool
  default     = true
}

variable "vpc_name" {
  description = "Name of the VPC"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
}

variable "availability_zones" {
  description = "Availability zones for the subnets"
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
}

variable "igw_name" {
  description = "Name of the Internet Gateway"
}

variable "nat_gw_name" {
  description = "Name of the NAT Gateway"
}

variable "sg_name" {
  description = "Name of the Security Group"
}

variable "allowed_cidr_blocks" {
  description = "List of allowed CIDR blocks for inbound traffic"
}

variable "repository_names" {
  description = "ECR Repositories for cornerstone-dev"
  type        = list(string)
}

variable "scan_on_push" {
  type    = bool
  default = false
}

variable "encryption_type" {
  description = "Type of Encryption used"
  type        = string
  default     = "KMS"
}

variable "db_identifier" {
  description = "The identifier for the RDS instance"
  type        = string
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t3.micro"
}

variable "db_engine_version" {
  description = "The version of the database engine (e.g., PostgreSQL, MySQL)"
  type        = string
  default     = "12.5" # Example for PostgreSQL, adjust as needed
}

variable "db_name" {
  description = "The name of the database"
  type        = string
  default     = "mydatabase" # Example database name, adjust as needed
}

variable "db_username" {
  description = "The master username for the RDS instance"
  type        = string
  default     = "admin" # Example username, adjust as needed
}

variable "db_password" {
  description = "The master password for the RDS instance"
  type        = string
  default     = "password" # Example password, adjust as needed
}


variable "db_allocated_storage" {
  description = "The allocated storage for the RDS instance"
  type        = number
  default     = 20
}

variable "cluster_name" {
  description = "The name of the Redis cluster"
  type        = string
}

variable "node_type" {
  description = "The instance type of the Redis nodes"
  type        = string
  default     = "cache.t3.micro"
}

variable "sns_topic_name" {
  description = "Name of the SNS topic"
  type        = string
}

variable "ses_domain" {
  description = "Domain for SES"
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "container_insights" {
  description = "Enable container insights for ECS"
  type        = bool
  default     = true
}

variable "cloudwatch_log_group_name" {
  description = "The name of the CloudWatch Log Group"
  type        = string
}

variable "cloudwatch_log_retention_days" {
  description = "The number of days to retain CloudWatch logs"
  type        = number
  default     = 30
}

variable "cpu_alarm_name" {
  description = "The name of the CPU usage alarm"
  type        = string
}

variable "cpu_comparison_operator" {
  description = "The comparison operator for the CPU usage alarm"
  type        = string
  default     = "GreaterThanThreshold"
}

variable "cpu_evaluation_periods" {
  description = "The number of evaluation periods for the CPU usage alarm"
  type        = number
  default     = 2
}

variable "cpu_metric_name" {
  description = "The metric name for the CPU usage alarm"
  type        = string
  default     = "CPUUtilization"
}

variable "cpu_namespace" {
  description = "The namespace for the CPU usage alarm"
  type        = string
  default     = "AWS/ECS"
}

variable "cpu_period" {
  description = "The period in seconds for the CPU usage alarm"
  type        = number
  default     = 300
}

variable "cpu_statistic" {
  description = "The statistic for the CPU usage alarm"
  type        = string
  default     = "Average"
}

variable "cpu_threshold" {
  description = "The threshold for the CPU usage alarm"
  type        = number
  default     = 80
}
