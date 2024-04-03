variable "AWS_ACCESS_KEY" {
    type = string
    default = "AKIASAZ4HDPTIDSWCUOX"
}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
default = "us-east-2"
}

variable "AMIS" {
    type = string
    default = "ami-0c101f26f147fa7fd"
       
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "levelup_key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "levelup_key.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}