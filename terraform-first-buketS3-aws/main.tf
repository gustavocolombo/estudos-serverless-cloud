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
  region = "us-east-1"
}

resource "aws_s3_bucket" "first-bucketS3-terraform" {
  bucket = "only-first-bucket-by-terraform2024"
  acl    = "private"

  tags = {
    Name        = "First bucket S3 using Terraform"
    Environment = "Dev"
    ManagedBy   = "Terraform"
  }
}