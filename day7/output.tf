output "vpc_id" {
    value = aws_vpc.sample.id
}

output "ec2_id" {
    value = aws_instance.manitest.id
}

output "subnet_id" {
    value = aws_subnet.publicsubnet.id
}