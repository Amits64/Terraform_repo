output "rds_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.cornerstone_db.arn
}

output "db_subnet_group_arn" {
  description = "The ARN of the DB subnet group"
  value       = aws_db_subnet_group.main.arn
}
