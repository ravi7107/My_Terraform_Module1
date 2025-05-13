provider "aws" {
  region = "us-east-1" # Change to your preferred region
}

# Production VPC
resource "aws_vpc" "production_vpc" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Production-VPC"
  }
}

# Production Subnets
resource "aws_subnet" "prod_web" {
  vpc_id                  = aws_vpc.production_vpc.id
  cidr_block              = "10.1.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "web"
  }
}

resource "aws_subnet" "prod_app1" {
  vpc_id            = aws_vpc.production_vpc.id
  cidr_block        = "10.1.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "app1"
  }
}

resource "aws_subnet" "prod_app2" {
  vpc_id            = aws_vpc.production_vpc.id
  cidr_block        = "10.1.3.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "app2"
  }
}

resource "aws_subnet" "prod_dbcache" {
  vpc_id            = aws_vpc.production_vpc.id
  cidr_block        = "10.1.4.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "dbcache"
  }
}

resource "aws_subnet" "prod_db" {
  vpc_id            = aws_vpc.production_vpc.id
  cidr_block        = "10.1.5.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "db"
  }
}

# Production Internet Gateway
resource "aws_internet_gateway" "prod_igw" {
  vpc_id = aws_vpc.production_vpc.id

  tags = {
    Name = "Production-IGW"
  }
}

# Production NAT Gateway (for private subnets to access internet)
resource "aws_eip" "prod_nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "prod_nat" {
  allocation_id = aws_eip.prod_nat_eip.id
  subnet_id     = aws_subnet.prod_web.id

  tags = {
    Name = "Production-NAT"
  }
}

# Production Route Tables
resource "aws_route_table" "prod_public_rt" {
  vpc_id = aws_vpc.production_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_igw.id
  }

  tags = {
    Name = "Production-Public-RT"
  }
}

resource "aws_route_table" "prod_private_rt" {
  vpc_id = aws_vpc.production_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.prod_nat.id
  }

  tags = {
    Name = "Production-Private-RT"
  }
}

# Production Route Table Associations
resource "aws_route_table_association" "prod_web_rt_assoc" {
  subnet_id      = aws_subnet.prod_web.id
  route_table_id = aws_route_table.prod_public_rt.id
}

resource "aws_route_table_association" "prod_app1_rt_assoc" {
  subnet_id      = aws_subnet.prod_app1.id
  route_table_id = aws_route_table.prod_private_rt.id
}

resource "aws_route_table_association" "prod_app2_rt_assoc" {
  subnet_id      = aws_subnet.prod_app2.id
  route_table_id = aws_route_table.prod_private_rt.id
}

resource "aws_route_table_association" "prod_dbcache_rt_assoc" {
  subnet_id      = aws_subnet.prod_dbcache.id
  route_table_id = aws_route_table.prod_private_rt.id
}

resource "aws_route_table_association" "prod_db_rt_assoc" {
  subnet_id      = aws_subnet.prod_db.id
  route_table_id = aws_route_table.prod_private_rt.id
}

# Development VPC
resource "aws_vpc" "development_vpc" {
  cidr_block           = "10.2.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Development-VPC"
  }
}

# Development Subnets
resource "aws_subnet" "dev_web" {
  vpc_id                  = aws_vpc.development_vpc.id
  cidr_block              = "10.2.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "web"
  }
}

resource "aws_subnet" "dev_db" {
  vpc_id            = aws_vpc.development_vpc.id
  cidr_block        = "10.2.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "db"
  }
}

# Development Internet Gateway
resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.development_vpc.id

  tags = {
    Name = "Development-IGW"
  }
}

# Development Route Tables
resource "aws_route_table" "dev_public_rt" {
  vpc_id = aws_vpc.development_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_igw.id
  }

  tags = {
    Name = "Development-Public-RT"
  }
}

resource "aws_route_table" "dev_private_rt" {
  vpc_id = aws_vpc.development_vpc.id

  tags = {
    Name = "Development-Private-RT"
  }
}

# Development Route Table Associations
resource "aws_route_table_association" "dev_web_rt_assoc" {
  subnet_id      = aws_subnet.dev_web.id
  route_table_id = aws_route_table.dev_public_rt.id
}

