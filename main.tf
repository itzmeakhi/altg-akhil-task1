# AWS provider configuration with the specified region
provider "aws" {
  region = var.aws_region
}

# Module block to create an EC2 instance using the specified module
module "ec2_instance" {
  source = "./modules/ec2"

  # Instance details
  ami_id        = var.ami_id
  instance_type = var.instance_type
  aws_region    = var.aws_region
  instance_name = var.instance_name

  # Security group details
  allowed_ip          = var.allowed_ip
  security_group_name = var.security_group_name

  # Key-pair details
  key_name   = var.key_name
  public_key = var.public_key
}
