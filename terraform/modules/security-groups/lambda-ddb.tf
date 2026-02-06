resource "aws_security_group" "lambda_ddb" {
  name        = "cruddur-lambda-ddb-prod-sg"
  description = "Lambda: access DynamoDB via HTTPS (IAM-based)"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}