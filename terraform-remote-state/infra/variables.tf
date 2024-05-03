variable "provider_region" {
  type        = string
  description = "Region to host resources"
  default     = "us-east-1"
}

variable "ec2_ami_id" {
  type        = string
  description = "ID of ami EC2"
  default     = "ami-04e5276ebb8451442"
}

variable "ec2_instance_type" {
  type        = string
  description = "Computational power of EC2"
  default     = "t2.micro"
}