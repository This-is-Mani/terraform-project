locals {
    formatted_project_name = lower(var.project_name) #project alpha resource
    formatted_project_name1 = lower(replace(var.project_name," ", "-")) #project-alpha-resource
    new_tag = merge(var.default_tags,var.environment-tags)
    formatted_bucket_name = replace(substr(var.bucket_name,0,63),"-"," ")
    formatted_bucket_name2 = replace(substr(var.bucket_name,0,63),"honey","chekka")
    port_list = split(",",var.allowed_ports) #split
    sg_rules = [ for port in local.port_list :

    {
        name = "port-${port}"
        port = port
        description = "allow traffic on port ${port}"
    }

    ]
    instance_size = lookup(var.instance_sizes,var.environment,"t2.medium")
    #if nothing matches the environment tag value, t2.medium will be used
    #if we have terraform.tfvars file which will take higher precedence might overwrite the vaue from var file
    
    all_locations = concat(var.user_locations,var.default_locations)
    unique_locations = toset(local.all_locations) #converted list into set
    
    #positive_costs = abs(var.monthly_costs)
    #absolute function doesn't work on a tuple where we need to use iterate
    positive_cost = [ for cost in var.monthly_costs : abs(cost) ]

    #max_cost = max(local.positive_cost)
    #max/min doesn't work on tuples (var.monthly_costs)
    max_cost = max(local.positive_cost...)
    #spread operator (...) used to spread the list which let max and min fucntions work
    min_cost = min(local.positive_cost...)
    total_cost = sum(local.positive_cost)
    average_cost = local.total_cost / length(local.positive_cost)
    current_timestamp = timestamp()
    timestamp_format1 = formatdate("yyyymmdd",local.current_timestamp)
    timestamp_format2 = formatdate("YYYY-MM-DD",local.current_timestamp)
    timestamp_name = "backup-${local.timestamp_format1}"
    config_file_exist = fileexists("./mani.json")
    #used to find file exists or not using inbuilt function fileexists(path)
    config_data = local.config_file_exist ? jsondecode(file("./mani.json")) : {}
}

resource "aws_s3_bucket" "bucket1" {
    bucket = local.formatted_bucket_name2 #or we can use var file which is var.bucket_name
    #tags = merge(var.default_tags, var.environment-tags)
    #we can have two different tags on var file and use merge function
    tags = local.new_tag
    #or we can use same on locals block and use on resource block
}
