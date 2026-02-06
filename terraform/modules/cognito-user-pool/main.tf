resource "aws_cognito_user_pool" "this" {
  name                = var.name
  deletion_protection = var.deletion_protection
  mfa_configuration   = var.mfa_configuration

  alias_attributes         = ["email"]
  auto_verified_attributes = ["email"]

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
    recovery_mechanism {
      name     = "verified_phone_number"
      priority = 2
    }
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  lambda_config {
    post_confirmation = var.post_confirmation_arn
  }

  password_policy {
    minimum_length                   = 8
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = true
    require_uppercase                = true
    temporary_password_validity_days = 7
  }

  schema {
    name                = "email"
    attribute_data_type = "String"
    required            = true
    mutable             = true
  }

  schema {
    name                = "name"
    attribute_data_type = "String"
    required            = true
    mutable             = true
  }

  schema {
    name                = "preferred_username"
    attribute_data_type = "String"
    required            = true
    mutable             = true
  }

  sign_in_policy {
    allowed_first_auth_factors = ["PASSWORD"]
  }

  username_configuration {
    case_sensitive = false
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
  }
}

resource "aws_cognito_user_pool_domain" "this" {
  domain       = var.domain
  user_pool_id = aws_cognito_user_pool.this.id
}

resource "aws_cognito_user_pool_client" "this" {
  name         = var.aws_cognito_user_pool_client_name
  user_pool_id = aws_cognito_user_pool.this.id

  explicit_auth_flows = var.explicit_auth_flows

  prevent_user_existence_errors = "ENABLED"
}