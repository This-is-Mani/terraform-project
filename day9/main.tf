resource "aws_security_group" "app_sg"{
    name = "app_sg"
    description = "allowing traffic"
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "allowing inbound http from anywhere"
    }
        ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "allowing inbound https from anywhere"
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "allow outbound to internet"
    }
    tags = {
        name = "app-sg"
        environment = "prod"
    }
}
resource "aws_instance" "ec2-one"{
    ami = "ami-0432f54cd5d5a8a02"
    instance_type = var.allowed_vm_types[1]
    region = var.region #(var.allowed_region)[0]
    vpc_security_group_ids = [aws_security_group.app_sg.id]
      # ✅ IMDSv2 enforced
  metadata_options {
    http_tokens = "required"
  }

  # ✅ EBS encryption enforced
  root_block_device {
    encrypted = true
  }
    tags = {
        name = "testingvm"
        owner = "chekka.manikanta@gmail.com"
        environment = "prod"
        bu = "corp"
        appid = "asp00013609"
        SupportGroup = "Wipro-Wintel"
        MaintenanceWindow = "Sun-16:00-UTC"  
        ebs-backup = "2330/7/all"
    }
    lifecycle {
    #   create_before_destroy = true
        replace_triggered_by = [ 
            aws_security_group.app_sg.id
            ]
  }
}