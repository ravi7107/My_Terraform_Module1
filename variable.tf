variable "access_key" {
        description = "AKIA6KE3AQUXJRNL33XH""
}
variable "secret_key" {
        description = "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"


variable "instance_name" {
        description = "MyInstance1"
        default = "awsbuilder-demo"
}

variable "instance_type" {
        default = "t2.micro"
}

variable "ami_id" {
        description = "The AMI to use"
        default = "ami-053b0d53c279acc90"
}

variable "number_of_instances" {
        description = "number of instances to be created"
        default = 1
}
