locals {
  name   = "CMS"
  env    = "Development"
  team   = "Marketing"
  region = "eu-west-1"

  tags = {
    App  = local.name
    Env  = local.env
    Team = local.team
  }
}
