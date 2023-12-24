
module "strapi" {
  source       = "./strapi"
  instance_ami = "ami-0a0aadde3561fdc1e"
  machine_type = "t2.micro"
  vpc_id       = module.vpc.vpc_id
  subnet_id    = module.vpc.public_subnets[0]
}
