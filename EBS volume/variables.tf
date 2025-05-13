variable "AWS_REGION" {
    description = "AWS region to define to create AWS resources"
    type = string
    default = "ap-south-1"
}

variable "instance_type" {
  description = "AWS instance type to create EC2 instance"
  type = string
  default = "t2.micro"
}
variable "AMIS" {
    description = "AMI to use for instance"
    type = string
    default = "ami-0cc9838aa7ab1dce7"
}

variable "volume_size" {
  description = "The size of the EBS voulume in Gigabytes"
  type = number
  default = 10
}
variable "availability_zone" {
  description = "AWS availibility zone for instance"
  type = string
  default = "ap-south-1a"
  
}

variable "level_up2" {
  description = "The name of the key pair to use for the instance"
  type = string
  default = "level_up2"
  
}


variable "PATH_TO_PRIVATE_KEY" {
  default = "level_up2"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "level_up2.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}