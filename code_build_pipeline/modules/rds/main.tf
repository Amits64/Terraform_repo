data "aws_subnet" "private_subnet_az1" {
  filter {
    name   = "tag:Name"
    values = [var.private_subnet_az1]
  }
}

data "aws_subnet" "private_subnet_az2" {
  filter {
    name   = "tag:Name"
    values = [var.private_subnet_az2]
  }
}

resource "aws_db_instance" "cornerstone_db" {
  identifier              = var.db_identifier
  allocated_storage       = var.db_allocated_storage
  storage_type            = var.db_storage_type
  engine                  = "postgres"
  engine_version          = var.db_engine_version
  instance_class          = var.db_instance_class
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  parameter_group_name    = "default.postgres13"
  multi_az                = true
  publicly_accessible     = false
  backup_retention_period = 7
  vpc_security_group_ids  = var.devapps_sg_name
  db_subnet_group_name    = aws_db_subnet_group.main.name
  port                    = 5432
  skip_final_snapshot     = true

  tags = {
    Name        = "cornerstone-dev-rds-postgres"
    project     = "cornerstone"
    environment = "dev"
    managed_by  = "terraform"
  }
}

resource "aws_db_subnet_group" "main" {
  name       = "main"
  subnet_ids = [data.aws_subnet.private_subnet_az1.id, data.aws_subnet.private_subnet_az2.id]
  tags = {
    Name = "main"
  }
}
