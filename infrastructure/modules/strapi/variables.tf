variable "instance_ami" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "public_subnets" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}
variable "app-version" {
  type    = string
  default = "0.1.1"
}
