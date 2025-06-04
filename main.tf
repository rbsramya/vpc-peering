module "vpc1" {
  source      = "./modules/vpc1"
  cidr_block  = "10.1.0.0/16"
  subnet1_cidr = "10.1.101.0/24"
  subnet2_cidr = "10.1.102.0/24"
  subnet3_cidr = "10.1.103.0/24"
   
  }

module "vpc2" {
  source      = "./modules/vpc2"
  cidr_block  = "10.2.0.0/16"
  subnet1_cidr = "10.2.101.0/24"
  subnet2_cidr = "10.2.102.0/24"
  subnet3_cidr = "10.2.103.0/24"
   
  }

module "vpc1-Ec2" {
  source        = "./modules/Ec2"
  ami           = "ami-04c913012f8977029" 
  #Name          = "Ramya-Ec2"
  instance_type = "t2.micro"
  subnet_id     = module.vpc1.subnet_id
  vpc_id = module.vpc1.vpc_id 
}

module "vpc2-Ec2" {
  source        = "./modules/Ec2"
  ami           = "ami-04c913012f8977029" 
  #Name          = "Ramya-Ec2"
  instance_type = "t2.micro"
  subnet_id     = module.vpc2.subnet_id
  vpc_id = module.vpc2.vpc_id 
}

resource "aws_vpc_peering_connection" "vpc_peering" {
  vpc_id        = module.vpc1.vpc_id     # Requester
  peer_vpc_id   = module.vpc2.vpc_id     # Accepter
  auto_accept   = true                   # Set to false if peer is in another account

  tags = {
    Name = "Ramya vpc1-Ramya vpc2-peering"
  }
}

resource "aws_route" "vpc1_to_vpc2" {
  route_table_id            = module.vpc1.public_route_table_id
  destination_cidr_block    = module.vpc2.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}

resource "aws_route" "vpc2_to_vpc1" {
  route_table_id            = module.vpc2.public_route_table_id
  destination_cidr_block    = module.vpc1.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}


