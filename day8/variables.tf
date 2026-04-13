variable "bucket_names" {
    type = list(string)
    default = [ "mbvaranasi","ssrvaranasi" ]
}

variable "bucket_name_set" {
    type = set(string)
    default = ["mbvaranasi2","ssrvaranasi2"]
}