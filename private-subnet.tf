
resource "aws_subnet" "private" {
  #here i am using slice option, let suppose we have 6 availabity zone and i need only 2 , then we use slice
  count = length(slice(local.azs_name, 0 , 2 ))
  vpc_id     = aws_vpc.my-vpc.id
  #function we are using for cidrsubnet
  #count.index means the value we have in the count above
  # here public subnet has already used subnet range, now to give next rang we select +
  cidr_block = cidrsubnet("10.10.0.0/16", 8 ,count.index + length(local.azs_name))
  availability_zone = local.azs_name  [count.index]

  tags = {
    Name = "priavatesubnet-${count.index +1}"
  }
}


resource "aws_route_table" "privatert" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "privatert-${local.name}"
  }
}

#here we have use slice option

resource "aws_route_table_association" "private-sbunet-association" {
  count = length(slice(local.azs_name, 0 , 2 ))
  route_table_id = aws_route_table.privatert.id
  subnet_id = aws_subnet.private.*.id[count.index]
}