source_location  = "https://github.com/Amits64/Terraform_repo.git"
environment      = "dev"
event_pattern    = "PUSH"
base_ref_pattern = "development"

# AWS-network
vpc_name             = "cor-use1-dev-vpc"
vpc_cidr             = "10.13.0.0/16"
availability_zones   = ["us-east-1a", "us-east-1b", "us-east-1c"]
private_subnet_cidrs = ["10.13.2.0/24", "10.13.5.0/24", "10.13.8.0/24"]
public_subnet_cidrs  = ["10.13.1.0/24", "10.13.4.0/24", "10.13.7.0/24"]
igw_name             = "cor-use1-dev-igw"
nat_gw_name          = "cor-use1-dev-nat-gw"
sg_name              = "cor-use1-dev-sg"
allowed_cidr_blocks  = ["10.213.132.0/22", "10.30.0.0/16", "219.65.62.58/32", "120.72.91.234/32", "182.72.113.226/32", "52.3.32.249/32"]

# ECR Repository
repository_names = ["cornerstone-operations-ui-ecr-repo", "cornerstone-user_svc-ecr-repo", "cornerstone-product-ecr-repo", "cornerstone-notification-ecr-repo", "cornerstone-common_svc-ecr-repo"]
scan_on_push     = true
encryption_type  = "AES256"

# Elasticache
cluster_name = "cornerstone-redis-cluster"
node_type    = "cache.t3.medium"

# RDS
db_identifier           = "cornerstone-dev-rds-postgres"
db_instance_class    = "db.t3.medium"
db_name              = "cornerstone_db"
db_engine_version    = "13.16"
db_allocated_storage = 50
db_username          = "dbadmin"
db_password          = "Password123!"

# SNS & SES
sns_topic_name = "cornerstone-notifications-topic"
ses_domain     = "cornerstone.com"

