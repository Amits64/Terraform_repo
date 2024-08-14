terraform { 
  cloud { 
    
    organization = "SFBTraining" 

    workspaces { 
      name = "ECS_DEPLOY" 
    } 
  } 
}

provider "aws" {
  region = "us-west-2"
}