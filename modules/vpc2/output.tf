output "vpc_id" {
  value = aws_vpc.main.id
}


output "subnet_id" {
  description = "ID of the first public subnet"
  value       = aws_subnet.public1.id
}