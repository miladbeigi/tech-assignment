locals {
  env  = "Development"
  team = "Marketing"

  tags = {
    Env  = local.env
    Team = local.team
  }
}
