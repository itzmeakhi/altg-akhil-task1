# Provider block specifying the AWS region
provider "aws" {
  region = var.aws_region
  # Set the AWS region using the variable var.aws_region
}

# Data block to fetch the most recent Amazon Linux AMI
data "aws_ami" "amznlinux" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-x86_64-gp2"]
  }
  # Retrieve the most recent Amazon Linux AMI owned by Amazon
}

# Module block to create a security group
module "security_group" {
  source               = "../security_group"
  allowed_ip          = var.allowed_ip
  security_group_name = var.security_group_name
  aws_region          = var.aws_region
  ami_id              = var.ami_id
  # Use the security_group module with specified inputs
}

# Module block to create a key pair
module "key_pair" {
  source      = "../key_pair"
  key_name    = var.key_name
  public_key  = var.public_key
  aws_region  = var.aws_region
  # Use the key_pair module with specified inputs
}

# Resource block to create an AWS EC2 instance
resource "aws_instance" "ec2_instance" {
  ami                      = var.ami_id != "" ? var.ami_id : data.aws_ami.amznlinux.id
  # Use the specified AMI ID or fallback to the most recent Amazon Linux AMI if not specified
  instance_type            = var.instance_type
  key_name                 = module.key_pair.key_name
  vpc_security_group_ids   = [module.security_group.security_group_id]
  tags = {
    Name = var.instance_name
  }
  # Configure the EC2 instance with the specified settings
}
