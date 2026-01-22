variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)
}

variable "access_logs" {
  type = object({
    enabled = bool
    bucket  = string
    prefix  = string
  })
}

variable "certificate_arn" {
  type        = string
  description = "ACM certificate ARN for HTTPS listener"
}

variable "frontend_target_group_arn" {
  type        = string
}

variable "backend_target_group_arn" {
  type        = string
}