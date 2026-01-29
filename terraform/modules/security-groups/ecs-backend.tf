resource "aws_security_group" "be" {
  name        = "cruddur-ecs-be-prod-sg"
  description = "ECS Backend: accept from frontend ECS and access RDS and AWS services"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "be_from_alb" {
  type                     = "ingress"
  description              = "Allow ALB to access ECS Backend"
  from_port                = 4567
  to_port                  = 4567
  protocol                 = "tcp"
  security_group_id        = aws_security_group.be.id
  source_security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "be_egress" {
  type              = "egress"
  description       = "Allow ECS Backend outbound traffic"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.be.id
  cidr_blocks       = ["0.0.0.0/0"]
}

