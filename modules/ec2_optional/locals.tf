locals {
  name = "${var.context.env}-${var.context.app}-optional"
  count = (var.required ? 1 : 0)
}
