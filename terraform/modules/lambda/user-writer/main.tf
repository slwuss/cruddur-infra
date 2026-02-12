resource "aws_lambda_function" "lambda_user_writer" {
  function_name = var.function_name
  role          = var.role_arn
  handler       = var.handler
  runtime       = var.runtime

  timeout     = var.timeout
  memory_size = var.memory_size

  package_type = "Zip"

  s3_bucket = var.s3_bucket
  s3_key    = var.s3_key

  environment {
    variables = var.environment_variables
  }

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

}

resource "aws_lambda_permission" "cognito_post_confirmation" {
  statement_id  = "CSI_PostConfirmation_${var.cognito_id}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_user_writer.function_name
  principal     = "cognito-idp.amazonaws.com"
  source_arn    = var.cognito_arn
}