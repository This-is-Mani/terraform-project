variable "instance_count" {
    description = "instances to be launched"
    type = number
}

variable "enviroment"{
    type = string
    default = "dev"
}

variable "tags" {
    type = map(string)
    default = {
        environment = "prod"
        BU          = "corp"
    }
    
}

variable "ingress_rules" {
    description = "inbound rules"
    type = list(object({
        from_port = number
        to_port = number
        protocol = string
        cidr_blocks = list(string)
        description = string
    }))
    default = [ 
        {
            from_port = 80
            to_port = 80
            protocol = "tcp"
            cidr_blocks = [ "0.0.0.0/0" ]
            description = "http"
        },
        {
            from_port = 443
            to_port  = 443
            protocol = "tcp"
            cidr_blocks = [ "0.0.0.0/0" ]
            description = "https"
        }
    ]

}