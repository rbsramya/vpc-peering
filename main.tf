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