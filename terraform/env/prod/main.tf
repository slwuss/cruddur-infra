module "vpc" {
  source = "../../modules/vpc"

  name            = var.project_name
  cidr_block      = "10.10.0.0/16"

  azs = [
    "ap-southeast-2a",
    "ap-southeast-2b"
  ]

  public_subnets = [
    "10.10.1.0/24",
    "10.10.2.0/24"
  ]

  region = "ap-southeast-2"

}

module "messages_table" {
  source = "../../modules/dynamodb"

  name         = "cruddur-messages-prod"
  billing_mode = "PROVISIONED"

  hash_key  = "pk"
  range_key = "sk"

  read_capacity  = 5
  write_capacity = 5

  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  gsi_name           = "message-group-sk-index"
  gsi_hash_key       = "message_group_uuid"
  gsi_read_capacity  = 5
  gsi_write_capacity = 5
}

module "cognito_user_pool" {
  source = "../../modules/cognito-user-pool"

  name                  = "User pool - Cruddur Prod"
  domain                = "cruddur-prod-auth"
  deletion_protection   = "ACTIVE"
  mfa_configuration     = "OFF"

  post_confirmation_arn = "arn:aws:lambda:ap-southeast-2:739623014075:function:cruddur"
}

module "lambda_cognito" {
  source = "../../modules/lambda"

  function_name = "cognito-user_pool_id_post_confirmation"
  role_arn      = "arn:aws:iam::739623014075:role/service-role/cruddur-role-ie9zkox4"

  handler = "lambda_function.lambda_handler"
  runtime = "python3.12"

  timeout     = 60
  memory_size = 128

  subnet_ids = [
    module.vpc.public_subnet_ids
  ]

  security_group_ids = [
    "sg-0a2f601a6a3c2a2b2",
  ]

  environment_variables = {
    CONNECTION_URL = "postgresql://root:Seenlawat19@cruddur-db-instance.c98k62ueon7e.ap-southeast-2.rds.amazonaws.com:5432/cruddur"
  }
}