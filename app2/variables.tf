# required vars
variable "region" {
  type = string
  default = "eu-central-1"
 }

 # optional vars
variable "profile"  {
   type = string
   description = "profile to be used for AWS auth"
   default = null # if not provided env vars should be used
}

# maps
variable "workspace_to_environment_map" {
  type = map
  default = {
    dev = "dev"
    preprod = "preprod"
    prod = "prod"
  }
}
