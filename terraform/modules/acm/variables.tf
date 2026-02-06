variable "domain_name" {
  description = "Primary domain name for the ACM certificate"
  type        = string
}

variable "subject_alternative_names" {
  description = "Subject Alternative Names (SANs) for the certificate"
  type        = list(string)
  default     = []
}

variable "certificate_transparency_logging" {
  description = "Enable or disable certificate transparency logging"
  type        = string
  default     = "ENABLED"
}