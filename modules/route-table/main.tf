# Creating Route Tables for Internet gateway
resource "aws_route_table" "RT-PRIVATE-DATACOSMO" {
  vpc_id = var.vpcid
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.nat-gateway
  }

  tags = {
    Name = var.name-route-table-private
    Owner = var.owner
    Tool = "Terraform"
    Environment = var.environment
  }
}

# Creating Route Associations PRIVATE subnets
resource "aws_route_table_association" "RT-PRIVATE-DATACOSMO-1-a" {
  subnet_id      = var.subnet-private-datacosmo-01
  route_table_id = aws_route_table.RT-PRIVATE-DATACOSMO.id
}

# Creating Route Associations PRIVATE subnets
resource "aws_route_table_association" "RT-PRIVATE-DATACOSMO-2-b" {
  subnet_id      = var.subnet-private-datacosmo-02
  route_table_id = aws_route_table.RT-PRIVATE-DATACOSMO.id
}


################################################################33


# Creating Route Tables for Internet gateway
resource "aws_route_table" "RT-PUBLIC-DATACOSMO" {
  vpc_id = var.vpcid
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet-gateway
  }

  tags = {
    Name = var.name-route-table-public
    Owner = var.owner
    Tool = "Terraform"
    Environment = var.environment
  }
}

# Creating Route Associations public subnets
resource "aws_route_table_association" "RT-PUBLIC-DATACOSMO-1-a" {
  subnet_id      = var.subnet-public-datacosmo-01
  route_table_id = aws_route_table.RT-PUBLIC-DATACOSMO.id
}

resource "aws_route_table_association" "RT-PUBLIC-DATACOSMO-2-b" {
  subnet_id      = var.subnet-public-datacosmo-02
  route_table_id = aws_route_table.RT-PUBLIC-DATACOSMO.id
}