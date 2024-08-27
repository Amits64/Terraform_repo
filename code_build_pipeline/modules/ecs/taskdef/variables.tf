variable "taskRoleArn" {
  description = "ARN of the task role"
  type        = string
}

variable "executionRoleArn" {
  description = "ARN of the task execution role"
  type        = string
}

variable "container_definition" {
  description = "Container definition for ECS task"
  type = list(object({
    name      = string
    image     = string
    cpu       = number
    memory    = number
    essential = bool
    portMappings = list(object({
      name          = string
      containerPort = number
      hostPort      = number
      protocol      = string
      appProtocol   = string
    }))
    logConfiguration = object({
      logDriver = string
      options   = map(string)
    })
    healthCheck = object({
      command     = list(string)
      interval    = number
      retries     = number
      startPeriod = number
      timeout     = number
    })
  }))
}

variable "service" {
  description = "Name of the task definition family"
  type        = string
}