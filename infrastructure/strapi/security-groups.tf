resource "aws_security_group" "strapi-sg" {
  name   = "strapi-sg"
  vpc_id = var.vpc_id
  egress {
    description = "Allow access to Internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "strapi-sg"
  }
}

resource "aws_security_group" "alb" {
  name   = "alb-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "Allow access to port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "alb-sg"
  }
}

resource "aws_security_group_rule" "alb-egress-strapi" {
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  type                     = "egress"
  source_security_group_id = aws_security_group.alb.id
  security_group_id        = aws_security_group.strapi-sg.id
}

resource "aws_security_group_rule" "strapi-ingress-alb" {
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  type                     = "ingress"
  source_security_group_id = aws_security_group.alb.id
  security_group_id        = aws_security_group.strapi-sg.id
}
