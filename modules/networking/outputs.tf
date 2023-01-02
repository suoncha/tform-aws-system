output "vpc" {
  value = module.vpc
}

output "sg_proxy" {
  value = aws_security_group.proxy_group.id
}