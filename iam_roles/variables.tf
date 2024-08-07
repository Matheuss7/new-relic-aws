variable "name" {
  description = "Nome do projeto ou conta sendo monitorada"
  type        = string
}

variable "newrelic_account_id" {
  description = "ID da Conta do New Relic"
  type        = string
}

variable "tags" {
  description = "Tags para aplicar aos recursos"
  type        = map(string)
}
