output "terraform_state_bucket" {
  value = aws_s3_bucket.terraform-state.id
}
output "dynamodb_table" {
  value = aws_dynamodb_table.terraform-state.id
}
