resource "aws_acm_certificate" "main" {
  domain_name       = "project-cruddur.com"
  validation_method = "DNS"
}