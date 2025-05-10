terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

module "vpc" {
  source  = "./modules/vpc"

  cidr-block-vpc = var.cidr-block-vpc
  vpc-name     = var.name-vpc
  owner        = var.name-owner
  environment  = var.environment

}
module "subnet" {
  source  = "./modules/subnet"

  vpcid   = module.vpc.vpc_id

  cidr-block-public-01  = var.subnet-cidr-block-public-01
  cidr-block-public-02  = var.subnet-cidr-block-public-02
  cidr-block-private-01 = var.subnet-cidr-block-private-01
  cidr-block-private-02 = var.subnet-cidr-block-private-02

  name-subnet-public-01  = var.name-subnet-public-01
  name-subnet-public-02  = var.name-subnet-public-02
  name-subnet-private-01 = var.name-subnet-private-01
  name-subnet-private-02 = var.name-subnet-private-02

  owner       = var.name-owner
  environment = var.environment
  depends_on=[module.vpc]
}

module "internet-gateway" {
  source  = "./modules/internet-gateway"

  vpcid      = module.vpc.vpc_id
  name-igw   = var.name-internet-gateway
  owner      = var.name-owner
  environment = var.environment
  depends_on = [module.subnet]
}

module "nat-gateway" {
  source  = "./modules/nat-gateway"

  subnet-public  = module.subnet.subnet_public_datacosmo_01
  name-ngw       = var.name-ngw
  name-nat       = var.name-nat
  owner          = var.name-owner
  environment    = var.environment
  depends_on     = [module.subnet]

}

module "route-table" {
  source  = "./modules/route-table"

  vpcid                       = module.vpc.vpc_id

  subnet-public-datacosmo-01  = module.subnet.subnet_public_datacosmo_01
  subnet-public-datacosmo-02  = module.subnet.subnet_public_datacosmo_02
  subnet-private-datacosmo-01 = module.subnet.subnet_private_datacosmo_01
  subnet-private-datacosmo-02 = module.subnet.subnet_private_datacosmo_02

  nat-gateway                 = module.nat-gateway.nat_gateway_id
  internet-gateway            = module.internet-gateway.internet_gateway_id
  name-route-table-private    = var.name-route-table-private
  name-route-table-public     = var.name-route-table-public
  owner                       = var.name-owner
  environment                 = var.environment

  depends_on=[module.nat-gateway]
}

module "sg_public" {
  source      = "./modules/security_group"
  name        = "bastion-vpn"
  description = "Allow SSH, HTTP, HTTPS and 14998/UDP"
  vpc_id      = module.vpc.vpc_id
  depends_on=[module.vpc]
  tags = {
    Name        = "datacosmo-public-bastion"
    owner       = var.name-owner
    environment = var.environment
  }

  ingress_rules = [
    {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [var.my_ip]
    },
    {
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [var.my_ip]
    },
    {
      description = "HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [var.my_ip]
    },
    {
      description = "Custom UDP"
      from_port   = 12303
      to_port     = 12303
      protocol    = "udp"
      cidr_blocks = [var.my_ip]
    }
  ]
}

## AJUSTAR PARA RANGE IP PRIVADO

module "sg_private" {
  source      = "./modules/security_group"
  name        = "private"
  description = "Private SG "
  vpc_id      = module.vpc.vpc_id
  tags = {
    Name        = "datacosmo-private"
    owner       = var.name-owner
    environment = var.environment
  }

  ingress_rules = [
    {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [var.cidr-block-vpc]
    }
  ]
}

module "sg_private_db" {
  source      = "./modules/security_group"
  name        = "private_db"
  description = "Private SG db"
  vpc_id      = module.vpc.vpc_id
  tags = {
    Name        = "datacosmo-private-db"
    owner       = var.name-owner
    environment = var.environment
  }

  ingress_rules = [
    {
      description = "Mysql port connection"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = [var.cidr-block-vpc]
    }
  ]
}

####

module "ec2_key" {
  source    = "./modules/ec2_key_pair"

  key_name  = var.key_pair_name
  tags = {
    Name        = var.key_pair_name
    owner       = var.name-owner
    environment = var.environment
  }
}

module "ec2-bastion-public" {
  source              = "./modules/ec2_instance"

  ami_id              = var.ami_id
  instance_type       = var.instance_type_DATACOSMO
  subnet_id           = module.subnet.subnet_public_datacosmo_01
  security_group_ids  = [module.sg_public.security_group_id]
  key_name            = var.key_pair_name
  name                = "ec2-bastion-public"
  associate_public_ip = true
  depends_on=[module.vpc, module.subnet, module.internet-gateway, module.route-table, module.route-table]
  
  tags = {
    owner       = var.name-owner
    environment = var.environment
  }
}

module "ec2_key_private" {
  source    = "./modules/ec2_key_pair"

  key_name  = var.key_pair_private_name
  tags = {
    Name        = var.key_pair_private_name
    owner       = var.name-owner
    environment = var.environment
  }
}

## TODO: mudar as referencias para apontar na subnet privada

module "ec2-vpn-server-private" {
  source              = "./modules/ec2_instance"

  ami_id              = var.ami_id
  instance_type       = var.instance_type_DATACOSMO
  subnet_id           = module.subnet.subnet_private_datacosmo_01
  security_group_ids  = [module.sg_private.security_group_id]
  key_name            = var.key_pair_private_name
  name                = "ec2-vpn-server-private"
  associate_public_ip = false

  depends_on=[module.vpc, module.subnet, module.internet-gateway, module.route-table, module.route-table]
  
  tags = {
    owner       = var.name-owner
    environment = var.environment
  }
}

module "db_subnet_group" {
  source     = "./modules/db_subnet_group"
  name       = "rds-subnet-group"
  subnet_ids = [module.subnet.subnet_private_datacosmo_01, module.subnet.subnet_private_datacosmo_02]
  depends_on=[module.vpc, module.subnet, module.internet-gateway, module.route-table, module.route-table]
  tags = {
    Name = "RDS Subnet Group"
    owner       = var.name-owner
    environment = var.environment
  }
}

module "rds-manager-database" {
  source                 = "./modules/rds_instance"

  identifier             = var.db-identifier
  engine                 = var.db-engine
  engine_version         = var.db-version
  instance_class         = var.db-instance_class
  allocated_storage      = var.db-storage
  username               = var.db-db_username
  password               = var.db-db_password  # use secrets manager idealmente
  db_name                = var.db-db_name
  port                   = var.db-port
  publicly_accessible    = false
  vpc_security_group_ids = [module.sg_private_db.security_group_id]
  depends_on=[module.vpc, module.subnet, module.internet-gateway, module.route-table, module.route-table, module.db_subnet_group]
  db_subnet_group_name   = module.db_subnet_group.name
  tags = {
    owner       = var.name-owner
    environment = var.environment
  }
}