variable "backend_desired_count" {
  type        = number
  description = "Desired number of backend ECS tasks"
  default     = 1
}

variable "frontend_desired_count" {
  type        = number
  description = "Desired number of frontend ECS tasks"
  default     = 1
}