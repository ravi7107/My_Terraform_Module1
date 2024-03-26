resource "aws_route_table" "test" {
  vpc_id = aws_vpc.test.id

  # since this is exactly the route AWS will create, the route will be adopted
  route {
    cidr_block = "10.1.0.0/16"
    gateway_id = "local"
  }
}

resource "aws_route_table" "test" {
  vpc_id = aws_vpc.test.id

  route {
    cidr_block           = aws_vpc.test.cidr_block
    network_interface_id = aws_network_interface.test.id
  }
}

resource "aws_subnet" "test" {
  cidr_block = "10.1.1.0/24"
  vpc_id     = aws_vpc.test.id
}

resource "aws_network_interface" "test" {
  subnet_id = aws_subnet.test.id
}