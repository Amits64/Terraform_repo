# CodeBuild Project Module (deployed in the CI/CD account)
resource "aws_codebuild_project" "this" {
  name          = var.project_name
  description   = var.project_description
  build_timeout = var.build_timeout
  service_role  = var.cicd_service_role

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = var.compute_type
    image                       = var.image
    type                        = var.type
    image_pull_credentials_type = var.image_pull_credentials_type

    dynamic "environment_variable" {
      for_each = var.environment_variables
      content {
        name  = environment_variable.key
        value = environment_variable.value
      }
    }
  }

  logs_config {

    cloudwatch_logs {
      status = "ENABLED"
    }
  }

  source {
    type                = "BITBUCKET"
    location            = var.source_location
    git_clone_depth     = 1
    report_build_status = true
    buildspec           = "buildspec.yml"
  }

  source_version = var.base_ref_pattern

  tags = {
    Environment = var.environment
    Created_by  = "Terraform"
  }
}

resource "aws_codebuild_webhook" "this" {
  count        = var.enable_webhook ? 1 : 0
  project_name = aws_codebuild_project.this.name
  build_type   = "BUILD"
  filter_group {
    filter {
      type    = "EVENT"
      pattern = var.event_pattern
    }

    filter {
      type    = "HEAD_REF"
      pattern = var.base_ref_pattern
    }
  }
}
