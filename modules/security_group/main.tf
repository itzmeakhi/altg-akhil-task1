# AWS provider configuration
provider "aws" {
  region = var.aws_region
}

# Data block to fetch details of the user-supplied AMI ID, if provided
data "aws_ami" "user_ami" {
  count = var.ami_id != "" ? 1 : 0

  filter {
    name   = "image-id"
    values = [var.ami_id]
  }
}

# Local variable to determine the connection type (SSH or RDP) based on the OS platform
locals {
  connection_type = var.ami_id != "" && try(data.aws_ami.user_ami[0].platform, "") == "windows" ? "RDP" : "SSH"
}

# Resource block to create the security group
resource "aws_security_group" "allow_connections" {
  name        = var.security_group_name
  description = "Allow ${local.connection_type} connections"

  # Ingress rule for SSH or RDP based on the connection type
  dynamic "ingress" {
    for_each = can(data.aws_ami.user_ami) && length(data.aws_ami.user_ami) > 0 ? [1] : [0]  # Use [0] for SSH if var.ami_id is empty

    content {
      from_port   = local.connection_type == "RDP" ? 3389 : 22
      to_port     = local.connection_type == "RDP" ? 3389 : 22
      protocol    = "tcp"
      cidr_blocks = var.allowed_ip
    }
  }

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

  # Enforce create-before-destroy lifecycle to avoid issues during updates
  lifecycle {
    create_before_destroy = true
  }
}
