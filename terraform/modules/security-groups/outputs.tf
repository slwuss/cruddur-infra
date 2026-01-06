output "alb_sg_id" {
  value = aws_security_group.alb.id
}

output "ecs_be_service_sg_id" {
  value = aws_security_group.be.id
}

output "ecs_fe_service_sg_id" {
  value = aws_security_group.fe.id
}

output "lambda_ddb_sg_id" {
  value = aws_security_group.lambda_ddb.id
}

output "lambda_user_sg_id" {
  value = aws_security_group.lambda_user.id
}

output "rds_sg_id" {
  value = aws_security_group.rds.id
}