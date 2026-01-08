variable "identifier" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "storage_type" {
  type    = string
  default = "gp2"
}

variable "db_name" {
  type = string
}

variable "username" {
  type    = string
  default = "root"
}

variable "publicly_accessible" {
  type = bool
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "maintenance_window" {
  type = string
}

variable "backup_retention_period" {
  type = number
}

variable "parameter_group_name" {
  type = string
}

variable "option_group_name" {
  type = string
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs"
}

