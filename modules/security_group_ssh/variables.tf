variable "name" {
  description = "Name of the security group"
  type        = string
}

variable "description" {
  description = "Description of the security group"
  type        = string
  default     = "Allow SSH only from specified IP"
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "allowed_ip" {
  description = "IP address (with /32) allowed to access port 22"
  type        = string
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}