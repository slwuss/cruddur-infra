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

variable "ecr_repo" {
  type = string
}

variable "region" {
  type = string
}

variable "log_group" {
  type = string
}


variable "enable_xray" {
  type    = bool
  default = true
}