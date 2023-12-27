module "strapi" {
  source          = "./modules/strapi"
  instance_type   = var.instance_type
  instance_ami    = data.aws_ami.this.id
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  private_subnets = module.vpc.private_subnets
  app-version     = "0.1.1"
}

# module "terraform-state" {
#   source                     = "./modules/terraform-state/"
#   env                        = "staging"
#   bucket_name                = "sample-bucket-to-store-terraform-state"
#   dynamodb-prefix-table-name = "app"
# }
