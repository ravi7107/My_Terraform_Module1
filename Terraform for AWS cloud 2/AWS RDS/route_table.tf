resource "aws_route_table" "test" {
  vpc_id = aws_vpc.main.id

  # since this is exactly the route AWS will create, the route will be adopted
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.levelup_igw.id
  }
  
}

resource "aws_internet_gateway_attachment" "igw_attachment" {
  internet_gateway_id = aws_internet_gateway.igw_attachment.id
  vpc_id              = aws_vpc.main.id
}
resource "aws_route_table_association" "rt_association1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.test.id
}

resource "aws_route_table_association" "rt_association2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.test.id
}