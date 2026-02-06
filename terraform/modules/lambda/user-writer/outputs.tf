output "lambda_arn" {
  description = "ARN of user writer lambda"
  value       = aws_lambda_function.lambda_user_writer.arn
}