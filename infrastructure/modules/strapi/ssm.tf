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

# Put value=latest for all the parameters, later we will update the values using the script.

resource "aws_ssm_parameter" "secrets" {
  for_each = toset(local.PARAMS)
  name     = each.value
  type     = "SecureString"
  value    = "latest"
  lifecycle {
    ignore_changes = [value]
  }
}

# SSM Document to run the deploy script.
resource "aws_ssm_document" "main" {
  name          = "Deploy-Strapi"
  document_type = "Command"

  content = jsonencode({
    schemaVersion = "2.2"
    description   = "Run the deploy bash script"
    parameters = {
      Version = {
        type        = "String"
        description = "Version of the application"
        default     = var.app-version
      }
      Region = {
        type        = "String"
        description = "AWS Region"
        default     = local.region
      }
    }
    mainSteps = [
      {
        action = "aws:runShellScript"
        name   = "runShellScript"
        inputs = {
          runCommand = [
            "cd /home/ubuntu/tech-assignment/scripts",
            "bash ./2.Deploy.sh {{Version}} {{Region}}"
          ]
        }
      }
    ]
  })
}
