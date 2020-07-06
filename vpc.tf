
resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = local.name
    Envoirnment = terraform.workspace

  }
}