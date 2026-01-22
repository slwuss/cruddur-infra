resource "aws_ecs_cluster" "cruddur-cluster" {
  name = var.cluster_name
}