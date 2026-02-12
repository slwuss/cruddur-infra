variable "function_name" {
  type = string
}

variable "role_arn" {
  type = string
}

variable "handler" {
  type = string
}

variable "runtime" {
  type = string
}

variable "timeout" {
  type = number
}

variable "memory_size" {
  type = number
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "environment_variables" {
  type = map(string)
}

variable "s3_bucket" {
  type        = string
  description = "S3 bucket containing lambda artifact"
}

variable "s3_key" {
  type        = string
  description = "S3 key (path) to lambda zip file"
}

variable "cognito_arn" {
  type        = string
  description = "Cognito User Pool ARN to allow invocation permissions"
}

variable "cognito_id" {
  type        = string
  description = "Cognito User Pool ID to allow invocation permissions"
}