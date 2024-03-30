#RDS resources

data "aws_db_subnet_group" "database" {
  name = "my-test-database-subnet-group"
 # description ="Amzon RDS subnet group"
 # subnet_ids =[aws_subnet.private_subnet_1.id,aws_subnet.private_subnet_2.id]
}

#RDS parameters

resource "aws_db_parameter_group" "maria_db_parameters" {
  name   = "mariadb"
  family = "postgres13"

  parameter {
    name  = "log_connections"
    value = "1"
  }

  lifecycle {
    create_before_destroy = true
  }
}

#RDS instance properties

resource "aws_db_instance" "maria_db_instance" {
  allocated_storage    = 10
  db_name              = "mariadb"
  engine               = "mariadb"
  engine_version       = "10.6"
  instance_class       = "db.t2.micro"
  username             = "mariadb"
  password             = "mariadb123"
  parameter_group_name = "aws_subnet.mariadb_instance.mariadb10.6"
  skip_final_snapshot  = true

  tags = {
    Name="levelup_maria_db_instance"
  }
}