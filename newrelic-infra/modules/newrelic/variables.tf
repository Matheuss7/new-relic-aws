variable "name" {
  description = "Nome do projeto ou conta sendo monitorada"
  type        = string
}

variable "s3_bucket_name" {
  description = "Nome do bucket S3"
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

variable "iam_role_arn" {
  description = "ARN do Role IAM para o New Relic"
  type        = string
}

variable "iam_policy_attach" {
  description = "Anexo da Política IAM para o New Relic"
  type        = string
}
variable "integration_exists" {
  description = "Indica se a integração do New Relic já existe"
  type        = bool
  default     = false
}
