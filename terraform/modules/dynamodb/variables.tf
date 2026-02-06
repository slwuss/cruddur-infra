variable "name" {
  description = "DynamoDB table name"
  type        = string
}

variable "billing_mode" {
  description = "Billing mode for DynamoDB (PROVISIONED or PAY_PER_REQUEST)"
  type        = string
}

variable "hash_key" {
  description = "Partition key (HASH)"
  type        = string
}

variable "range_key" {
  description = "Sort key (RANGE)"
  type        = string
}

variable "read_capacity" {
  description = "Read capacity units (only for PROVISIONED)"
  type        = number
}

variable "write_capacity" {
  description = "Write capacity units (only for PROVISIONED)"
  type        = number
}

variable "stream_enabled" {
  description = "Enable DynamoDB Streams"
  type        = bool
}

variable "stream_view_type" {
  description = "Stream view type (e.g. NEW_AND_OLD_IMAGES)"
  type        = string
}

variable "gsi_name" {
  description = "Global Secondary Index name"
  type        = string
}

variable "gsi_hash_key" {
  description = "GSI partition key"
  type        = string
}

variable "gsi_read_capacity" {
  description = "GSI read capacity"
  type        = number
}

variable "gsi_write_capacity" {
  description = "GSI write capacity"
  type        = number
}