variable "vpc_cidr" {
    description = "CIDR Block of the VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "vpc_public" {
    description = "CIDR Block of the Public Subnet"
    type = string
    default = "10.0.0.0/24"
}

variable "az_public_subnet" {
    description = "AZ for the Public Subnet"
    type = string
    default = "us-east-1a"

    validation {
        condition = contains(["us-east-1a", "us-east-1b", "us-east-1c"], var.az_public_subnet)
        error_message = "AZ must be in us-east-1a, us-east-1b, us-east-1c"
    }
}

variable "instance_type" {
    description = "instance type for EC2"
    type = string
    default = "t3.micro"

    validation {
        condition = contains(["t2.micro", "t3.micro", "t3-small"], var.instance_type)
        error_message = "Instance type must be t3.micro, t3.small, t2.micro"
    }
}

variable "key_name" {
  type = string
}
