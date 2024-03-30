#RDS resources
#This is a private subnet in vpc
resource "aws_db_subnet_group" "mariadb_subnet_group" {
  name       = "mariadb-subnet"
  subnet_ids = ["subnet-05345aa78192b71c8", "subnet-00afeb5b56e2b7567"]  # Replace these with your subnet IDs
}


#RDS parameters

resource "aws_db_parameter_group" "maria_db_parameters" {
  name   = "mariadb"
  family = "mariadb10.6"
  

}
   

#RDS instance properties
resource "aws_db_instance" "maria_db_instance" {
  allocated_storage    = 10
  db_name              = "mariadb"
  engine               = "mariadb"
  engine_version       = "10.6"
  instance_class       = "db.t3.micro"
  username             = "mariadb"
  password             = "mariadb123"
  parameter_group_name = "aws_subnet.mariadb_instance.mariadb10.6"
  skip_final_snapshot  = true
  availability_zone     = "us-east-2c,us-west-2b"

  tags = {
    Name="levelup_maria_db_instance"
  }
}