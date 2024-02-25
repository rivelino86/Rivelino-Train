
output "my_public_ip_address" {
   value = "My server address ${aws_instance.server.public_ip}:${var.port}"
}