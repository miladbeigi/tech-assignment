output "strapi_instance_id" {
  value = aws_instance.strapi.id
}
output "strapi_instance_ip" {
  value = aws_instance.strapi.public_ip
}
