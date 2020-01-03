# https://www.terraform.io/docs/providers/aws/index.html
provider "aws" {
  region  = var.region
  profile = var.profile
}

terraform {
  required_version = ">= 0.12"

  # by default state is stored in local dir
  # storing state in s3
  # backend "s3" {}
}
