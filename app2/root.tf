# https://www.terraform.io/docs/providers/aws/index.html
provider "aws" {
  region  = var.region
}

terraform {
  required_version = ">= 0.12"
}
