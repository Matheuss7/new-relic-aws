variable "name" {
  description = "Nome único para a implantação"
  type        = string
}

variable "newrelic_region" {
  description = "Região do New Relic (US ou EU)"
  type        = string
}

variable "newrelic_access_key" {
  description = "Chave de acesso API para o New Relic"
  type        = string
}

variable "s3_bucket_arn" {
  description = "ARN do bucket S3"
  type        = string
}

variable "firehose_exists" {
  description = "Indica se o Firehose Stream já existe"
  type        = bool
  default     = false
}
