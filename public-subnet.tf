
##creating public subnet
##while creating subnet , we need to attach it to route table  , vpc etc


resource "aws_subnet" "public" {
  #here we use count index, so if we have 4 avaialbity zones in datasource it will also create 4 subnet
  #we have used local value otherwise we can also use interpolation here
  count = length(local.azs_name)
  vpc_id     = aws_vpc.my-vpc.id
  #function we are using for cidrsubnet
  #count.index means the value we have in the count above
  cidr_block = cidrsubnet("10.10.0.0/16", 8 ,count.index )
  availability_zone = local.azs_name  [count.index]
  map_public_ip_on_launch = "true"

  tags = {
    Name = "publicsubnet-${count.index +1}"
  }
}

#we are using data source to get teh value of availability zone dynamically

data "aws_availability_zones" "available" {
  state = "available"
}
#local value to apply inside the count and avaiality zone section
#this value comes from datasource

#locals {
 # azs_name = data.aws_availability_zones.available.names
#}



