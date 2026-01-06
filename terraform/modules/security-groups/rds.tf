resource "aws_security_group" "rds" {
  name        = "cruddur-rds-postgres-prod-sg"
  description = "PostgreSQL RDS: allow access from backend ECS and Cognito Lambda"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "rds_from_be" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds.id
  source_security_group_id = aws_security_group.be.id
}