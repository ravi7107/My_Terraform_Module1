resource "aws_instance" "first_instance" {
  ami                     = "ami-0c101f26f147fa7fd"
  instance_type           = "t2.micro"
  key_name = var.my_tf_key
}