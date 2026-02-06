resource "aws_lb_target_group" "this" {
  name        = var.name
  port        = var.port
  protocol    = var.protocol
  target_type = var.target_type
  vpc_id      = var.vpc_id

  health_check {
    interval            = 30
    path                = var.health_check_path
    matcher             = "200"
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 5
  }

}

