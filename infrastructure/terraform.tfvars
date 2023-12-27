vpc-name             = "cms"
vpc-cidr             = "10.0.0.0/16"
instance_type        = "t2.micro"
private-subnets-cidr = ["10.0.1.0/24", "10.0.2.0/24"]
public-subnets-cidr  = ["10.0.101.0/24", "10.0.102.0/24"]
enable_nat_gateway   = true
region               = "eu-west-1"
