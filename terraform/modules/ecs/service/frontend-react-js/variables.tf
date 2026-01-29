variable "name" {
  type = string
}

variable "cluster_arn" {
  type = string
}

variable "task_definition" {
  type = string
}

variable "desired_count" {
  type    = number
  default = 0
}

variable "subnets" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)
}

variable "assign_public_ip" {
  type    = bool
  default = true
}

variable "target_group_arn" {
  type = string
}

variable "container_name" {
  type = string
}

variable "container_port" {
  type = number
}