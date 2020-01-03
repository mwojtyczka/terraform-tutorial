# collect all common variables
module "config" {
  source = "../modules/config"
  env = local.env
  region = var.region
  app = local.app
}

# create resource directly
resource "aws_s3_bucket" "s3" {
  bucket = "${module.config.context.env}-${module.config.context.app}-terraform-example-marcin"
}

module "ec2_optional" {
  source = "../modules/ec2_optional"
  context = module.config.context
  required = local.ec2required
}

module "ec2" {
  source = "../modules/ec2"
  context = module.config.context
}