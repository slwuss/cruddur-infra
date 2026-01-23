resource "aws_ecs_cluster" "cruddur_cluster" {
  name = var.name

  setting {
    name  = "containerInsights"
    value = var.enable_container_insights ? "enabled" : "disabled"
  }

  dynamic "service_connect_defaults" {
    for_each = var.service_connect_namespace_arn == null ? [] : [1]

    content {
      namespace = var.service_connect_namespace_arn
    }
  }
}