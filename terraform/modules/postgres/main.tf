resource "aws_db_instance" "this" {
  identifier = var.identifier

  engine         = "postgres"
  engine_version = var.engine_version

  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type

  db_name = var.db_name
  port    = 5432

  publicly_accessible    = var.publicly_accessible
  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name   = var.db_subnet_group_name

  storage_encrypted = true

  auto_minor_version_upgrade = true
  maintenance_window         = var.maintenance_window
  backup_retention_period    = var.backup_retention_period
  skip_final_snapshot        = true
  deletion_protection        = false

  performance_insights_enabled          = true
  performance_insights_retention_period = 7

  parameter_group_name = var.parameter_group_name
  option_group_name    = var.option_group_name

  # AWS manages password
  username                    = var.username
  manage_master_user_password = true
}