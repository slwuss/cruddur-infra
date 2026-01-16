# --------------------
# ALB
# --------------------
resource "aws_lb" "this" {
  name = "dummy"
}

# --------------------
# Listeners 
# --------------------
resource "aws_lb_listener" "listener_1" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"
}

resource "aws_lb_listener" "listener_2" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"
}

# --------------------
# Listener Rules 
# --------------------
resource "aws_lb_listener_rule" "rule_1" {
  listener_arn = aws_lb_listener.listener_1.arn
  priority     = 10
}

resource "aws_lb_listener_rule" "rule_2" {
  listener_arn = aws_lb_listener.listener_2.arn
  priority     = 20
}

resource "aws_lb_listener_rule" "rule_3" {
  listener_arn = aws_lb_listener.listener_2.arn
  priority     = 30
}