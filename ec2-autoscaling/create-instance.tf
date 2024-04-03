resource "aws_instance" "Server-1" {
  ami           = lookup(var.ami_id, var.region)
  instance_type = var.instance_type
  #subnet_id     = aws_subnet.custom-vpc-public-subnet-one.id
  key_name      = var.key_name

  tags = {
    Name = "Server-1"
  }
}

resource "aws_key_pair" "levelup_key" {
  key_name   = var.levelup_key
  public_key = file("${abspath(path.cwd)}/levelup_key.pub")
}