resource "aws_instance" "example-1" {
  ami = var.AMIS
  instance_type = var.instance_type
  availability_zone = var.availability_zone
  key_name = var.level_up2

  tags = {
    Name = "my_EC2_instance-1"
  }
  
}

resource "aws_ebs_volume" "example-1" {
  availability_zone = var.availability_zone
  size = var.volume_size

    tags = {
      Name = "my-ebs-volume"
    }
  
}

resource "aws_volume_attachment" "example" {
    device_name = "/dev/sdh7107"
    volume_id = aws_ebs_volume.example-1.id
    instance_id = aws_instance.example-1.id
    depends_on = [ aws_instance.example-1 ]
  
}

