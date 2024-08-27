variable "project_name" {
  description = "The name of the CodeBuild project."
  type        = string
  default     = "commons-lpin-dev-product-build"
}

variable "project_description" {
  description = "A brief description of the CodeBuild project."
  type        = string
  default     = "LinchPin Product build for Dev"
}

variable "build_timeout" {
  description = "The maximum amount of time, in minutes, that CodeBuild will allow a build to run."
  type        = number
  default     = 60
}

variable "cicd_service_role" {
  description = "The ARN of the IAM role that enables CodeBuild to interact with other AWS services on your behalf."
  type        = string
}

variable "compute_type" {
  description = "The type of compute environment to use for this build project. See AWS CodeBuild documentation for available options."
  type        = string
  default     = "BUILD_GENERAL1_SMALL"
}

variable "image" {
  description = "The Docker image to use for this build project."
  type        = string
  default     = "aws/codebuild/standard:7.0"
}

variable "type" {
  description = "The type of build environment to use for this build project. Valid values are: LINUX_CONTAINER, WINDOWS_CONTAINER."
  type        = string
  default     = "LINUX_CONTAINER"
}

variable "image_pull_credentials_type" {
  description = "The type of credentials AWS CodeBuild uses to pull images in your build. Valid values are: CODEBUILD, SERVICE_ROLE."
  type        = string
  default     = "CODEBUILD"
}

variable "environment_variables" {
  description = "A map of environment variables to set in the build environment."
  type        = map(string)
  default     = {}
}

variable "source_location" {
  description = "The location of the source code to be built. This is a fully qualified URL."
  type        = string
}

variable "environment" {
  description = "The environment tag to apply to the CodeBuild project."
  type        = string
  default     = "Dev"
}

variable "enable_webhook" {
  description = "Whether to enable the CodeBuild webhook for automatic builds."
  type        = bool
  default     = true
}

variable "event_pattern" {
  type        = string
  description = "Specify the one event: PUSH, PULL_REQUEST_CREATED, PULL_REQUEST_UPDATED, PULL_REQUEST_REOPENED. PULL_REQUEST_MERGED."
  default     = ""
}

variable "base_ref_pattern" {
  type        = string
  description = "Specify the base ref pattern."
  default     = ""
}
