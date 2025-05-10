resource "aws_eip" "NAT-DATACOSMO"{
    vpc = true

  tags = {
    Name = var.name-nat
    Owner = var.owner
    Tool = "Terraform"
    Environment = var.environment
  }
}

resource "aws_nat_gateway" "NGW-DATACOSMO" {
  allocation_id = aws_eip.NAT-DATACOSMO.id
  subnet_id     = var.subnet-public

  tags = {
    Name = var.name-ngw
    Owner = var.owner
    Tool = "Terraform"
    Environment = var.environment
  }
}

output "nat_gateway_id" {
  value = aws_nat_gateway.NGW-DATACOSMO.id
}