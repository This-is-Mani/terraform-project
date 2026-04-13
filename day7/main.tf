resource "aws_vpc" "sample"{
    cidr_block = "10.0.0.0/22"
    region = var.config.region #uses region mentioned on varable
    tags = {
        name = local.vpc_name
        #instead of "${var.environment}-vpc"
        Environment = var.environment
    }
}

resource "aws_subnet" "publicsubnet" {
    vpc_id = aws_vpc.sample.id
    cidr_block = "10.0.1.0/24"
    tags = var.tags
}

resource "aws_instance" "manitest" {
    ami = "ami-051f8a213df8bc088" #ami image name
    instance_type = var.ec2_type[1]
    subnet_id = aws_subnet.publicsubnet.id
    monitoring = var.monitoring_enabled
    associate_public_ip_address = var.associate_public_ip
    
    tags = {
        name = "mani-testing-instance"
        environment = var.environment
    }
  
}

resource "aws_security_group" "allow_tls"{
description = "for security purpose"
vpc_id = aws_vpc.sample.id

tags = {
    name = "my_first_sg"
}
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
    security_group_id = aws_security_group.allow_tls.id
    cidr_ipv4 = var.cidr_block[0]
    from_port = 443
    ip_protocol = "tcp"
    to_port = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_tls_ipv4" {
    security_group_id = aws_security_group.allow_tls.id
    cidr_ipv4 = var.cidr_block[0]
    from_port = 443
    ip_protocol = "tcp"
    to_port = 443
}

#if we use tuple data type for a security rule, it wil look like below;

resource "aws_vpc_security_group_ingress_rule" "allow_tcp_80" {
    security_group_id = aws_security_group.allow_tls.id
    cidr_ipv4 = var.cidr_block[0]
    from_port = var.ingress_values[0]
    ip_protocol = var.ingress_values[1]
    to_port = var.ingress_values[2]
}