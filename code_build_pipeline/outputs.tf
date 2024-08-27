output "vpc_id" {
  value = data.aws_vpc.commons_dev_spoke_vpc.id
}

output "private_subnet_az1_id" {
  value = data.aws_subnet.private_subnet_az1.id
}

output "private_subnet_az2_id" {
  value = data.aws_subnet.private_subnet_az2.id
}

output "devapps_sg_id" {
  value = aws_security_group.devapps_sg.id
}

output "develb_sg_id" {
  value = aws_security_group.develb_sg.id
}