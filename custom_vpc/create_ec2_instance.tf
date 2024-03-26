resource "aws_instance" "web_instance" {
  ami           = lookup(var.ami_id, var.region)
  instance_type = var.instance_type
  subnet_id     = aws_subnet.levelup_vpc_public1.id
  vpc_security_group_ids = [aws_security_group.custom-vpc-security-group.id]
  key_name      = var.key_name

  tags = {
    Name = var.ec2_tags
  }
}