assume_role      = "arn:aws:iam::975050053689:role/commons-lpin-dev-shared-services-terraform-role"
cicd_assume_role = "arn:aws:iam::756244784198:role/BeckettInfraCICDRole"

# CI/CD
project_name                = "commons-cornerstone-dev-build"
project_description         = "Cornerstone infrastructure Dev deployment"
build_timeout               = 60
cicd_service_role           = "arn:aws:iam::756244784198:role/service-role/commons-lpin-dev-codebuild-role"
compute_type                = "BUILD_GENERAL1_SMALL"
image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
type                        = "LINUX_CONTAINER"
image_pull_credentials_type = "CODEBUILD"

source_location  = "https://bitbucket.org/bkdefault/cornerstone-infra.git"
environment      = "dev"
event_pattern    = "PUSH"
base_ref_pattern = "development"

# AWS-network
vpc_id                     = "vpc-0aa88c77b07f3b871"
vpc_name                   = "commons-dev-us-east-1-spoke-vpc"
private_subnet_az1_name    = "commons-dev-us-east-1-spoke-vpc-private-subnet-az1"
private_subnet_az2_name    = "commons-dev-us-east-1-spoke-vpc-private-subnet-az2"
devapps_sg_name            = "cor-use1-devapps-sg"
develb_sg_name             = "cor-use1-develb-sg"
transit_gateway_id         = "tgw-04d704e951fc9a5bc"
allowed_cidr_blocks        = ["10.213.132.0/22", "10.0.0.0/8"]

# ECR Repository
repository_names = ["cornerstone-operations-ui-ecr-repo", "cornerstone-user_svc-ecr-repo", "cornerstone-product-ecr-repo", "cornerstone-notification-ecr-repo", "cornerstone-common_svc-ecr-repo"]
scan_on_push     = true
encryption_type  = "AES256"

# Elasticache
cluster_name = "cornerstone-redis-cluster"
node_type    = "cache.t3.medium"

# RDS
db_identifier        = "cornerstone-dev-rds-postgres"
db_instance_class    = "db.t3.medium"
db_name              = "cornerstone_db"
db_engine_version    = "13.16"
db_allocated_storage = 50
db_username          = "dbadmin"
db_password          = "Password123!"

# SNS & SES
sns_topic_name = "cornerstone-notifications-topic"
ses_domain     = "cornerstone.com"

# Logging & Monitoring
ecs_cluster_name              = "cor-use1-dev-cluster"
container_insights            = true
cloudwatch_log_group_name     = "/aws/ecs/cornerstone-dev-cloudwatch-logs"
cloudwatch_log_retention_days = 30
cpu_alarm_name                = "HighCPUUsage"
cpu_comparison_operator       = "GreaterThanThreshold"
cpu_evaluation_periods        = 2
cpu_metric_name               = "CPUUtilization"
cpu_namespace                 = "AWS/ECS"
cpu_period                    = 300
cpu_statistic                 = "Average"
cpu_threshold                 = 80

