provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main-vpc"
  }
}

# Create a public subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a" # Adjust if needed
  tags = {
    Name = "public-subnet"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-igw"
  }
}

# Create a Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Create a Security Group
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kops-sg"
  }
}

# Define EC2 Instances
resource "aws_instance" "kops" {
  ami                    = "ami-04a81a99f5ec58529" # Ubuntu 24.04 LTS AMI
  instance_type          = "t2.medium"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  subnet_id              = aws_subnet.public.id
  user_data              = file("${path.module}/kops_script.sh")

  tags = {
    Name = "kops-instance"
  }
}

# S3 Bucket for kops state store
resource "aws_s3_bucket" "my_bkt" {
  bucket = "devops-tech-bkt-001"

  tags = {
    Name        = "kops_bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_public_access_block" "my_bkt" {
  bucket = aws_s3_bucket.my_bkt.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# IAM user for kops
resource "aws_iam_user" "kops_user" {
  name = "kops_user"
  path = "/"

  tags = {
    tag-key = "kops_user"
  }
}

# IAM policy for kops
resource "aws_iam_policy" "kops_policy" {
  name        = "kops_policy"
  description = "Kops policy for managing cluster"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "*"
        "Resource" : "*"
      }
    ]
  })
}

# Attach policy to kops user
resource "aws_iam_user_policy_attachment" "kops_user_attach" {
  user       = aws_iam_user.kops_user.name
  policy_arn = aws_iam_policy.kops_policy.arn
}

# Outputs
output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "kops_public_ip" {
  value = aws_instance.kops.public_ip
}
