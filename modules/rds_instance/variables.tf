variable "identifier" {
  type        = string
  description = "Unique identifier for the RDS instance"
}

variable "engine" {
  type        = string
  description = "Database engine (e.g., mysql, postgres)"
}

variable "engine_version" {
  type        = string
  description = "Version of the database engine"
}

variable "instance_class" {
  type        = string
  description = "Instance class (e.g., db.t3.micro)"
}

variable "allocated_storage" {
  type        = number
  description = "Storage in GB"
  default     = 20
}

variable "username" {
  type        = string
  description = "Master username"
}

variable "password" {
  type        = string
  description = "Master password"
  sensitive   = true
}

variable "db_name" {
  type        = string
  description = "Database name"
}

variable "port" {
  type        = number
  description = "Database port"
  default     = 3306
}

variable "publicly_accessible" {
  type        = bool
  description = "Whether the DB should have public access"
  default     = false
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security groups to associate with the RDS instance"
}

variable "db_subnet_group_name" {
  type        = string
  description = "DB Subnet Group name"
}

variable "tags" {
  type        = map(string)
  default     = {}
}