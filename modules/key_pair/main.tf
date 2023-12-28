# Provider block specifying the AWS region
provider "aws" {
  region = var.aws_region
  # Set the AWS region using the variable var.aws_region
}

# Resource block to create an AWS key pair
resource "aws_key_pair" "ec2-key" {
  key_name   = var.key_name
  public_key = var.public_key
  # Set the key name and public key using the variables var.key_name and var.public_key
}
