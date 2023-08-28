provider "aws" {
  region = "us-east-2a"  # Change to your desired region
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDlhDV5x/lv1ddNMBMQ0e3d5MvdFeU9QId9OvWlgO5haJL5R7Zm/9RG1sKWaQUvdJ46U79wsEmC07VIjxqnsxqUJvogGCdS7il3yTEGUZ86F1K/37wExuKRDtpKT8IMfgXFwOhMf109YzY1Gjo9HfEh4zUqPPaTbAHTIoSvZwK8Bq0G7rZ4FfVP8IgCSCSDyx9smdXSzlp5mbw2q0ahnUBnh7adc4o6GX8W1TjCxIDORKKQABbYtyxv+mb4yVxeRt7mFFqFviUDTysmgyqMCrqzAbK0T+qpI2e0BntIjWW5dHoX/GgNWeBhbiGshm6WMGT5Ps1yLfO6kiTW7EtM2ql5 Mykp-Aug"
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
  vpc_security_group_ids = [aws_security_group.allow_levelup_ssh.id]
  
  
  // Add key_name for SSH access
  
  // Disable public IP assignment
  associate_public_ip_address = false
}
