variable "region" {
  description = "AWS region where the resources will be deployed."
  type        = string
  default     = "us-east-2"
}

variable "cidr-block-vpc" {
  description = "CIDR block to define the address range of the VPC."
  type        = string
  default     = "10.232.44.0/22"
}

variable "name-vpc" {
  description = "Name to assign to the VPC resource."
  type        = string
  default     = "VPC-DATACOSMO"
}

variable "name-owner" {
  description = "Name of the owner or responsible person/team for the infrastructure."
  type        = string
  default     = "Breno Kevin Xavier Silva"
}

variable "environment" {
  description = "Environment name (e.g., Development, Staging, Production)."
  type        = string
  default     = "Development"
}

# Subnet CIDR blocks
variable "subnet-cidr-block-public-01" {
  description = "CIDR block for Public Subnet 01."
  type        = string
  default     = "10.232.44.128/25"
}

variable "subnet-cidr-block-public-02" {
  description = "CIDR block for Public Subnet 02."
  type        = string
  default     = "10.232.44.0/25"
}

variable "subnet-cidr-block-private-01" {
  description = "CIDR block for Private Subnet 01."
  type        = string
  default     = "10.232.46.0/24"
}

variable "subnet-cidr-block-private-02" {
  description = "CIDR block for Private Subnet 02."
  type        = string
  default     = "10.232.45.0/24"
}

# Subnet names
variable "name-subnet-public-01" {
  description = "Name for Public Subnet 01."
  type        = string
  default     = "SUB-PUBLIC-DATACOSMO-01"
}

variable "name-subnet-public-02" {
  description = "Name for Public Subnet 02."
  type        = string
  default     = "SUB-PUBLIC-DATACOSMO-02"
}

variable "name-subnet-private-01" {
  description = "Name for Private Subnet 01."
  type        = string
  default     = "SUB-PRIVATE-DATACOSMO-01"
}

variable "name-subnet-private-02" {
  description = "Name for Private Subnet 02."
  type        = string
  default     = "SUB-PRIVATE-DATACOSMO-02"
}

# Network components
variable "name-internet-gateway" {
  description = "Name for the Internet Gateway."
  type        = string
  default     = "IGW-DATACOSMO"
}

variable "name-ngw" {
  description = "Name for the NAT Gateway."
  type        = string
  default     = "NGW-DATACOSMO"
}

variable "name-nat" {
  description = "Alias or tag name for the NAT resource."
  type        = string
  default     = "NAT-DATACOSMO"
}

variable "name-route-table-private" {
  description = "Name for the private route table."
  type        = string
  default     = "RT-PRIVATE-DATACOSMO"
}

variable "name-route-table-public" {
  description = "Name for the public route table."
  type        = string
  default     = "RT-PUBLIC-DATACOSMO"
}

variable "instance_type_DATACOSMO" {
  description = "EC2 instance type to be used for the cluster (e.g., t3a.medium)."
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID to be used for EC2 instances"
  type        = string
  default     = "ami-058a8a5ab36292159"
}

variable "my_ip" {
  description = "Your current IP address with /32 mask to allow SSH access"
  type        = string
  default     = "187.106.3.170/32"
}

variable "db-db_username" {
  description = "Username for RDS"
  type        = string
  default     = "datacosmo-user"
}

variable "db-db_password" {
  description = "Password for RDS"
  type        = string
  default     = "datacosmo-password"
  sensitive   = true
}

variable "db-db_name" {
  description = "Initial database name"
  type        = string
  default     = "rds-datacosmo"
}

variable "db-engine" {
  description = "Initial database name"
  type        = string
  default     = "mysql"
}

variable "db-version" {
  description = "Initial database name"
  type        = string
  default     = "8.0"
}

variable "db-instance_class" {
  description = "Initial database name"
  type        = string
  default     = "db.t4g.micro"
}

variable "db-storage" {
  description = "Initial database name"
  type        = number
  default     = 20
}

variable "db-port" {
  description = "Port database"
  type        = number
  default     = 3306
}

variable "db-identifier" {
  description = "Identifier name for the RDS instance"
  type        = string
  default     = "rds-datacosmo"
}

variable "key_pair_name" {
  description = "Key pair key name"
  type        = string
  default     = "bastion-key"
}

variable "key_pair_private_name" {
  description = "Key pair key name"
  type        = string
  default     = "private-ec2-key"
}