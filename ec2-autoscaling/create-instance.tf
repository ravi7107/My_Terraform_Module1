resource "aws_instance" "Server-1" {
  ami           = lookup(var.ami_id, var.region)
  instance_type = var.instance_type
  #subnet_id     = aws_subnet.custom-vpc-public-subnet-one.id
  key_name      = var.key_name

  tags = {
    Name = "Server-1"
  }
}