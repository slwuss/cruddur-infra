resource "aws_security_group" "fe" {
  name        = "cruddur-ecs-fe-prod-sg"
  description = "ECS Frontend: allow traffic from ALB and forward to backend ECS"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "fe_from_alb" {
  type                     = "ingress"
  description              = "Allow ALB to access ECS Frontend"
  from_port                = 3000
  to_port                  = 3000
  protocol                 = "tcp"
  security_group_id        = aws_security_group.fe.id
  source_security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "fe_egress" {
  type              = "egress"
  description       = "Allow ECS Frontend outbound traffic"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.fe.id
  cidr_blocks       = ["0.0.0.0/0"]
}