variable "allowed_vm_types" {
    type = list(string)
    description = "for my ref allowed vm types"
    default = ["t2.micro","t2.medium","t3.small"]
}

variable "allowed_region"{
    type = set(string)
    default = ["us-east-1","us-east-2","us-west-2"]
}

variable "region" {
    default = "us-east-1"
}