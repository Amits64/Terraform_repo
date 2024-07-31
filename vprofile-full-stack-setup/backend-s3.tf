terraform {
  backend "s3" {
    bucket = "terraform-state-files-bkt-001"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}