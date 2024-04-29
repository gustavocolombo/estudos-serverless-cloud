terraform {
  required_version = "1.8.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.47.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "ec2_instance_terraform" {
  ami           = var.instace_ami_id
  instance_type = var.instace_type

  tags = var.tags
}