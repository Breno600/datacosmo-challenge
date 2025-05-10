resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = var.public_key != "" ? var.public_key : tls_private_key.this.public_key_openssh

  tags = var.tags
}

resource "local_file" "private_key" {
  content              = tls_private_key.this.private_key_pem
  filename             = "${var.key_name}.pem"
  file_permission      = "0600"
  directory_permission = "0700"
  lifecycle {
    prevent_destroy = false
  }

  count = var.public_key != "" ? 0 : 1
}