resource "aws_route_table_association" "dev_db_rt_assoc" {
  subnet_id      = aws_subnet.dev_db.id
  route_table_id = aws_route_table.dev_private_rt.id
}

# Security Groups
resource "aws_security_group" "prod_web_sg" {
  name        = "prod-web-sg"
  description = "Allow HTTP/HTTPS and SSH to web tier"
  vpc_id      = aws_vpc.production_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "prod_app_sg" {
  name        = "prod-app-sg"
  description = "Allow traffic from web tier and SSH"
  vpc_id      = aws_vpc.production_vpc.id

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.prod_web_sg.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "prod_db_sg" {
  name        = "prod-db-sg"
  description = "Allow traffic from app tier and SSH"
  vpc_id      = aws_vpc.production_vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.prod_app_sg.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "dev_web_sg" {
  name        = "dev-web-sg"
  description = "Allow HTTP/HTTPS and SSH to dev web tier"
  vpc_id      = aws_vpc.development_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "dev_db_sg" {
  name        = "dev-db-sg"
  description = "Allow traffic from dev web tier and SSH"
  vpc_id      = aws_vpc.development_vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.dev_web_sg.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instances - Production
resource "aws_instance" "prod_web" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.prod_web.id
  security_groups = [aws_security_group.prod_web_sg.id]

  tags = {
    Name = "web-instance"
  }
}

resource "aws_instance" "prod_app1" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.prod_app1.id
  security_groups = [aws_security_group.prod_app_sg.id]

  tags = {
    Name = "app1-instance"
  }
}

resource "aws_instance" "prod_app2" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.prod_app2.id
  security_groups = [aws_security_group.prod_app_sg.id]

  tags = {
    Name = "app2-instance"
  }
}

resource "aws_instance" "prod_dbcache" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.prod_dbcache.id
  security_groups = [aws_security_group.prod_db_sg.id]

  tags = {
    Name = "dbcache-instance"
  }
}

resource "aws_instance" "prod_db" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.prod_db.id
  security_groups = [aws_security_group.prod_db_sg.id]

  tags = {
    Name = "db-instance"
  }
}

# EC2 Instances - Development
resource "aws_instance" "dev_web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.dev_web.id
  security_groups = [aws_security_group.dev_web_sg.id]

  tags = {
    Name = "dev-web-instance"
  }
}

resource "aws_instance" "dev_db" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.dev_db.id
  security_groups = [aws_security_group.dev_db_sg.id]

  tags = {
    Name = "dev-db-instance"
  }
}

# VPC Peering Connection
resource "aws_vpc_peering_connection" "prod_dev_peering" {
  peer_vpc_id = aws_vpc.development_vpc.id
  vpc_id      = aws_vpc.production_vpc.id
  auto_accept = true

  tags = {
    Name = "Production-Development-Peering"
  }
}

# Route for Production VPC to reach Development VPC
resource "aws_route" "prod_to_dev_route" {
  route_table_id            = aws_route_table.prod_private_rt.id
  destination_cidr_block    = aws_vpc.development_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.prod_dev_peering.id
}

# Route for Development VPC to reach Production VPC
resource "aws_route" "dev_to_prod_route" {
  route_table_id            = aws_route_table.dev_private_rt.id
  destination_cidr_block    = aws_vpc.production_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.prod_dev_peering.id
}

# Additional route for Production public RT to allow peering traffic
resource "aws_route" "prod_public_to_dev_route" {
  route_table_id            = aws_route_table.prod_public_rt.id
  destination_cidr_block    = aws_vpc.development_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.prod_dev_peering.id
}

# Security Group Rules for DB communication between VPCs
resource "aws_security_group_rule" "prod_db_allow_dev_db" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  security_group_id = aws_security_group.prod_db_sg.id
  cidr_blocks       = [aws_vpc.development_vpc.cidr_block]
}

resource "aws_security_group_rule" "dev_db_allow_prod_db" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  security_group_id = aws_security_group.dev_db_sg.id
  cidr_blocks       = [aws_vpc.production_vpc.cidr_block]
}