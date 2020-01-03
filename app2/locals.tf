locals {
  app = "app2"
  env = var.workspace_to_environment_map[terraform.workspace]
}
