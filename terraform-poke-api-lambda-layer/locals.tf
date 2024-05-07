locals {
  lambdas_path = "${path.module}/lambdas"
  layers_path  = "${path.module}/layers"

  bucket_state_tags = {
    Owner     = "Gustavo Colombo da Rocha"
    ManagedBy = "Terraform"
    CreatedAt = "2024-05"
  }
}