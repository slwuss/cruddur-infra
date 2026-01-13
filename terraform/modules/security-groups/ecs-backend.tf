resource "aws_security_group" "be" {
  name        = "cruddur-ecs-be-prod-sg"
  description = "ECS Backend: accept from frontend ECS and access RDS and AWS services"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "be_from_fe" {
  type                     = "ingress"
  description              = "Allow ECS Frontend to access ECS Backend"
  from_port                = 4567
  to_port                  = 4567
  protocol                 = "tcp"
  security_group_id        = aws_security_group.be.id
  source_security_group_id = aws_security_group.fe.id
}