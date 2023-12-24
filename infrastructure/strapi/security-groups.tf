
resource "aws_security_group" "strapi-sg" {
  name   = "strapi-sg"
  vpc_id = var.vpc_id

  egress {
    description = "Allow access to Internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }
  tags = {
    Name = "strapi-sg"
  }
}
