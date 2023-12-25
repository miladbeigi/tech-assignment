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
resource "aws_ssm_document" "main" {
  name          = "Deploy-Strapi"
  document_type = "Command"

  content = jsonencode({
    schemaVersion = "2.2"
    description   = "Run the deploy bash script"
    parameters    = {}
    mainSteps = [
      {
        action = "aws:runShellScript"
        name   = "runShellScript"
        inputs = {
          runCommand = [
            "cd /home/ubuntu/tech-assignment/scripts",
            "chmod +x ./2.Deploy.sh",
            "bash ./2.Deploy.sh"
          ]
        }
      }
    ]
  })
}
