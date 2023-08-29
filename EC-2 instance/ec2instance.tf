provider "aws" {
  region = "us-east-2a"  # Change to your desired region
}

resource "aws_instance" "web_instance" {
  ami           = lookup(var.ami_id, var.region)
  instance_type = var.instance_type
  subnet_id     = aws_subnet.custom-vpc-public-subnet-one.id
  key_name      = var.key_name

  tags = {
    Name = var.ec2_tags
  }
}