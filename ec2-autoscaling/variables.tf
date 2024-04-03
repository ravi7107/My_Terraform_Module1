variable "ami_id" {
    type = string
    default = "ami-019f9b3318b7155c5"     
}

variable "region" {
    default = "us-east-2a" 
}

variable "instance_type" {
    default = "t2.micro"
  
}

variable "key_name" {
  default = "levelup_key"
}

variable "levelup_key_pub" {
  default = "levelup_key.pub"
}
