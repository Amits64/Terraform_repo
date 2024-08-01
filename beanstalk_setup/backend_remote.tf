terraform {
  cloud {
    organization = "SFBTraining"

    workspaces {
      name = "BEANSTALK_DEPLOY"
    }
  }
}