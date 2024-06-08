variable "region" {
  default = "us-east-1"
}

variable "domain_name" {
  description = "The domain name to associate with this site"
  type        = string
}
