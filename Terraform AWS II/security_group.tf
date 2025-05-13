#Security group for levelup VPC

resource "aws_security_group" "allow_levelup_ssh" {
  name          = "allow_levelup_ssh"
  description   = "allow_levelup_ssh"
  vpc_id        = aws_vpc.levelup_vpc.id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow_levelup_ssh"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow https access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "Custom security group"
  }
}

#Scurity group for MariaDB

resource "aws_security_group" "allow_mariadb" {
  name          = "allow_mariadb"
  description   = "security group for Maria DB"
  vpc_id        = aws_vpc.levelup_vpc.id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_group = [aws_security_gorup.allow_lvelup_ssh.id]
  }

  tags = {
    Name        = "allow-mariadb"
  }
}