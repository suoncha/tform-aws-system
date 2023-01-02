output "suoncha_ip" {
  value = aws_instance.suoncha_server.public_ip
}

output "dopo_ip" {
  value = aws_instance.dopo_server.public_ip
}