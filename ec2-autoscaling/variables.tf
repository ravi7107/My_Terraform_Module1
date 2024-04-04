variable "ami_id" {
  description = "Specify the instance ami that you want to use for the instance."
  type        = map
  default     = {
     "us-east-2" = "ami-0900fe555666598a2"
     "us-west-1" = "ami-0b990d3cfca306617"
  }
}

variable "region" {
    type        = map
  default     = {
     ["us-east-2" ,"us-west-2"]
  } 
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
