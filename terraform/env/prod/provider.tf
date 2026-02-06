provider "aws" {
  region = "ap-southeast-2"
}

variable "environment" {
  type    = string
  default = "prod"
}