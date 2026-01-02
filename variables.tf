variable "region" {
    description = "AWS-region"
    type = string
    default = "us-east-1"
}

# S3 variables

variable "bucket" {
    description = "bucket-name"
}

# EC2 variables

variable "vpc_cidr" {
    description = "CIDR block for VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "vpc_public" {
    description = "Public Subnet for VPC"
    type = string
    default = "10.0.0.0/24"
}

variable "az_public_subnet" {
    description = "AZ for Public Subnet"
    type = string
    default = "us-east-1a"

    validation {
        condition =  contains(["us-east-1a", "us-east-1b", "us-east-1c"], var.az_public_subnet)
        error_message = "AZ must be in us-east-1a, us-east-1b, us-east=1c"
    }
}

variable "instance_type" {
    description = "Instance type for EC2"
    type = string
    default = "t3.micro"

    validation = contains(["t3.micro", "t2.micro", "t3.small"], var.instance_type)
    error_message = "Instance type must be t3.micro, t3.small, t2.micro"
}

