terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}

provider "aws" {
  region = var.region
}


module "s3_bucket" {
  source = "./infra-modules/s3"
  bucket = var.bucket_name
}

module "ec2_instance" {
  source        = "./infra-modules/ec2"
  instance_type = "t3.micro"
  key_name      = "stack-key"
}