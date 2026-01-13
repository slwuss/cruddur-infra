# resource "aws_security_group" "lambda_user" {
#   name        = "cruddur-lambda-user-writer-prod-sg"
#   description = "Lambda (Cognito): write user data to RDS"
#   vpc_id      = var.vpc_id

#   egress {
#     from_port       = 5432
#     to_port         = 5432
#     protocol        = "tcp"
#     security_groups = [aws_security_group.rds.id]
#   }

#     egress {
#     from_port       = 443
#     to_port         = 443
#     protocol        = "tcp"
#     security_groups = [aws_security_group.secrets_endpoint_sg.id]
#   }
# }


resource "aws_security_group" "lambda_user" {
  name        = "cruddur-lambda-user-writer-prod-sg"
  description = "Lambda (Cognito): write user data to RDS" # ← ใช้ค่าเดิม
  vpc_id      = var.vpc_id

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [
      ingress,
      egress,
      description
    ]
  }
}

resource "aws_security_group_rule" "lambda_to_rds" {
  type                     = "egress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.lambda_user.id
  source_security_group_id = aws_security_group.rds.id
}

resource "aws_security_group_rule" "lambda_to_secrets" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.lambda_user.id
  source_security_group_id = aws_security_group.secrets_endpoint_sg.id
}