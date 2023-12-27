variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket to store the Terraform state file"
}

variable "env" {
  type        = string
  description = "The environment name"
}

variable "dynamodb-prefix-table-name" {
  type        = string
  description = "The name of the DynamoDB table to store the Terraform state lock"
  default     = ""
}
