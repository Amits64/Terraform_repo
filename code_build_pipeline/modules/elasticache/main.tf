resource "aws_elasticache_replication_group" "this" {
  replication_group_id       = var.cluster_name
  description                = var.description
  node_type                  = var.node_type
  num_cache_clusters         = var.num_cache_clusters
  automatic_failover_enabled = var.automatic_failover_enabled
  multi_az_enabled           = var.multi_az_enabled
  engine                     = var.engine
  engine_version             = var.engine_version
  port                       = var.port
  parameter_group_name       = var.parameter_group_name
  subnet_group_name          = aws_elasticache_subnet_group.this.name
  security_group_ids         = var.devapps_sg_name
  final_snapshot_identifier  = var.final_snapshot_identifier

  tags = var.tags
}

resource "aws_elasticache_subnet_group" "this" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids

  tags = var.subnet_tags
}
