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

variable "enable_execute_command" {
  type    = bool
  default = true
}

variable "enable_deployment_circuit_breaker" {
  type    = bool
  default = false
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

variable "assign_public_ip" {
  type    = bool
  default = true
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "service_connect" {
  type = object({
    namespace = string
    dns_name = string
  })
  default = null
}