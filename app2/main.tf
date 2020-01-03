# create resource directly
resource "aws_s3_bucket" "s3" {
  bucket = "${local.env}-${local.app}-terraform-example-marcin"
}
