resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.route_table.id

  # since this is exactly the route AWS will create, the route will be adopted
  route {
    cidr_block = "10.1.0.0/16"
    gateway_id = "local"
  }
}