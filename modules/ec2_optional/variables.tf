# required vars
variable "context" {
  type = object({
    app = string
    env = string
    tags = map(string)
  })
}

# optional vars
variable "required" {
  type = bool
  default = true
}
