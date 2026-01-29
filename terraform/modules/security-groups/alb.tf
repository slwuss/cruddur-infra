resource "aws_security_group" "alb" {
  name        = "cruddur-alb-prod-sg"
  description = "Public ALB: allow HTTP/HTTPS from internet and forward to frontend ECS"
  vpc_id      = var.vpc_id 
}

resource "aws_security_group_rule" "alb_http" {
  type = "ingress"
  description = "Allow HTTP from internet"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb.id 
}

resource "aws_security_group_rule" "alb_https" {
  type = "ingress"
  description = "Allow HTTPS from internet"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "alb_egress" {
  type              = "egress"
  description       = "Allow alb outbound traffic"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.alb.id
  cidr_blocks       = ["0.0.0.0/0"]
}
