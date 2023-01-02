terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "networking" {
  source = "./modules/networking"
}

module "ssh" {
  source = "./modules/ssh"
}

module "ec2" {
  source = "./modules/ec2"
  vpc = module.networking.vpc
  suoncha_pub = module.ssh.suoncha_pub
  dopo_pub = module.ssh.dopo_pub
  sg_proxy = module.networking.sg_proxy
}