
variable "instance_type" {
        default = "t2.micro"
        }

variable "number_of_instances" {
        default = "1"
        }

variable "ami_id" {
        description = "The AMI to use"
        default = "ami-053b0d53c279acc90"
        }
