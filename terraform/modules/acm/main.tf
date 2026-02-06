resource "aws_acm_certificate" "cruddur_domain" {
  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method         = "DNS"

  options {
    certificate_transparency_logging_preference = var.certificate_transparency_logging
  }
}


