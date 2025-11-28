# terraform {
#   backend "s3" {
#     bucket = "digitalwitchngbucketcloud1"
#     key    = "digitalwitchng/prodution/terraform.tfstate"
#     region = "us-west-1"
#   }
# }

# Using local backend for now
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}