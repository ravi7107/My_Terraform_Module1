variable "multi_az_config" {
  description = "Specify configurations for multiple availability zones"
  type        = map(object({
    instance_type  = string
    ami_id         = string
    key_name       = string
    key_name_pub   = string
    # Add more configuration options as needed
  }))
  default     = {
    "us-east-2" = {
      instance_type  = "t2.micro"
      ami_id         = "8ami-0900fe555666598a2"
      key_name       = "levelup_key"
      key_name_pub   = "levelup_key.pub"
    },
    "us-west-1" = {
      instance_type  = "t2.micro"
      ami_id         = "ami-0b990d3cfca306617"
      key_name       = "levelup_key"
      key_name_pub   = "levelup_key.pub"
    },
    # Add more availability zones and their configurations as needed
  }
}


variable "region" {
  type    = map(string)
  default = {
    "us-east-2" = "East US 2"
    "us-west-1" = "West US 1"
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
