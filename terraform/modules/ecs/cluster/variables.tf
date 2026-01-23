variable "name" {
  type        = string
  description = "ECS cluster name"
}

variable "enable_container_insights" {
  type        = bool
  description = "Enable CloudWatch Container Insights"
  default     = false
}

variable "service_connect_namespace_arn" {
  type        = string
  description = "Service Connect default namespace ARN"
  default     = null
}