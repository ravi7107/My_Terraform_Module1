resource "aws_route_table" "test" {
  vpc_id = aws_vpc.main.id

  # since this is exactly the route AWS will create, the route will be adopted
  route {
    cidr_block = "10.1.0.0/16"
    gateway_id = "local"
  }
}

resource "aws_route_table_association" "rt_association1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.test.id
}

resource "aws_route_table_association" "rt_association2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.test.id
}