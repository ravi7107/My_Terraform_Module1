#creat EC-2 instance 
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "hloMnwnopqBw3h9ZnRPycO3IBk+CbQac8okbGUNCCuM r.r.shete@gmail.com"
}

resource "aws_instance" "my_instance" {
  ami           = "ami-024e6efaf93d85776"  # Replace with Ubuntu AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.levelup_vpc_public1.id
  vpc_security_group_ids = [aws_security_group.allow_levelup_ssh.id]
  
  
  // Add key_name for SSH access
  
  // Disable public IP assignment
  associate_public_ip_address = true
}
