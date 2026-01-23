resource "aws_s3_bucket" "alb_log_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "alb_log_bucket" {
  bucket = aws_s3_bucket.alb_log_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "alb_log_bucket" {
  bucket = aws_s3_bucket.alb_log_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "alb_log_bucket" {
  bucket = aws_s3_bucket.alb_log_bucket.id

  rule {
    id     = "expire-alb-logs"
    status = "Enabled"

    filter {} 

    expiration {
      days = 90
    }
  }
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket_policy" "alb_log_bucket" {
  bucket = aws_s3_bucket.alb_log_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowALBAccessLogs"
        Effect = "Allow"

        Principal = {
          Service = "logdelivery.elasticloadbalancing.amazonaws.com"
        }

        Action   = "s3:PutObject"
        Resource = "${aws_s3_bucket.alb_log_bucket.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"

        Condition = {
          StringEquals = {
            "s3:x-amz-acl"      = "bucket-owner-full-control"
            "aws:SourceAccount" = "${data.aws_caller_identity.current.account_id}"
          }
        }
      }
    ]
  })
}