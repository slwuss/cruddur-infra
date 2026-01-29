variable "log_group_name" {
  description = "CloudWatch Log Group name"
  type        = string
}

variable "retention_in_days" {
  description = "Log retention period (days)"
  type        = number
  default     = 14
}