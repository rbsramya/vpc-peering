variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the EC2 instance and its security group will be deployed"
}

variable "ami" {
  type        = string
  description = "AMI ID"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID to launch EC2"
}