output "vpc" {
  value = module.vpc
}

output "sg_proxy" {
  value = aws_security_group.proxy_group.id
}

output "sg_rke" {
  value = aws_security_group.rke_group.id
}