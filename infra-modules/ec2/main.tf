
#AMI_IMAGE
data "aws_ami" "amazon_linux" {
    most_recent = true
    owners = ["137112412989"]

    filter {
        name = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}

# VPC
resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = "tf-vpc"
    }
}

# PUBLIC SUBNET
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.vpc_public
    availability_zone = var.az_public_subnet
    map_public_ip_on_launch = true

    tags = {
        Name = "tf-Public-Subnet"
    }
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "tf-igw"
    }
}

# ROUTE TABLE
resource "aws_route_table" "route_table" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "tf-Route-table"
    }
}

# ROUTE
resource "aws_route" "public_route" {
    route_table_id = aws_route_table.route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
}

# SUBNET ASSOCIATION
resource "aws_route_table_association" "public_assoc" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.route_table.id
}

# SECURITY GROUP 
resource "aws_security_group" "web" {
    name = "tf-SG"
    description = "ALLOW SSH & HTTP"
    vpc_id = aws_vpc.main.id

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "ALL OUTBOUND TRAFFIC"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "tf-SG"
    }
}

# EC2 INSTANCE 
resource "aws_instance" "web_server" {
    ami = data.aws_ami.amazon_linux.id
    instance_type = var.instance_type
    subnet_id = aws_subnet.public.id
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.web.id]

    tags = {
        Name = "tf_EC2"
    }
}

# ELASTIC IP
resource "aws_eip" "web_server_ip" {
    instance = aws_instance.web_server.id
    domain = "vpc"
}
