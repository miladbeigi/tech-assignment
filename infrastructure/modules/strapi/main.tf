resource "aws_instance" "strapi" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  subnet_id              = var.private_subnets[0]
  vpc_security_group_ids = [aws_security_group.strapi-sg.id]
  iam_instance_profile   = aws_iam_instance_profile.this.name
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 30
  }

  user_data = templatefile(format("%s%s", path.module, "/scripts/cloud-config.text"), {
    install_script = file("${path.module}/scripts/install.sh")
  })

  tags = {
    "Name" = "Strapi"
  }
}
