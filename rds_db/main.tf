resource "aws_db_instance" "default" {
  identifier             = var.db_name
  allocated_storage      = var.db_allocated_storage
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  name                   = var.db_name
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.${var.db_engine}${var.db_engine_version}"
  backup_retention_period = var.db_backup_retention_period
  skip_final_snapshot    = true

  tags = {
    Name = var.db_name
  }
}
