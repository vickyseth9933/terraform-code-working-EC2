locals {
  name = terraform.workspace == "dev" ? "javahome-dev" : "javahome-prod"
  azs_name = data.aws_availability_zones.available.names
  public_subnet = aws_subnet.public.*.id
}
