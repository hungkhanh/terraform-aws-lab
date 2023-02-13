terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "vpc_linux" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "Linux"
  }
}

resource "aws_subnet" "subnet_linux" {
  vpc_id     = aws_vpc.vpc_linux.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Linux subnet"
  }
}

resource "aws_internet_gateway" "gw_linux" {
  vpc_id = aws_vpc.vpc_linux.id

  tags = {
    Name = "Linux gateway"
  }
}