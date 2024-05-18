provider "aws" {
    region = "us-east-2" 
  
}
#craete a VPC
resource "aws_vpc" "omniactives" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "omniactives"
    }
  
}

#craeete a subnet
resource "aws_subnet" "private" {
    vpc_id = aws_vpc.omniactives.id
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

#create a route table
resource "aws_route_table" "main_rt" {
    vpc_id = aws_vpc.omniactives.id

    route = {

        cidr_block = "0.0.0.0/0"
        Gateway_id = aws_internet_gateway.id
        
    }

    tags = {
      Name = "main_rt"
    }
  
}

#Associate the route table with the subnet
resource "aws_route_table_association" "name" {
    subnet_id = aws_subnet.private.id
    route_table_id = aws_route_table.main_rt.id
  
}


#create a security group
resource "aws_security_group" "private_sg" {
    vpc_id = aws_vpc.omniactives.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
  
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "main_security_group"
    }
}

#create an EC2 instance

resource "aws_instance" "tf_1" {
    ami = "ami-09040d770ffe2224f"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.private.id
    security_groups = [aws_security_group.private_sg.name]

    tags = {
      name = "main_instance"
    }
  
}

