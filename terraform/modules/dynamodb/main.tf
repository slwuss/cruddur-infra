resource "aws_dynamodb_table" "cruddur-messages-prod" {
  name         = var.name
  billing_mode = var.billing_mode

  hash_key  = var.hash_key
  range_key = var.range_key

  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity

  stream_enabled   = var.stream_enabled
  stream_view_type = var.stream_view_type

  attribute {
    name = var.hash_key
    type = "S"
  }

  attribute {
    name = var.range_key
    type = "S"
  }

  attribute {
    name = var.gsi_hash_key
    type = "S"
  }

  global_secondary_index {
    name            = var.gsi_name
    hash_key        = var.gsi_hash_key
    range_key       = var.range_key
    projection_type = "ALL"

    read_capacity  = var.gsi_read_capacity
    write_capacity = var.gsi_write_capacity
  }

  #   lifecycle {
  #     prevent_destroy = true
  #   }
}