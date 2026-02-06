resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.cruddur_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type  = "redirect"
    order = 1

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_302"
      host        = "#{host}"
      path        = "/#{path}"
      query       = "#{query}"
    }
  }

}