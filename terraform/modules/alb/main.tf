resource "aws_lb" "cruddur_alb" {
  name               = var.name
  load_balancer_type = "application"
  internal           = false
  ip_address_type    = "ipv4"

  subnets        = var.subnets
  security_groups = var.security_groups

  desync_mitigation_mode = "defensive"

  access_logs {
    enabled = var.access_logs.enabled
    bucket  = var.access_logs.bucket
    prefix  = var.access_logs.prefix
  }
}