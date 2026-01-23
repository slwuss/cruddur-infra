variable "family" {
  type        = string
  description = "Task definition family name"
}

variable "cpu" {
  type = string
}

variable "memory" {
  type = string
}

variable "execution_role_arn" {
  type = string
}

variable "task_role_arn" {
  type = string
}


variable "family" {
  type = string
}

variable "cpu" {
  type = string
}

variable "memory" {
  type = string
}

variable "execution_role_arn" {
  type = string
}

variable "task_role_arn" {
  type = string
}

variable "ecr_repo" {
  type = string
}

variable "region" {
  type = string
}

variable "log_group" {
  type = string
}

variable "frontend_url" {
  type = string
}

variable "backend_url" {
  type = string
}

variable "cognito_user_pool_id" {
  type = string
}

variable "cognito_user_pool_client_id" {
  type = string
}

variable "ssm_aws_access_key_id" {
  type = string
}

variable "ssm_aws_secret_access_key" {
  type = string
}

variable "ssm_connection_url" {
  type = string
}

variable "ssm_otel_headers" {
  type = string
}

variable "enable_xray" {
  type    = bool
  default = true
}