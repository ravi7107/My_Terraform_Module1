resource "aws_instance" "MyFirstInstance" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"  # Replace with your desired instance type
}

