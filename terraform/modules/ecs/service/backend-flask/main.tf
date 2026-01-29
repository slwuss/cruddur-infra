resource "aws_ecs_service" "this" {
  name            = var.name
  cluster         = var.cluster_arn
  task_definition = var.task_definition
  desired_count   = var.desired_count

  launch_type = "FARGATE"

  enable_execute_command = var.enable_execute_command
  propagate_tags         = "SERVICE"

  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  dynamic "deployment_circuit_breaker" {
    for_each = var.enable_deployment_circuit_breaker ? [1] : []
    content {
      enable   = true
      rollback = true
    }
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  network_configuration {
    assign_public_ip = var.assign_public_ip
    subnets          = var.subnet_ids
    security_groups  = var.security_group_ids
  }


}



# resource "aws_ecs_service" "this" {
#   name            = var.name
#   cluster         = var.cluster_id
#   task_definition = var.task_definition_arn
#   desired_count   = var.desired_count
#   launch_type     = "FARGATE"

#   network_configuration {
#     subnets         = var.subnets
#     security_groups = var.security_groups
#   }

#   service_registries {
#     registry_arn = var.discovery_service_arn
#   }

#   load_balancer {
#     target_group_arn = var.target_group_arn
#     container_name   = var.container_name
#     container_port   = var.container_port
#   }
# }