terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~>6.0"
      }
    }
}

provider "aws" {
    region = "us-east-1"
}

# resource "aws_vpc" "test-vpc" {
#     cidr_block = "10.0.0.0/22"
#     tags = {
#         name = "test-vpc"
#         owner = "chekka.manikanta@spglobal.com"
#         environment = "poc"
#         appid = "ASP0001309"
#         bu = "corp"
#     }
# }

resource "aws_s3_bucket" "first-bucket" {
    bucket = "mani-testing-bucket222"
    tags = {
        name = "test-bucket-2.0"
        owner = "chekka.manikanta@spglobal.com"
        environment = "poc"
        appid = "ASP0001309"
        bu = "corp"
    }
}