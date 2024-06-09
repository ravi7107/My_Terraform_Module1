data "aws_db_instances" "main" {
  filter {
    name   = "db-instance-id"
    values = ["my-database-id"]
  }
}