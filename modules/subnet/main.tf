# Creating Public Subnets in VPC
resource "aws_subnet" "SUB-PUBLIC-DATACOSMO-01" {
  vpc_id                  = var.vpcid
  cidr_block              = var.cidr-block-public-01
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-2a"

  tags = {
    Name = var.name-subnet-public-01
    Owner = var.owner
    Tool = "Terraform"
    Environment = var.environment
  }
}

resource "aws_subnet" "SUB-PUBLIC-DATACOSMO-02" {
  vpc_id                  = var.vpcid
  cidr_block              = var.cidr-block-public-02
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-2b"

  tags = {
    Name = var.name-subnet-public-02
    Owner = var.owner
    Tool = "Terraform"
    Environment = var.environment
  }
}

# Creating PRIVATES Subnets in VPC
resource "aws_subnet" "SUB-PRIVATE-DATACOSMO-01" {
  vpc_id                  = var.vpcid
  cidr_block              = var.cidr-block-private-01
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-2a"

  tags = {
    Name = var.name-subnet-private-01
    Owner = var.owner
    Tool = "Terraform"
    Environment = var.environment
  }
}

resource "aws_subnet" "SUB-PRIVATE-DATACOSMO-02" {
  vpc_id                  = var.vpcid
  cidr_block              = var.cidr-block-private-02
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-2b"

  tags = {
    Name = var.name-subnet-private-02
    Owner = var.owner
    Tool = "Terraform"
    Environment = var.environment
  }
}

output "subnet_public_datacosmo_01" {
  value = aws_subnet.SUB-PUBLIC-DATACOSMO-01.id
}

output "subnet_public_datacosmo_02" {
  value = aws_subnet.SUB-PUBLIC-DATACOSMO-02.id
}

output "subnet_private_datacosmo_01" {
  value = aws_subnet.SUB-PRIVATE-DATACOSMO-01.id
}

output "subnet_private_datacosmo_02" {
  value = aws_subnet.SUB-PRIVATE-DATACOSMO-02.id
}