variable "ami_id" {
  description = "AMI ID for the EC2 instance"
}

variable "instance_type" {
  description = "EC2 instance type"
}

variable "key_name" {
  description = "Key pair name for EC2 instance"
}

variable "aws_region" {
  description = "AWS region"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
}

variable "allowed_ip" {
  description = "Allowed IP for SSH"
}

variable "security_group_name" {
  description = "Name of the security group"
}

variable "public_key" {
  description = "public key generated"
}