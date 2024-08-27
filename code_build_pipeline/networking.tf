data "aws_vpc" "commons_dev_spoke_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet" "private_subnet_az1" {
  filter {
    name   = "tag:Name"
    values = [var.private_subnet_az1_name]
  }
}

data "aws_subnet" "private_subnet_az2" {
  filter {
    name   = "tag:Name"
    values = [var.private_subnet_az2_name]
  }
}

resource "aws_route_table" "private_rt_az1" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    transit_gateway_id = var.transit_gateway_id
  }

  tags = {
    Name = "commons-dev-us-east-1-spoke-vpc-private-subnet-az1-rtb"
  }
}

resource "aws_route_table" "private_rt_az2" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    transit_gateway_id = var.transit_gateway_id
  }

  tags = {
    Name = "commons-dev-us-east-1-spoke-vpc-private-subnet-az2-rtb"
  }
}

resource "aws_route_table_association" "az1_private_association" {
  subnet_id      = data.aws_subnet.private_subnet_az1.id
  route_table_id = aws_route_table.private_rt_az1.id
}

resource "aws_route_table_association" "az2_private_association" {
  subnet_id      = data.aws_subnet.private_subnet_az2.id
  route_table_id = aws_route_table.private_rt_az2.id
}


resource "aws_security_group" "devapps_sg" {
  name        = var.devapps_sg_name
  description = "Security group for dev applications"
  vpc_id      = data.aws_vpc.commons_dev_spoke_vpc.id

  ingress {
    description = "Allow traffic from specified IP ranges"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.devapps_sg_name
  }
}

resource "aws_security_group" "develb_sg" {
  name        = "cor-use1-develb-sg"
  description = "Security group for development ELB"
  vpc_id      = data.aws_vpc.commons_dev_spoke_vpc.id

  ingress {
    description = "Allow HTTP traffic from specified IP ranges"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.213.132.0/22", "10.0.0.0/8"]
  }

  ingress {
    description = "Allow HTTPS traffic from specified IP ranges"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.213.132.0/22", "10.0.0.0/8"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cor-use1-develb-sg"
  }
}
