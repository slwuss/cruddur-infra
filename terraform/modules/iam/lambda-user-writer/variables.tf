variable "role_name" {
  type        = string
  description = "IAM role name for the Lambda"
}

variable "lambda_name" {
  type        = string
  description = "Lambda function name (for log group)"
}

variable "region" {
  type    = string
  default = "ap-southeast-2"
}

variable "postgres_secret_arn" {
  type = string
}