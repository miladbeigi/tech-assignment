resource "aws_instance" "strapi" {
  ami                         = var.instance_ami
  instance_type               = var.machine_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.strapi-sg.id]
  iam_instance_profile        = aws_iam_instance_profile.this.name
  associate_public_ip_address = true

  user_data = templatefile(format("%s%s", path.module, "/cloud-config.text"), {
    install_script = file("${path.module}/scripts/install.sh")
  })

  tags = {
    "Name" = "strapi"
  }
}
