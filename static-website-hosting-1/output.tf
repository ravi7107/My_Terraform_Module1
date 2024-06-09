output "website_url" {
  value = aws_s3_bucket.website_bucket.website_endpoint
}

output "rds_endpoint" {
  value = aws_db_instance.db_instance.endpoint
}

output "domain_name" {
  value = var.domain_name
}

output "zone_id" {
  value = aws_route53_zone.main.zone_id
}

output "name_servers" {
  value = aws_route53_zone.main.name_servers
}
