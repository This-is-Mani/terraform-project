resource "aws_instance" "vm1" {
    ami = "ami-0432f54cd5d5a8a02"
    # instance_type = "t2.medium"
    # instead of hardcoding the instance type, we can use conditional expression 
    instance_type = var.enviroment == "dev" ? "t2.micro" : "t3.micro" 
    count = var.instance_count
    tags = var.tags
}

resource "aws_security_group" "ingress_rule" {
    name = "sg"
    # ingress {
    #     from_port = 80
    #     to_port = 80
    #     cidr_blocks = ["0.0.0.0/0"]
    #     protocol = "http"
    # }
#instead of hard coding the values, we can use dynamic block and reiterate the values given on variable.tf file
    dynamic "ingress" {
        for_each = var.ingress_rules
        content {
          from_port = ingress.value.from_port
          to_port = ingress.value.to_port
          cidr_blocks = ingress.value.cidr_blocks
          protocol = ingress.value.protocol
        }
    }
}

locals {
    all_instance_ids = aws_instance.vm1[*].id
    #operator * in the above line is called splat expression
    }

output "instances" {
    value = local.all_instance_ids
}