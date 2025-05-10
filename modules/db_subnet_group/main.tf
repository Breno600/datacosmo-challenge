resource "aws_db_subnet_group" "this" {
  name       = var.name
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

output "name" {
  value = aws_db_subnet_group.this.name
}