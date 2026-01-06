resource "aws_security_group" "alb" {
  name        = "cruddur-alb-prod-sg"
  description = "Public ALB: allow HTTP/HTTPS from internet and forward to frontend ECS"
  vpc_id      = var.vpc_id 
}

resource "aws_security_group_rule" "alb_http" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb.id 
}

resource "aws_security_group_rule" "alb_https" {
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb.id
}
