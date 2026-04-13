terraform {
    backend "s3" {
    bucket       = "my-terraform-state"   # S3 bucket to store state
    key          = "dev/terraform.tfstate" # Path inside the bucket
    region       = "us-east-1"           # AWS region
    encrypt      = true                   # Encrypt state file at rest (SSE-S3)
    use_lockfile = true                   # Enable S3-native locking
  }
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~>6.0"
      }
    }
}

provider "aws" {
    region = var.region
}

variable "environment" {
    default = "dev"
    type = string
}

variable "channel_name" {
    default = "mktp"
}

variable "region" {
    default = "us-east-1"
}

locals {
    bucket_name = "${var.channel_name}-bucket-${var.environment}-${var.region}"
    vpc_name = "${var.environment}-vpc"
}

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

#we can have the output values showed in the different block like below

output "vpc_id" {
    value = aws_vpc.sample.id
}

output "ec2_id" {
    value = aws_instance.manites.id
}

#we can update the environment variable value using the command instead of updating the script

#below are the commands
#export TF_VAR_environment=stage
#terraform plan will show the updating about to takes place

#similarly we can have new file called terraform.tfvars
#with below as content
#environment = "preprod"

# we can use high precedence during the terraform plan command above all

#terraform plan -var=environment=staging or

#we can use tfvars file as input like below
#terraform plan -var-file="preprod.tfvars"
#terraform apply -var-file="preprod.tfvars"
