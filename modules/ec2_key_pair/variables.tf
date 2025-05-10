variable "key_name" {
  description = "Nome da Key Pair a ser criada"
  type        = string
}

variable "public_key" {
  description = "Chave pública existente (opcional). Se vazia, será gerada uma nova."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags a aplicar na Key Pair"
  type        = map(string)
  default     = {}
}