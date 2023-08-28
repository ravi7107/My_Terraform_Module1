provider "aws" {
  region = "us-east-2a"  # Change to your desired region
}

resource "aws_security_group" "instance_sg" {
  name_prefix = "instance-sg-"
  vpc_id      = aws_vpc.levelup_vpc.id
  
  // Define inbound and outbound rules here
}

resource "aws_instance" "my_instance" {
  ami           = "ami-024e6efaf93d85776"  # Replace with Ubuntu AMI ID
  instance_type = "t2.micro"
  subnet_id     = "levelup_vpc_public1"
  
  
  // Add key_name for SSH access
  
  // Disable public IP assignment
  associate_public_ip_address = false
}
