# data "aws_ami" "amz-linux-arm" {
#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name   = "architecture"
#     values = ["arm64"]
#   }
# }

resource "aws_ebs_volume" "gp3_1" {
  availability_zone = "ap-southeast-1a"
  size              = 50
  type              = "gp3"
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.gp3_1.id
  instance_id = aws_instance.suoncha_server.id
}

resource "aws_instance" "suoncha_server" {
  ami                         = "ami-011cb4979f9a188f2"
  associate_public_ip_address = true
  instance_type               = "m6g.large"
  key_name                    = var.suoncha_pub
  subnet_id                   = var.vpc.public_subnets[0]
  vpc_security_group_ids      = [var.sg_proxy]

  tags = {
    "Name" = "suoncha-server"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = "suoncha-key.pem"
    host        = self.public_ip
    timeout     = "4m"
  }

  lifecycle {
    create_before_destroy = true
  }

  # Comment this if run on Windows
  provisioner "local-exec" {
    command = "ansible-playbook -u ec2-user --key-file ../ssh/suoncha-key.pem -T 30 -i '${self.public_ip},', playbooks/all.yml"
  }
}

resource "aws_instance" "dopo_server" {
  ami                         = "ami-011cb4979f9a188f2"
  associate_public_ip_address = true
  instance_type               = "m6g.medium"
  key_name                    = var.dopo_pub
  subnet_id                   = var.vpc.public_subnets[0]
  vpc_security_group_ids      = [var.sg_proxy]

  tags = {
    "Name" = "dopo-server"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = "dopo-key.pem"
    host        = self.public_ip
    timeout     = "4m"
  }

  lifecycle {
    create_before_destroy = true
  }

  # Comment this if run on Windows
  provisioner "local-exec" {
    command = "ansible-playbook -u ec2-user --key-file ../ssh/dopo-key.pem -T 30 -i '${self.public_ip},', playbooks/all.yml"
  }
}