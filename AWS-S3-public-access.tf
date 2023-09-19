resource "aws_s3_bucket" "example" {
  bucket = "test-bucket-highmark"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}