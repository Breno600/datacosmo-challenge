variable "ami_id" {
  description = "AMI ID to launch"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet ID to launch instance into (public or private)"
  type        = string
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP (true for public subnet)"
  type        = bool
  default     = false
}

variable "security_group_ids" {
  description = "List of security groups to associate"
  type        = list(string)
}

variable "key_name" {
  description = "Key Pair name"
  type        = string
}

variable "name" {
  description = "Name tag for the instance"
  type        = string
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
