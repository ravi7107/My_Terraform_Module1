resource "aws_instance" "MyFirstInstance" {
  ami           = "ami-0261755bbcb8c4a84"
  instance_type = "t2.micro"  # Replace with your desired instance type
}