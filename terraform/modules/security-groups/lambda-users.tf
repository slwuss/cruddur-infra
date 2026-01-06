resource "aws_security_group" "lambda_user" {
  name        = "cruddur-lambda-user-writer-prod-sg"
  description = "Lambda (Cognito): write user data to RDS"
  vpc_id      = var.vpc_id

  egress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.rds.id]
  }
}