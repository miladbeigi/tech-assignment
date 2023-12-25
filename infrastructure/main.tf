
module "strapi" {
  source       = "./strapi"
  machine_type = "t2.micro"
  instance_ami = data.aws_ami.this.id
  vpc_id       = module.vpc.vpc_id
  subnet_id    = module.vpc.public_subnets[0]
}

