# resource "aws_security_group" "secrets_endpoint_sg" {
#   name        = "cruddur-secrets-endpoint-sg"
#   description = "Allow Lambda to access Secrets Manager"
#   vpc_id      = var.vpc_id

#   ingress {
#     description     = "Allow Lambda to access Secrets Manager"
#     from_port       = 443
#     to_port         = 443
#     protocol        = "tcp"
#     security_groups = [aws_security_group.lambda_user.id]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

resource "aws_security_group" "secrets_endpoint_sg" {
  name        = "cruddur-secrets-endpoint-sg"
  description = "Allow Lambda to access Secrets Manager"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "secrets_ingress_lambda" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.secrets_endpoint_sg.id
  source_security_group_id = aws_security_group.lambda_user.id
}

resource "aws_security_group_rule" "secrets_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.secrets_endpoint_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}