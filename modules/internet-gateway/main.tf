resource "aws_internet_gateway" "IGW-DATACOSMO" {
  vpc_id = var.vpcid

  tags = {
    Name = var.name-igw
    Owner = var.owner
    Tool = "Terraform"
    Environment = var.environment
  }
}

output "internet_gateway_id" {
  description = "ID do Internet Gateway criado"
  value       = aws_internet_gateway.IGW-DATACOSMO.id
}