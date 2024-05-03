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

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "bucket_state" {
  bucket = "tfstate-${data.aws_caller_identity.current.id}"

  versioning {
    enabled = true
  }

  tags = {
    Description = "Remote State Store"
    ManagedBy   = "Terraform"
    CreatedAt   = "2024-05-03"
  }
}
output "remote_state_bucket" {
  value = aws_s3_bucket.bucket_state.bucket
}

output "remote_state_bucket_arn" {
  value = aws_s3_bucket.bucket_state.arn
}