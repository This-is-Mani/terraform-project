resource "aws_s3_bucket" "manifirstbucket" {
    bucket = local.bucket_name
    tags = {
        name = local.bucket_name
        #instead of using "test-bucket-2.0"
        owner = "chekka.manikanta@spglobal.com"
        environment = "poc"
        appid = "ASP0001309"
        bu = "corp"
    }
}

resource "aws_vpc" "sample"{
    cidr_block = "10.0.0.0/22"
    tags = {
        name = local.vpc_name
        #instead of "${var.environment}-vpc"
        Environment = var.environment
    }
}

resource "aws_subnet" "publicsubnet" {
    vpc_id = aws_vpc.sample.id
    cidr_block = "10.0.1.0/24"
}

resource "aws_instance" "manitest" {
    ami = "ami-055bewci" #ami image name
    instance_type = "t2.micro"
    subnet_id = aws_subnet.publicsubnet.id
    
    tags = {
        name = "mani-testing-instance"
        environment = var.environment
    }
  
}