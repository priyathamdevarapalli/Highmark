# s3 bucket created 

resource "aws_s3_bucket" "example" {
  bucket = "test-bucket-client"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket" "example2" {
  bucket = "test-bucket-client-test123"

  tags = {
    Name        = "My bucket test123"
    Environment = "Dev"
  }
}