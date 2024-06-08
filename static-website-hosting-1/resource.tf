resource "aws_s3_bucket" "bucket_1" {
  bucket = "web-bucket1-080624"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_1" {
  bucket = aws_s3_bucket.bucket_1.id

  block_public_acls   = false
  block_public_policy = false
  ignore_public_acls  = false
  restrict_public_buckets = false
}

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.bucket_1.bucket
  key          = "index.html"
  source       = "/home/ubuntu/My_Terraform_Module1/static-website-hosting-1/index.html"  # Update to the correct path
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.bucket_1.bucket
  key          = "error.html"
  source       = "/home/ubuntu/My_Terraform_Module1/static-website-hosting-1/error.html"  # Update to the correct path
  content_type = "text/html"
}

resource "aws_s3_bucket_policy" "public_read_access" {
  bucket = aws_s3_bucket.bucket_1.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": [
        "${aws_s3_bucket.bucket_1.arn}/*"
      ]
    }
  ]
}
EOF
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "http://quickshifts.in/"
  type    = "A"
  ttl     = 300
  records = [aws_eip.lb.public_ip]
}