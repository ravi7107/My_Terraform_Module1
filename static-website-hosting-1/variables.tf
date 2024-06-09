variable "region" {
  description = "The AWS region to deploy resources in"
  default     = "us-east-1"
}
variable "zone_map" {
  description = "Map of regions to Route 53 hosted zone IDs"
  type = map(object({
    domain_name = string
    zone_id     = string
  }))
  default = {
    "us-east-1" = {
      domain_name = "example.com"
      zone_id     = "Z3M3LMPEXAMPLE"
    },
    "us-west-2" = {
      domain_name = "example-west.com"
      zone_id     = "Z2LMNOPEXAMPLE"
    }
  }
}

variable "domain_name" {
  description = "The domain name to associate with this site"
  default     = "quickshifts.in"
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
