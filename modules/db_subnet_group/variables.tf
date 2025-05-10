variable "name" {
  description = "Name of the DB subnet group"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs (usually private)"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to the subnet group"
  type        = map(string)
  default     = {}
}