output "arn" {
  value = aws_lb.cruddur_alb.arn
}

output "dns_name" {
  value = aws_lb.cruddur_alb.dns_name
}

output "zone_id" {
  value = aws_lb.cruddur_alb.zone_id
}