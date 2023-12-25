output "strapi_instance_id" {
  value = aws_instance.strapi.id
}
output "strapi_instance_ip" {
  value = aws_instance.strapi.public_ip
}
output "alb_dns_name" {
  value = aws_lb.application-lb.dns_name
}
