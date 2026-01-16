output "certificate_arn" {
  description = "ARN of the ACM certificate"
  value       = aws_acm_certificate.cruddur_domain.arn
}

output "domain_name" {
  description = "Primary domain name of the certificate"
  value       = aws_acm_certificate.cruddur_domain.domain_name
}