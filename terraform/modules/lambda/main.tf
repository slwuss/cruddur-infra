# resource "aws_lambda_function" "cognito-user_pool_id_post_confirmation" {
#   function_name = var.function_name
#   role          = var.role_arn
#   handler       = var.handler
#   runtime       = var.runtime

#   timeout      = var.timeout
#   memory_size = var.memory_size

#   package_type = "Zip"

#   environment {
#     variables = var.environment_variables
#   }

#   vpc_config {
#     subnet_ids         = var.subnet_ids
#     security_group_ids = var.security_group_ids
#   }

#   lifecycle {
#     ignore_changes = [
#       filename,
#       source_code_hash,
#       last_modified,
#       qualified_arn,
#       version,
#     ]
#   }
# }