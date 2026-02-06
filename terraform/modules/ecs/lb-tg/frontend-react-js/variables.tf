variable "name" {
  type = string
}

variable "port" {
  type = number
}

variable "vpc_id" {
  type = string
}

variable "health_check_path" {
  type = string
}

variable "protocol" {
  type    = string
  default = "HTTP"
}

variable "target_type" {
  type    = string
  default = "ip"
}