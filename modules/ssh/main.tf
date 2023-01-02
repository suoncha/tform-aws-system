resource "tls_private_key" "suoncha_prikey" {
  algorithm = "RSA"
}

resource "local_sensitive_file" "suoncha_keyfile" {
  filename        = "${path.module}/suoncha-key.pem"
  content         = tls_private_key.suoncha_prikey.private_key_pem
  file_permission = "0400"
}

resource "aws_key_pair" "suoncha_pubkey" {
  key_name   = "suoncha-key"
  public_key = tls_private_key.suoncha_prikey.public_key_openssh
}

resource "tls_private_key" "dopo_prikey" {
  algorithm = "RSA"
}

resource "local_sensitive_file" "dopo_keyfile" {
  filename        = "${path.module}/dopo-key.pem"
  content         = tls_private_key.dopo_prikey.private_key_pem
  file_permission = "0400"
}

resource "aws_key_pair" "dopo_pubkey" {
  key_name   = "dopo-key"
  public_key = tls_private_key.dopo_prikey.public_key_openssh
}