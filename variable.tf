# AWS REGION
variable "region" {
  type    = string
  default = "us-east-1"
}

# S3 

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "force_destroy" {
  type    = bool
  default = true
}

# EC2 

