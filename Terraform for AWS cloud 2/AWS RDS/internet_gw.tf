#create internet gateway changes
resource "aws_internet_gateway" "levelup_igw" {
    vpc_id = aws_vpc.main.id

}