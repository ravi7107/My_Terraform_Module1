#Configure basic RDS instance
resource "aws_db_instance" "default" {
  allocated_storage = 10
  storage_type = "gp2"
  engine = "mysql"
  engine_version = "5.7"
  instance_class = "db.t2.micro"
  identifier = "mydb"
  username = "dbuser"
  password = "dbpassword"

  vpc_security_group_ids = [aws_security_group.allow_mariadb.id]
  db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.name

  skip_final_snapshot = true
}

#Provision RDS instance in a VPC network
resource "aws_db_subnet_group" "my_db_subnet_group" {
  name = "my-db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]

  tags = {
    Name = "My DB Subnet Group"
  }
}