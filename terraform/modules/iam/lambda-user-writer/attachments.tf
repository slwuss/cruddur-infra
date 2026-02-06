resource "aws_iam_role_policy_attachment" "logs" {
  role       = aws_iam_role.lambda_user_writer.name
  policy_arn = aws_iam_policy.lambda_logs.arn
}

resource "aws_iam_role_policy_attachment" "vpc" {
  role       = aws_iam_role.lambda_user_writer.name
  policy_arn = aws_iam_policy.lambda_vpc.arn
}

resource "aws_iam_role_policy_attachment" "read_postgres_secret" {
  role       = aws_iam_role.lambda_user_writer.name
  policy_arn = aws_iam_policy.read_postgres_secret.arn
}