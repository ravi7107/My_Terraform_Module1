resource "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_s3_bucket.website_bucket.bucket_regional_domain_name
    zone_id                = aws_s3_bucket.website_bucket.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_s3_bucket.website_bucket.bucket_regional_domain_name
    zone_id                = aws_s3_bucket.website_bucket.hosted_zone_id
    evaluate_target_health = false
  }
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

variable "current_zone" {
  description = "Current zone settings based on the selected region"
  type = object({
    domain_name = string
    zone_id     = string
  })
  default = var.zone_map[var.region]
}
