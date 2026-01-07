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
  deletion_protection   = "INACTIVE"
  mfa_configuration     = "OFF"

  post_confirmation_arn = module.lambda_user_writer.lambda_arn
}

module "lambda_user_writer" {
  source = "../../modules/lambda/user-writer"

  function_name = "cruddur-user-writer"
  role_arn      = module.iam_lambda_user_writer.lambda_user_writer_role_arn

  handler = "lambda_function.lambda_handler"
  runtime = "python3.12"

  s3_bucket = "cruddur-lambda-artifacts-prod"
  s3_key    = "user-writer/v1.0.0.zip"
  
  timeout     = 60
  memory_size = 128

  subnet_ids = module.vpc.public_subnet_ids

  security_group_ids = [
    module.security_groups.lambda_user_sg_id
  ]
  environment_variables = {
    DB_HOST             = module.postgres.endpoint
    DB_PORT             = "5432"
    DB_NAME             = "cruddur"
    POSTGRES_SECRET_ARN = module.postgres.master_user_secret_arn
  }

}

module "security_groups" {
  source = "../../modules/security-groups"

  vpc_id = module.vpc.vpc_id
}

module "postgres" {
  source = "../../modules/postgres"

  identifier            = "cruddur-db-instance-prod"
  engine_version        = "17.6"
  instance_class        = "db.t4g.micro"
  allocated_storage     = 20
  db_name               = "cruddur"

  publicly_accessible   = true
  vpc_security_group_ids = [
    module.security_groups.rds_sg_id
  ]
  db_subnet_group_name = "default"

  maintenance_window      = "wed:13:49-wed:14:19"
  backup_retention_period = 0

  parameter_group_name = "default.postgres17"
  option_group_name    = "default:postgres-17"
}

module "iam_lambda_user_writer" {
  source = "../../modules/iam/lambda-user-writer"

  role_name = "cruddur-user-writer-lambda-role"
  lambda_name = "cruddur-user-writer"
  region = "ap-southeast-2"

  postgres_secret_arn  = module.postgres.master_user_secret_arn

}