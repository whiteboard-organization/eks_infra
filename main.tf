resource "aws_s3_bucket" "my_bucket" {
  bucket = "simply-testing"  # just testing for now
  acl    = "private"
}