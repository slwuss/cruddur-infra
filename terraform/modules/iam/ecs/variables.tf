variable "execution_role_name" {
  type        = string
  description = "IAM role name for the ECS Task Execution Role"
}

variable "task_role_name" {
  type        = string
  description = "IAM role name for the ECS Task Role"
}