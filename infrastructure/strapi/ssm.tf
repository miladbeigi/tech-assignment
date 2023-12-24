locals {
  PARAMS = [
    "cms_database_username",
    "cms_database_password",
    "cms_jwt_secret",
    "cms_admin_jwt_secret",
    "cms_app_keys",
    "cms_api_token_salt",
    "cms_transfer_token_salt"
  ]
}

resource "aws_ssm_parameter" "secrets" {
  for_each = toset(local.PARAMS)
  name     = each.value
  type     = "SecureString"
  value    = "latest"
  lifecycle {
    ignore_changes = [value]
  }
}
