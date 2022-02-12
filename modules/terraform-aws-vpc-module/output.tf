output "vpc_id" {
  value = aws_vpc.myVPC.id
}
output "security_group_id" {
    value = aws_security_group.sg.id
}

output "vpc_name" {
  value = var.vpc_name
}

output "public_subnet_id_1" {
    value = aws_subnet.public_subnet_1.id
}

output "public_subnet_id_2" {
    value = aws_subnet.public_subnet_2.id
}

output "public_subnet_id_3" {
    value = aws_subnet.public_subnet_3.id
}

output "availability_zone_1" {
    value = aws_subnet.public_subnet_1.availability_zone
}

output "availability_zone_2" {
    value = aws_subnet.public_subnet_2.availability_zone
}

output "availability_zone_3" {
    value = aws_subnet.public_subnet_3.availability_zone
}