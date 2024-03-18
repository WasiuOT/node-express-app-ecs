output "vpc_id" {
  value = data.aws_vpc.vpc.id
}
output "subnet1_id" {
  value = data.aws_subnet.subnet1.id
}

output "subnet2_id" {
  value = data.aws_subnet.subnet2.id
}

output "subnet3_id" {
  value = data.aws_subnet.subnet3.id
}
output "subnet4_id" {
  value = data.aws_subnet.subnet4.id
}

output "security_group_id" {
  value = data.aws_security_group.sg.id
}

output "jumphost_ec2_private_ip" {
  value = data.aws_instance.jumphost_ec2.private_ip
}

output "jumphost_ec2_public_ip" {
  value = data.aws_instance.jumphost_ec2.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.rds.endpoint
}


output "ecr_repository_uri" {
  value = data.aws_ecr_repository.ecr_repo.repository_url
}