output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main
}

output "instance_ip" {
  description = "Public IP of instance"
  value       = aws_eip.web_server_ip.public_ip
}

output "instance_id" {
  value = aws_instance.web_server.id
}
