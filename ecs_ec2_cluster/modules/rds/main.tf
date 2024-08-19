resource "aws_db_subnet_group" "main" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnets
}

resource "aws_db_instance" "main" {
  identifier          = var.db_identifier
  engine              = "mysql"
  instance_class      = "db.t3.micro"
  allocated_storage   = 20
  db_subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.security_group_id]
  username            = var.username
  password            = var.password
  skip_final_snapshot = true
}
