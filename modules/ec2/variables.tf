# required vars
variable "context" {
  type = object({
    # We can declare an object using only the subset of attributes the module
    # needs. Terraform will allow any object that has at least these attributes.
    #region = string
    app = string
    env = string
    tags = map(string)
  })
}

variable "instance_type" {
  type = map

  default = {
    dev = "t2.micro"
    preprod = "t2.micro"
    prod = "m4.xlarge"
  }
}

# static vars
#variable "amis" {
#  type = map
#  default = {
#    "eu-central-1" = "ami-0d4c3eabb9e72650a"
#    "eu-west-1" = "ami-034fffcc6a0063961"
#  }
#}
