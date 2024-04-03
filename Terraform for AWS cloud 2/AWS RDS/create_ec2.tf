resource "aws_instance" "first_instance" {
  ami                     = "ami-019f9b3318b7155c5"
  instance_type           = "t2.micro"
  availability_zone       ="us-east-2a" 
  key_name = "var.levelup_key"
 

  tags = {
    Name= "My first instance"
  }
}

resource "aws_key_pair" "levelup_key" {
  key_name   = "var.levelup_key"
  public_key = file("${abspath(path.cwd)}/levelup_key.pub")
}