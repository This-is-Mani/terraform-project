# variable "aws_vpc" {
  
# }
#since we are using filter section on data block, we don't need this section

data "aws_vpc" "vpc_name"{
    #id = var.aws_vpc
    # we can use filters block to filter the exisiting resource
    filter {
      name = "tag:Name"
      values = ["auto-tag-default"]
    }
}

data "aws_subnet" "shared"{
    filter {
      name = "tag:Name"
      values = ["POC-NAT-GATEWAY"]
    }
    vpc_id = data.aws_vpc.vpc_name.id
}

data "aws_ami" "linux2" {
    owners = ["amazon"]
    most_recent = true

    filter {
        name = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }

    filter {
        name = "virtualization_type"
        values = ["hvm"]
    }
}

resource "aws_instance" vm11 {
    ami = data.aws_ami.linux2.id
    instance_type = "t2.micro"
    subnet_id = data.aws_subnet.shared.id

    tags = {
        name = "manivm1"
        environment = "prod"
        BU = "corp"
    }
}