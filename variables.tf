variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance? Note: Press Enter if you want to use the latest amznlinux AMI"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name for EC2 instance"
}

variable "allowed_ip" {
  description = "Allowed IP for SSH"
}

variable "security_group_name" {
  description = "Name of the security group"
  default     = "allow_ssh_sg"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  default     = "MyEC2Instance"
}

variable "public_key" {
  description = "public key generated"
}