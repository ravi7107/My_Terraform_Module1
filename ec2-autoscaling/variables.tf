variable "ami_id" {
  description = "Specify the instance ami that you want to use for the instance."
  type        = map
  default     = {
     "us-east-2" = "ami-098f16afa9edf40be"
     "us-west-2" = "ami-0f38562b9d4de0dfe"
  }
}

variable "region" {
    default = "us-east-2a" 
}

variable "instance_type" {
    default = "t2.micro"
}
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
