# elasticache.tf
resource "aws_elasticache_replication_group" "cornerstone_redis_cluster" {
  replication_group_id       = var.cluster_name
  description                = "Redis replication group for cornerstone project" # Updated here
  node_type                  = var.node_type
  num_cache_clusters         = 2 # Updated here
  automatic_failover_enabled = true
  multi_az_enabled           = true
  engine                     = "redis"
  engine_version             = "6.x"
  port                       = 6379
  parameter_group_name       = "default.redis6.x"
  subnet_group_name          = aws_elasticache_subnet_group.main.name
  security_group_ids         = [aws_security_group.sg.id]
  final_snapshot_identifier  = "cornerstone-redis-final-snapshot"

  tags = {
    Name        = "cornerstone-dev-redis-cache"
    project     = "cornerstone"
    environment = "dev"
    managed_by  = "terraform"
  }
}

resource "aws_elasticache_subnet_group" "main" {
  name       = "main"
  subnet_ids = module.vpc.private_subnets
  tags = {
    Name = "main"
  }
}
