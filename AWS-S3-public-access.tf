# s3 bucket created 



provider "aws" {
  region = local.origin_region

  # Make it faster by skipping something
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}

provider "aws" {
  region = local.replica_region

  alias = "replica"

  # Make it faster by skipping something
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}

locals {
  bucket_name             = "origin-s3-bucket-${random_pet.this.id}"
  destination_bucket_name = "replica-s3-bucket-${random_pet.this.id}"
  origin_region           = "eu-west-1"
  replica_region          = "eu-central-1"
}

data "aws_caller_identity" "current" {}


resource "aws_s3_bucket" "example" {
  bucket = "test-bucket-client"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
