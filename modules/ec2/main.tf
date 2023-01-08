# data "aws_ami" "amz-linux-arm" {
#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name   = "architecture"
#     values = ["arm64"]
#   }
# }

resource "aws_eip" "suoncha_ip" {
  instance = aws_instance.suoncha_server.id
  vpc      = true
}

resource "aws_instance" "suoncha_server" {
  ami                         = "ami-011cb4979f9a188f2"
  instance_type               = "m6g.large"
  key_name                    = var.suoncha_pub
  subnet_id                   = var.vpc.public_subnets[0]
  vpc_security_group_ids      = [var.sg_proxy, var.sg_rke]

  tags = {
    "Name" = "suoncha-server"
  }

  root_block_device {
    volume_size           = 50
    volume_type           = "gp3"
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eip" "dopo_ip" {
  instance = aws_instance.dopo_server.id
  vpc      = true
}

resource "aws_volume_attachment" "dopo_jenkins" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.jenkins_data.id
  instance_id = aws_instance.dopo_server.id
}

resource "aws_ebs_volume" "jenkins_data" {
  availability_zone = "ap-southeast-1a"
  size              = 200
  type              = "sc1"
}

resource "aws_instance" "dopo_server" {
  ami                         = "ami-011cb4979f9a188f2"
  instance_type               = "m6g.medium"
  key_name                    = var.dopo_pub
  subnet_id                   = var.vpc.public_subnets[0]
  vpc_security_group_ids      = [var.sg_proxy, var.sg_rke]

  tags = {
    "Name" = "dopo-server"
  }

  lifecycle {
    create_before_destroy = true
  }
}