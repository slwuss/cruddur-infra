variable "vpc_id" {
  type        = string
  description = "VPC ID where ECS and namespace will be created"
}

variable "private_subnets" {
  type        = list(string)
  description = "Private subnet IDs for ECS services"
}


variable "cluster_name" {
  type        = string
  description = "ECS cluster name"
}


variable "backend_image" {
  type        = string
  description = "Docker image URI for backend service (ECR)"
}

variable "frontend_image" {
  type        = string
  description = "Docker image URI for frontend service (ECR)"
  default     = null
}

variable "backend_desired_count" {
  type        = number
  description = "Desired number of backend ECS tasks"
  default     = 2
}

variable "frontend_desired_count" {
  type        = number
  description = "Desired number of frontend ECS tasks"
  default     = 1
}


variable "backend_sg" {
  type        = string
  description = "Security group ID for backend ECS service"
}

variable "frontend_sg" {
  type        = string
  description = "Security group ID for frontend ECS service"
  default     = null
}

variable "backend_tg" {
  type        = string
  description = "ALB target group ARN for backend service"
}

variable "frontend_tg" {
  type        = string
  description = "ALB target group ARN for frontend service"
  default     = null
}

variable "namespace_name" {
  type        = string
  description = "Private DNS namespace name (e.g. cruddur.local)"
  default     = "cruddur.local"
}

variable "backend_discovery_service" {
  type        = string
  description = "Cloud Map service ARN for backend ECS service"
}

variable "frontend_discovery_service" {
  type        = string
  description = "Cloud Map service ARN for frontend ECS service"
  default     = null
}