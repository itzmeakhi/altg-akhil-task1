/*Outputs the ID of the security group created */
output "security_group_id" {
  value = aws_security_group.allow_connections.id
}
