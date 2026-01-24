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

  security_group_ids = [
    module.security_groups.secrets_endpoint_sg_id
    ]

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
    DB_HOST             = module.postgres.address
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

  subnet_ids = module.vpc.public_subnet_ids

  maintenance_window      = "wed:13:49-wed:14:19"
  backup_retention_period = 0

  parameter_group_name = "default.postgres17"
  option_group_name    = "default:postgres-17"
}

module "iam_ecs" {
  source = "../../modules/iam/ecs"
  execution_role_name = "CruddurTaskExecutionRole"
  task_role_name = "CruddurTaskRole"
}

module "iam_lambda_user_writer" {
  source = "../../modules/iam/lambda-user-writer"

  role_name = "cruddur-user-writer-lambda-role"
  lambda_name = "cruddur-user-writer"
  region = "ap-southeast-2"

  postgres_secret_arn  = module.postgres.master_user_secret_arn

}

module "acm" {
  source = "../../modules/acm"

  domain_name = "project-cruddur.com"
  subject_alternative_names = [
    "*.project-cruddur.com",
    "project-cruddur.com",
  ]
  certificate_transparency_logging = "ENABLED"

}

module "route53" {
  source = "../../modules/route53"

  name = "project-cruddur.com"

  alb_dns_name = module.alb.dns_name
  alb_zone_id = module.alb.zone_id
  
}

module "alb" {
  source = "../../modules/alb"

  name            = "cruddur-alb-prod"
  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnet_ids
  security_groups = [module.security_groups.alb_sg_id]

  access_logs = {
    enabled = true
    bucket  = module.alb_log_bucket.alb_log_bucket_name
    prefix  = null
  }

  certificate_arn = module.acm.certificate_arn

  frontend_target_group_arn = aws_lb_target_group.frontend.arn
  backend_target_group_arn  = aws_lb_target_group.backend.arn
}



module "alb_log_bucket" {
  source = "../../modules/s3/alb_log_bucket"

  bucket_name = "cruddur-alb-access-log-prod"
  alb_account_id = data.aws_caller_identity.current.account_id
}


module "ecs_cluster" {
  source = "../../modules/ecs/cluster"
  name   = "cruddur-prod"
  enable_container_insights = false
  service_connect_namespace_arn = null
}

module "backend_task_definition" {
  source = "../../modules/ecs/task-definition/backend-flask"

  family = "backend-flask"
  cpu    = "256"
  memory = "512"

  execution_role_arn = module.iam_ecs.execution_role_arn
  task_role_arn      = module.iam_ecs.task_role_arn

  ecr_repo  = "739623014075.dkr.ecr.ap-southeast-2.amazonaws.com/backend-flask"

  region     = "ap-southeast-2"
  log_group  = "cruddur"

  frontend_url = "https://project-cruddur.com"
  backend_url  = "https://api.project-cruddur.com"

  cognito_user_pool_id        = module.cognito_user_pool.cognito_user_pool_id
  cognito_user_pool_client_id = module.cognito_user_pool.cognito_user_pool_client_id

  ssm_aws_access_key_id     = "arn:aws:ssm:ap-southeast-2:739623014075:parameter/cruddur/backend-flask/AWS_ACCESS_KEY_ID"
  ssm_aws_secret_access_key = "arn:aws:ssm:ap-southeast-2:739623014075:parameter/cruddur/backend-flask/AWS_SECRET_ACCESS_KEY"
  ssm_connection_url        = "arn:aws:ssm:ap-southeast-2:739623014075:parameter/cruddur/backend-flask/CONNECTION_URL"
  ssm_otel_headers          = "arn:aws:ssm:ap-southeast-2:739623014075:parameter/cruddur/backend-flask/OTEL_EXPORTER_OTLP_HEADERS"

  enable_xray = true

}



module "backend_service" {
  source = "../../modules/ecs/service/backend-flask"

  name            = "backend-flask"
  cluster_arn     = module.ecs_cluster.cluster_id
  task_definition = module.backend_task_definition.arn

  desired_count = 0

  target_group_arn = aws_lb_target_group.backend.arn
  container_name   = "backend-flask"
  container_port   = 4567

  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = module.security_groups.be_sg_id

  service_connect = {
    namespace = "cruddur"
    dns_name  = "backend-flask.cruddur"
  }
}


module "frontend_tg" {
  source = "../modules/ecs/lb-tg/frontend-react-js"

  name   = "frontend-react-js"
  port   = 3000
  vpc_id = "vpc-03831627bdad79cd5"

  tags = {
    Service = "frontend"
    App     = "react"
  }
}