provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-ci-cd-s3-bucket-example-123456"
  acl    = "private"
}
