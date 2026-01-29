variable "name" {
  type = string
}

variable "domain" {
  type = string
}

variable "deletion_protection" {
  type = string
}

variable "mfa_configuration" {
  type = string
}

variable "post_confirmation_arn" {
  type = string
}

variable "aws_cognito_user_pool_client_name" {
  type        = string
  description = "Cognito user pool client name"
}

variable "explicit_auth_flows" {
  type        = list(string)
  description = "Explicit authentication flows"
}

