locals {
  context = {
    tags = {
        App: "${var.app}",
        Env: "${var.env}"
    }
    app = var.app
    env = var.env
    region = var.region
  }
}
