variable "environment" {
    default = "dev"
    type = string
}

variable "channel_name" {
    default = "mktp"
}

variable "region" {
    type = string
    default = "us-east-1"
}

variable "instance_count" {
    description = "how many instance you want to launch"
    type= number
}

variable "monitoring_enabled"{
    type = bool
    default = true
}

variable "associate_public_ip" {
    type = bool
    default = true
}

variable "cidr_block" {

    type = list(string)
    default = ["10.0.0.0/8","192.168.0.0/16","172.16.0.0/12"]
}

variable "ec2_type" {

    type = list(string)
    default = ["t2.medium","t2.small","t2.micro"]
  
}

variable "allowed_region" {
    description = "only mentioned here are allowed"
    type = set(string)
    default = ["us-east-1","us-west-2","us-west-2"]
}

variable "tags" {
    type = map(string)
    default = {
        Environment = "dev"
        name = "dev-instance"
        created_by = "terraform"
    }   
}

variable "ingress_values"{
    type = tuple([number,string,number])
    default = [0,"tcp",65535]
}

variable "config" {
  type = object ({
    region = string,
    instance_count = number,
    monitoring = bool
  })
  default = {
    region = "us-east-2",
    instance_count = 1,
    monitoring = true
  }
}