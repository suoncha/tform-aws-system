# AWS Architecture in VPC Creation with Terraform + Ansible
We are a team of 7, in need of a minimal but scalable system for future product development. This project will create a simple VCP with Internet Gateway, a public subnet which act as proxy servers.

From there Terraform will deploy a main EC2 instance (suoncha) and a secondary EC2 instance (dopo) in the public subnet, both can be connect to and from the internet. 

An SSH key pair is dynamically generated for each instance, but developers only has access to the secondary one, using it for development/testing/learning purpose. Only devops (me) has access to the main one.

Ansible is used for installing Docker & Nginx for both instance. The main instance will also host many tools for the team like Jenkins for CI/CD, Rancher for K8S Management, Prometheus & Grafana for Monitoring, ... which can be accessed via subdomains.

## Architecture diagram

![Diagram](img/system-diagram.png)

## Current state

Modules:

- ssh: Generates an ssh key pair, save the private one as a local .pem file.
- networking: Sets up a VPC.
- ec2: Sets up EC2 instances.

How to run:

- Linux: The scripts in ec2 should be working fine and there's no problem with it.
- Windows/WSL: Here come the pain. If you store this repo in Window directories (ex: /mnt/c:/...), the file permission of .pem files would be overridden by Window Security Rules as 'chmod' would take no effect on those files. To prevent that, you should store this repo in Linux directories (ex: /home, ...). Or you can comment those scripts in modules/ec2/main.tf if you don't want to run Ansible playbooks.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| region | AWS region - Default set to Singapore due to our team location  | `string` | `"ap-southeast-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| suoncha\_ip | IP of Main Server (Production) |
| dopo\_ip | IP of Secondary Server (Development) |
