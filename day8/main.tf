#works with list of strings
resource "aws_s3_bucket" "buckets3"{
    count = 2
    bucket = var.bucket_names[count.index]
    tags = {
        appid = "asp00013096"
        environment = "prod"
        owner = "chekka.manikanta@spglobal.com"
    }
}
#works with set of strings
resource "aws_s3_bucket" "bucketss32"{
    for_each = var.bucket_name_set
    bucket = each.key #can use each.value as well
   tags = {
        appid = "asp00013096"
        environment = "pre-prod"
        owner = "chekka.manikanta@spglobal.com"
    }
    depends_on = [ aws_s3_bucket.buckets3 ]
}

# resource "aws_s3_bucket" "bucket1"{
#     bucket = "mytestingmanibucket321"
#     tags = [
#         name = "mytestingmanibucket321"
#         owner = "chekka.manikanta@gmail.com"
#         environment = "prod"
#         BU = "corp"
#     ]
# }

# resource "aws_s3_bucket" "bucket2"{
#     bucket = "manibucketvaranasi"
#     tags = {
#         name = "manibucketvaranasi"
#         environment = "prod"
#         owner = "chekka.manikanta@gmail.com"
#         bu = "corp"
#     }
#     depends_on = [ aws_s3_bucket.bucket1 ]
#}