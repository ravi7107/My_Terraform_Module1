resource "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www.${var.domain_name}"
  type    = "CNAME"
  ttl     = 300
  records = [aws_s3_bucket.website_bucket.website_endpoint]
}

resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "CNAME"
  ttl     = 300
  records = [aws_s3_bucket.website_bucket.website_endpoint]
}

resource "aws_route53_record" "ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "NS"
  ttl     = 300
  records = aws_route53_zone.main.name_servers
}
