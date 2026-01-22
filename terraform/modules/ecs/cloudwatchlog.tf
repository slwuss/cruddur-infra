resource "aws_cloudwatch_log_group" "backend" {
  name              = "/aws/ecs/backend"
  retention_in_days = 14
}