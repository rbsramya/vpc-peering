resource "aws_security_group" "ec2_sg" {
  name        = "Ramya-SG" 
  description = "Allow SSH and HTTP inbound"
  vpc_id      = var.vpc_id  

 #inbound rule :SSH
 ingress{
  description = "Allow SSH"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }
 #inbound rule :HTTP
 ingress{
  description = "Allow HTTP"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }
#Outbound rule: Allow all traffic
  egress{
  description = "Allow all outbound traffic"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 }
 tags = {
  Name =  "Ramya-SG"
 }
}

resource "aws_instance" "my_ec2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  #key_name                    = "ramya-ec2" 

  tags = {
    Name = "Ramya-ec2"
  }
}