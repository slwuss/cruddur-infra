output "execution_role_arn" {
  value = aws_iam_role.ecsTaskExecutionRole.arn
}

output "task_role_arn" {
  value = aws_iam_role.ecsTaskRole.arn
}