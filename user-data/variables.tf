

variable "AMIS" {
    type = map
    default = {
        us-east-1 = "ami-0c101f26f147fa7fd"
        us-east-2 = "ami-019f9b3318b7155c5"
        us-east-2 = "ami-019f9b3318b7155c5"
    }
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