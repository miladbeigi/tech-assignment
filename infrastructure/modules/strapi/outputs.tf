output "strapi_instance_id" {
  value = aws_instance.strapi.id
}
output "alb_dns_name" {
  value = aws_lb.application-lb.dns_name
}
