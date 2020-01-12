locals { 
   # constant var
  app = "app1"

  # fails if a given mapping does not exist
  env = var.workspace_to_environment_map[terraform.workspace]
  
  # does not fail if a given mapping does not exist
  #env = lookup(var.workspace_to_environment_map, terraform.workspace, "dev")

  # create optional ec2 only in eu-central-1 region
  ec2required = (var.region == "eu-central-1" ? true : false)
}
