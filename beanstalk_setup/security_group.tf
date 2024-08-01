resource "aws_security_group" "vprofile-bean-elb-sg" {
  name        = "vprofile-bean-elb-sg"
  description = "Security group for beanstalk-elb"
  vpc_id      = module.vpc.vpc_id

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Allow all outbound traffic"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  ingress = [
    {
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Allow HTTP traffic"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "vprofile-bean-elb-sg"
  }
}

resource "aws_security_group" "vprofile_bastion_sg" {
  name        = "vprofile_bastion_sg"
  description = "Security group for bastion host ec2 instance"
  vpc_id      = module.vpc.vpc_id

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Allow all outbound traffic"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  ingress = [
    {
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Allow SSH traffic"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "vprofile_bastion_sg"
  }
}

resource "aws_security_group" "vprofile_prod_sg" {
  name        = "vprofile_prod_sg"
  description = "Security group for beanstalk instance"
  vpc_id      = module.vpc.vpc_id

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Allow all outbound traffic"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  ingress = [
    {
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Allow SSH traffic from bastion"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = [aws_security_group.vprofile_bastion_sg.id]
      self             = false
    },
    {
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Allow Health Check traffic from ELB"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = [aws_security_group.vprofile-bean-elb-sg.id]
      self             = false
    }
  ]

  tags = {
    Name = "vprofile_prod_sg"
  }
}

resource "aws_security_group" "vprofile_backend_sg" {
  name        = "vprofile_backend_sg"
  description = "Security group for RDS, ActiveMQ, ElastiCache"
  vpc_id      = module.vpc.vpc_id

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Allow all outbound traffic"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = [aws_security_group.vprofile_prod_sg.id]
      self             = false
    }
  ]

  ingress = [
    {
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Allow SSH traffic from prod"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = [aws_security_group.vprofile_prod_sg.id]
      self             = false
    },
    {
      from_port        = 3306
      to_port          = 3306
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Allow MySQL traffic from bastion"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = [aws_security_group.vprofile_bastion_sg.id]
      self             = false
    },
    {
      from_port        = 5671
      to_port          = 5671
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Allow MySQL traffic from bastion"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      from_port        = 11211
      to_port          = 11211
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Allow MySQL traffic from bastion"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "vprofile_backend_sg"
  }
}

resource "aws_security_group_rule" "sec_grp_allow_itself" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.vprofile_backend_sg.id
  source_security_group_id = aws_security_group.vprofile_backend_sg.id
  description              = "Allow all traffic within the security group"
}

