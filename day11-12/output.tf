output "formatted_project_name" {
    value = local.formatted_project_name
}

output "formatted_project_name1" {
    value = local.formatted_project_name1
}

output "formatted_bucket_name" {
    value = local.formatted_bucket_name
}

output "formatted_bucket_name2" {
    value = local.formatted_bucket_name2
}

output "port_lists"{
    value = local.port_list
}

output "sg_rules" {
    value = local.sg_rules
}

output "instnace_size" {
    value = local.instance_size
}

output "creds" {
    value = var.creds
    sensitive = true
}

output "all_locations" {
  value = local.all_locations
}

output "unique_locations" {
  value = local.unique_locations
}

output "postive_costs" {
  value = local.positive_cost
}

output "max" {
    value = local.max_cost
}

output "min" {
    value = local.min_cost
}

output "total_cost" {
    value = local.total_cost
}

output "avg_cost" {
    value = local.average_cost
}

output "timestamp"{
    value = local.current_timestamp
}

output "timestamp_format1" {
    value = local.timestamp_format1
}

output "timestamp_format2" {
    value = local.timestamp_format2
}

output "config_file" {
  value = local.config_data
}
