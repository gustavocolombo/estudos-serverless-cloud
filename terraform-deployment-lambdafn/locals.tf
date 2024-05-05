locals {
  lambdas_path = "${path.module}/lambdas"
  layers_path  = "${path.module}/layers"

  common_tags = {
    Project   = "Lambda layers with Terraform"
    ManagedBy = "Terraform"
    CreatedAt = "2024-05"
  }
}