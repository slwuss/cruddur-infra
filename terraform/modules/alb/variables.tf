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