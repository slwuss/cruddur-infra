resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.cruddur_alb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn  = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = var.frontend_target_group_arn
  }

}

resource "aws_lb_listener_rule" "api_backend" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = var.backend_target_group_arn
  }

  condition {
    host_header {
      values = ["api.project-cruddur.com"]
    }
  }

}