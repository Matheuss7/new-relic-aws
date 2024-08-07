variable "aws_region" {
  description = "A região AWS para implantar os recursos"
  type        = string
}

variable "newrelic_account_id" {
  description = "ID da Conta New Relic"
  type        = string
}

variable "newrelic_api_key" {
  description = "Chave API do New Relic"
  type        = string
}

variable "newrelic_region" {
  description = "Região do New Relic (US ou EU)"
  type        = string
}

variable "name" {
  description = "Nome do projeto ou conta que está sendo monitorada"
  type        = string
}

variable "s3_bucket_name" {
  description = "Nome do bucket S3"
  type        = string
}

variable "tags" {
  description = "Tags para aplicar aos recursos"
  type        = map(string)
}

variable "integration_exists" {
  description = "Indica se a integração do New Relic já existe"
  type        = bool
  default     = false
}
