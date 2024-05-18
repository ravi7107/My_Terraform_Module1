# Specify the provider
provider "aws" {
  region = "us-east-2"
}

# Create a VPC
resource "aws_vpc" "omniactives" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "omniactives"
  }
}

# Create a Subnet
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.omniactives.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "private_subnet1"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.omniactives.id

  tags = {
    Name = "main_igw"
  }
}

# Create a Route Table
resource "aws_route_table" "main_rt" {
  vpc_id = aws_vpc.omniactives.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "main_rt"
  }
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "name" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.main_rt.id
}

# Create a Security Group
resource "aws_security_group" "private_sg" {
  vpc_id = aws_vpc.omniactives.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "main_security_group"
  }
}

# Create an EC2 Instance
resource "aws_instance" "instance1" {
  ami             = "ami-09040d770ffe2224f"  # Ensure this AMI ID is valid in your chosen region
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.private.id
  security_groups = [aws_security_group.private_sg.name]

  tags = {
    Name = "main_instance"
  }
}

# Output the instance public IP
output "instance_public_ip" {
  value = aws_insstance.instance1.instance_public_ip
}
