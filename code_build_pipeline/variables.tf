variable "region" {
  default = "us-east-1"
}

variable "assume_role" {
  description = "ARN of the role to be assumed by the terraform"
  type        = string
}

variable "cicd_assume_role" {
  description = "ARN of the role to be assumed by the terraform"
  type        = string
}

variable "project_name" {
  description = "The name of the CodeBuild project."
  type        = string
}

variable "project_description" {
  description = "A brief description of the CodeBuild project."
  type        = string
}

variable "build_timeout" {
  description = "The maximum amount of time, in minutes, that CodeBuild will allow a build to run."
  type        = number
}

variable "cicd_service_role" {
  description = "ARN of the role to be assumed by the CodeBuild"
  type        = string
}

variable "compute_type" {
  description = "The type of compute environment to use for this build project. See AWS CodeBuild documentation for available options."
  type        = string
}

variable "image" {
  description = "The Docker image to use for this build project."
  type        = string
}

variable "type" {
  description = "The type of build environment to use for this build project. Valid values are: LINUX_CONTAINER, WINDOWS_CONTAINER."
  type        = string
}

variable "image_pull_credentials_type" {
  description = "The type of credentials AWS CodeBuild uses to pull images in your build. Valid values are: CODEBUILD, SERVICE_ROLE."
  type        = string
}

variable "source_location" {
  description = "The location of the source code to be built. This is a fully qualified URL."
  type        = string
}

variable "environment" {
  description = "The environment tag to apply to the CodeBuild project."
  type        = string
}

variable "enable_webhook" {
  description = "Whether to enable the CodeBuild webhook for automatic builds."
  type        = bool
  default     = true
}

variable "event_pattern" {
  type        = string
  description = "Specify the one event: PUSH, PULL_REQUEST_CREATED, PULL_REQUEST_UPDATED, PULL_REQUEST_REOPENED. PULL_REQUEST_MERGED"
}

variable "base_ref_pattern" {
  type        = string
  description = "Specify the base ref patter"
}

variable "vpc_id" {
  description = "The name of the VPC"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "private_subnet_az1_name" {
  description = "The name of the private subnet in AZ1"
  type        = string
}

variable "private_subnet_az2_name" {
  description = "The name of the private subnet in AZ2"
  type        = string
}

variable "devapps_sg_name" {
  description = "Name of the security group for dev applications"
  type        = string
}

variable "develb_sg_name" {
  description = "Name of the security group for development ELB"
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "Allowed CIDR blocks for ingress rules"
  type        = list(string)
}

variable "transit_gateway_id" {
  description = "Transit gateway id"
  type        = string
}

variable "repository_names" {
  description = "ECR Repositories for cornerstone-dev"
  type = list(string)
}

variable "scan_on_push" {
  type = bool
}

variable "encryption_type" {
  description = "Type of Encryption used"
  type = string
}

variable "db_identifier" {
  description = "The identifier for the RDS instance"
  type        = string
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance"
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

variable "cluster_name" {
  description = "The name of the Redis cluster"
  type        = string
}

variable "node_type" {
  description = "The instance type of the Redis nodes"
  type        = string
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
  description = "Name of ECS cluster"
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
