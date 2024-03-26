#create VPC
resource "aws_vpc" "levelup_vpc" {
  cidr_block       = "172.20.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  #enable_classiclink = "false"

  tags = {
    Name = "levelup_vpc"
  }
}

#Public subnet in VPC
resource "aws_subnet" "levelup_vpc_public1" {
  vpc_id     = aws_vpc.levelup_vpc.id
  cidr_block = "172.20.1.0/24"
   map_public_ip_on_launch = "true"
   availability_zone = "us-east-2a"

  tags = {
    Name = "levelup_vpc_public1"
  }
}

resource "aws_subnet" "levelup_vpc_public2" {
  vpc_id     = aws_vpc.levelup_vpc.id
  cidr_block = "172.20.2.0/24"
   map_public_ip_on_launch = "true"
   availability_zone = "us-east-2b"

  tags = {
    Name = "levelup_vpc_public2"
  }
}

resource "aws_subnet" "levelup_vpc_public3" {
  vpc_id     = aws_vpc.levelup_vpc.id
  cidr_block = "172.20.3.0/24"
   map_public_ip_on_launch = "true"
   availability_zone = "us-east-2c"

  tags = {
    Name = "levelup_vpc_public3"
  }
}

#Private subnet in VPC
resource "aws_subnet" "levelup_vpc_private1" {
  vpc_id     = aws_vpc.levelup_vpc.id
  cidr_block = "172.20.4.0/24"
   map_public_ip_on_launch = "false"
   availability_zone = "us-east-2a"

  tags = {
    Name = "levelup_vpc_priveate1"
  }
}

resource "aws_subnet" "levelup_vpc_private2" {
  vpc_id     = aws_vpc.levelup_vpc.id
  cidr_block = "172.20.5.0/24"
   map_public_ip_on_launch = "false"
   availability_zone = "us-east-2b"

  tags = {
    Name = "levelup_vpc_private2"
  }
}

resource "aws_subnet" "levelup_vpc_private3" {
  vpc_id     = aws_vpc.levelup_vpc.id
  cidr_block = "172.20.6.0/24"
   map_public_ip_on_launch = "false"
   availability_zone = "us-east-2c"

  tags = {
    Name = "levelup_vpc_private3"
  }
}

#Define custome Internet gateway
resource "aws_internet_gateway" "levelup-gw" {
  vpc_id = aws_vpc.levelup_vpc.id

  tags = {
    Name = "levelup-gw"
  }
}

#Define routing table
resource "aws_route_table" "levelup_public" {
  vpc_id = aws_vpc.levelup_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.levelup-gw.id
  }

  tags = {
    Name = "levelup_public"
  }
}

#Associate route table
resource "aws_route_table_association" "levelup_public_1_a" {
  subnet_id      = aws_subnet.levelup_vpc_public1.id
  route_table_id = aws_route_table.levelup_public.id
}

resource "aws_route_table_association" "levelup_public_2_a" {
  subnet_id      = aws_subnet.levelup_vpc_public2.id
  route_table_id = aws_route_table.levelup_public.id
}

.resource "aws_route_table_association" "levelup_public_3_a" {
  subnet_id      = aws_subnet.levelup_vpc_public3.id
  route_table_id = aws_route_table.levelup_public.id
}