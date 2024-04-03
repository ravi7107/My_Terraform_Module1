variable "ami_id" {
    type = string
    default = "ami-019f9b3318b7155c5"     
}

variable "region" {
    default = "us-east-2a" 
}

variable "instance_type" {
    default = "t2.micro"
  
# variables.tf

variable "levelup_key" {
  description = "Name of the key pair for the AWS EC2 instance"
  default= "levelup_key"
}

variable "key_name" {
  description = "Name of the key pair for AWS Key Pair resource"
}

variable "levelup_key_pub" {
  default = "levelup_key.pub"
}
