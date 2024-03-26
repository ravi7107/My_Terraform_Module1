resource "aws_security_group" "custom_vpc_security_group" {
    name = "custom_vpc_security_group"
    description = "custom_vpc_security_group"
    vpc_id = aws_vpc.leveup_vpc.id

ingress{
    description="custom_vpc_security_group"
    from_port= 80
    to_port= 80
    protocol= "tcp"
    cidr_block= [0.0.0.0\0]
}

ingress{
    description="allow_ssh_access"
    from_port= 22
    to_port= 22
    protocol= "tcp"
    cidr_block= [0.0.0.0/0]
}

ingress{
    description="allow_http_access"
    from_port= 443
    to_port= 443
    protocol= "tcp"
    cidr_block= [0.0.0.0/0]
}

tags = {
  Name= "custom_security_group"
}
}