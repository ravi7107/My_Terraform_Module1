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

