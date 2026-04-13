terraform {

backend "s3" {
    bucket       = "wallagent-test"   # S3 bucket to store state
    key          = "dev/terraform.tfstate" # Path inside the bucket
    region       = "us-east-1"           # AWS region
    encrypt      = true                   # Encrypt state file at rest (SSE-S3)
    #use_lockfile = true                   # Enable S3-native locking
  }
}