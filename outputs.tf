output "region" {
    description = "AWS region"
    value = var.region
}

output "bucket_name" {
    description = "S3 Bucket Name"
    value = var.bucket
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main
}

output "instance_ip" {
  description = "Public IP of instance"
  value       = aws_eip.web_ip.public_ip
}

output "instance_id" {
  value = aws_instance.web.id
}


