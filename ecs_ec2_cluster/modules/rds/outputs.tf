output "db_instance_endpoint" {
  value = aws_db_instance.main.endpoint
}

output "db_instance_identifier" {
  value = aws_db_instance.main.id
}
