variable "region" {
  default = "us-east-1"
}

variable "domain_name" {
  description = "The domain name to associate with this site"
  type        = string
}

variable "rds_instance_class" {
  description = "The RDS instance class"
  default     = "db.t3.micro"
}

variable "rds_engine" {
  description = "The database engine to use"
  default     = "mysql"
}

variable "rds_engine_version" {
  description = "The database engine version to use"
  default     = "8.0"
}

variable "rds_username" {
  description = "The database admin username"
  default     = "admin"
}

variable "rds_password" {
  description = "The database admin password"
  default     = "password"  # Make sure to replace this with a secure password
  sensitive   = true
}

variable "contact_details" {
  description = "Contact details for domain registration"
  type = object({
    first_name    = string
    last_name     = string
    contact_type  = string  # "PERSON" | "COMPANY" | "ASSOCIATION" | "PUBLIC_BODY" | "RESELLER"
    address_line1 = string
    city          = string
    state         = string
    country_code  = string
    postal_code   = string
    email         = string
    phone_number  = string
  })
}
