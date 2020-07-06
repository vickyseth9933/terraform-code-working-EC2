#for public subnet we need internet gateway


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "igw-${local.name}"
    }
}

resource "aws_route_table" "publicrt" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "publicrt-${local.name}"
  }
}


#we need to associate this with route table but we have mutliple route table so we need to use count parameter again


resource "aws_route_table_association" "public-sbunet-association" {
  count = length(local.azs_name)
  route_table_id = aws_route_table.publicrt.id
  subnet_id = local.public_subnet[count.index]
}