
resource "aws_eip" "levelup_nat" {
    vpc = true
  
}

resource "aws_nat_gateway" "levelup_nat_gw" {
  allocation_id = aws_eip.levelup_nat.id
  subnet_id     = aws_subnet.levelup_vpc_public1.id
  depends_on = [aws_internet_gateway.levelup-gw]

  tags = {
    Name = "gw NAT"
  }
}

  resource "aws_route_table" "levelup_private_rt" {
  vpc_id = aws_vpc.levelup_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.levelup_nat_gw.id
  }
  
  tags = {
    Name = "levlup-private"
  }
  
}

  #route association private
  resource "aws_route_table_association" "levelup_private_rta_1_a" {
  subnet_id      = aws_subnet.levelup_vpc_private1.id
  route_table_id = aws_route_table.levelup_private_rt.id
}
  resource "aws_route_table_association" "levelup_private_rta_1_b" {
  subnet_id      = aws_subnet.levelup_vpc_private2.id
  route_table_id = aws_route_table.levelup_private_rt.id
}
  resource "aws_route_table_association" "levelup_private_rta_1_c" {
  subnet_id      = aws_subnet.levelup_vpc_private3.id
  route_table_id = aws_route_table.levelup_private_rt.id
}