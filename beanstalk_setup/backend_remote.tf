terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "SFBTraining"

    workspaces {
      name = "BEANSTALK_DEPLOY"
    }
  }
}