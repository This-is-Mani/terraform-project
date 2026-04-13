variable "project_name" {
    default = "Project ALPHA Resource"
}

variable "default_tags" {
    default = {
        company = "techcorp"
        managed_by = "terraform"
    }
}

variable "environment-tags" {
    default = {
        environment = "prod"
        cost_center = "cc-123"
    }
}

variable "bucket_name" {
    default = "manikanta-honey-bee-bucket-123"
}

variable "allowed_ports" {
    default = "80,443,8080,3306"
}

variable "instance_sizes" {

    default = {
        dev = "t2.micro"
        staging = "t3.small"
        prod = "t3.medium"
    }
  
}

variable "environment" {
  default = "prodction"
}

variable "instance_type" {
    default = "t2.micro"

    validation {
      condition = length(var.instance_type) >= 2 && length(var.instance_type) <= 20  
      error_message = "instance_type must be 2-20 characters"
    }
    validation {
        condition = can(regex("^t[2-3]\\.",var.instance_type))
        error_message = "instance_type must be t2 or t3 family"
      
    }
}

variable "backup_name" {
    default = "daily_bakcup"

    validation {
        condition = endswith(var.backup_name,"_backup") #endswith validation function
        error_message = "bucket_name must end with '_backup'"
    }
}

variable "creds" {
    default = "abc123"
    sensitive = true
}

variable "user_locations" {
  default = ["us-east-1","us-west-2","us-east-1"]
  #list allows duplicates but set doesn't allow
}

variable "default_locations" {
  default = ["us-east-1"]
}

variable "monthly_costs" {
  default = [-50,100,75,200] # -50 is a credit
  #absolute function doesn't work on a tuple where we need to use iterate on main
}