output "suoncha_ip" {
  value = aws_eip.suoncha_ip.public_ip
}

output "dopo_ip" {
  value = aws_eip.dopo_ip.public_ip
}