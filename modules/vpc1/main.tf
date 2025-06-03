resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_support =  true
  enable_dns_hostnames = true

  tags = {
    Name = "Ramya-VPC1"
  }
}

resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet1_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "Ramya-public-subnet1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet2_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "Ramya-public-subnet2"
  }
}

resource "aws_subnet" "public3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet3_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "Ramya-public-subnet3"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Ramya-igw"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "Ramya-public-rt1"
  }
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id 
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id 
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "public3" {
  subnet_id      = aws_subnet.public3.id 
  route_table_id = aws_route_table.rt.id
}