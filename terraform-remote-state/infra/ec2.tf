resource "aws_instance" "ec2_remote_state" {
  ami           = var.ec2_ami_id
  instance_type = var.ec2_instance_type

  tags = {
    Description = "Example of EC2 shared among the theam"
    ManagedBy   = "Terraform"
    CreatedAt   = "2024-05-03"
  }
}