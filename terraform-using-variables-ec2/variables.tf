variable "region" {
  type        = string
  description = "Region where EC2 are hosted"
  default     = "us-east-1"
}

variable "instace_ami_id" {
  type        = string
  description = "ID of ami instance type of EC2"
  default     = "ami-04e5276ebb8451442"
}

variable "instace_type" {
  type        = string
  description = "Computational power of EC2"
  default     = "t2.micro"
}

variable "tags" {
  type        = map(string)
  description = "Tags of EC2"
  default = {
    Name      = "ec2_using_terraform_variables",
    Stage     = "DEV",
    ManagedBy = "Terraform"
  }
}