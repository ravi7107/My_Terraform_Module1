resource "aws_s3_bucket" "bucket-1" {
    bucket = "web-bucket-080624"
  
}

resource "aws_s3_bucket_public_access_block" "buckrt-1" {
    bucket= aws_s3_bucket.bucket-1.id

    block_public_acls = false
    block_public_policy = false
    ignore_public_acls = false
    restrict_public_buckets = false
  
}

resource "aws_s3_object" "index" {
    bucket = "web-bucket-080624"
    key = "index.html"
    source= "index.html"
    content_type = "text/html"
  
}

resource "aws_s3_object" "error" {
    bucket = "web-bucket-080624"
    key = "error.html"
    source = "index.html"
    content_type = "text/html"
  
}

resource "aws_s3_bucket_website_configuration" "bucket-1" {
    bucket = aws_s3_bucket.bucket-1.id

    index_document {
      suffix = "index.html"

    }

    error_document {
      key = "error.html"
    }

}

resource "aws_s3_bucket_policy" "public_read_access" {
  bucket = aws_s3_bucket.bucket-1.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
	  "Principal": "*",
      "Action": [ "s3:GetObject" ],
      "Resource": [
        "${aws_s3_bucket.bucket-1.arn}",
        "${aws_s3_bucket.bucket-1.arn}/*"
      ]
    }
  ]
}
EOF
}

resource "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_s3_bucket.bucket-1.website_endpoint
    zone_id                = aws_s3_bucket.bucket-1.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_s3_bucket.bucket-1.website_endpoint
    zone_id                = aws_s3_bucket.bucket-1.hosted_zone_id
    evaluate_target_health = false
  }
}