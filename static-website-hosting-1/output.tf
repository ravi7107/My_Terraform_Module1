output "website_url" {
  value = aws_s3_bucket_website_configuration.website_bucket.website_endpoint
}

output "rds_endpoint" {
  value = aws_db_instance.default.endpoint
}

output "domain_name" {
  value = aws_route53_zone.main.name
}

output "zone_id" {
  value = aws_route53_zone.main.zone_id
}
