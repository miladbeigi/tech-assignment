locals {
  name = "CMS"
  env  = "Development"
  team = "Marketing"

  tags = {
    App  = local.name
    Env  = local.env
    Team = local.team
  }
}
