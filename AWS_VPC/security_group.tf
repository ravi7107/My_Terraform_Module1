#security group for levelup vpc
depends_on = [aws_key_pair.MyKP]

resource "aws_security_group" "allow_levelup_ssh" {
  name        = "allow_levelup_ssh"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.levelup_vpc.id

  ingress {
    description      = "TCP from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_levelup_ssh"
  }
}