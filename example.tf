terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.23.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
  access_key = ""
  secret_key = ""
}

resource "aws_vpc" "First_VPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "VPC from Terraform"
  }
}

resource "aws_subnet" "Subnet_1" {
  vpc_id     = aws_vpc.First_VPC.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Subnet_1_Terraform"
  }
}

resource "aws_s3_bucket" "test" {
  bucket = "terraformbucket109anish"
  acl    = "private"

  tags = {
    Name        = "terraform_bucket_anish"
    Environment = "Dev"
  }
}

resource "aws_instance" "example_ec2" {
  ami           = "ami"
  instance_type = "t2.micro"

  tags = {
    Name        = "terraform_ec2"
  }
}