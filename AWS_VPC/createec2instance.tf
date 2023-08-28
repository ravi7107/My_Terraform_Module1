#creat EC-2 instance 
resource "aws_instance" "my_instance" {
  ami           = "ami-024e6efaf93d85776"  # Replace with Ubuntu AMI ID
  instance_type = "t2.micro"
  key_name = "demo"
  subnet_id     = aws_subnet.levelup_vpc_public1.id
  vpc_security_group_ids = [aws_security_group.allow_levelup_ssh.id]
  
  
  // Add key_name for SSH access
  
  // Disable public IP assignment
  associate_public_ip_address = true
}
