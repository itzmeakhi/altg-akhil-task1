# Output block to display the public IP of the EC2 instance for SSH/RDP connection
output "ec2_instance_public_ip" {
  value = aws_instance.ec2_instance.public_ip
}
