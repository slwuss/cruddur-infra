resource "aws_iam_policy" "read_postgres_secret" {
  name = "${var.role_name}-read-postgres-secret"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = var.postgres_secret_arn
      }
    ]
  })
}