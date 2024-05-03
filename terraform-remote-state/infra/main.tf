terraform {
  required_version = "1.8.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.47.0"
    }
  }

  backend "s3" {
    bucket = "tfstate-504644493227"
    key    = "dev/remote_state/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.provider_region
}