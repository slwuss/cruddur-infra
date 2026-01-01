variable "name" {
  type        = string
  description = "VPC name prefix"
}

variable "cidr_block" {
  type        = string
  description = "VPC CIDR block"
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
}

variable "public_subnets" {
  type        = list(string)
  description = "Public subnet CIDRs"
}
