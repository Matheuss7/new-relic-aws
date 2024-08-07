output "newrelic_cloud_integration_push" {
  description = "ID da integração de push do New Relic"
  value       = module.newrelic.newrelic_cloud_integration_push
}

output "newrelic_cloud_integration_pull" {
  description = "ID da integração de pull do New Relic"
  value       = module.newrelic.newrelic_cloud_integration_pull
}

output "newrelic_aws_access_key" {
  description = "Chave de acesso API para o New Relic"
  value       = module.newrelic.newrelic_access_key
  sensitive   = true
}

output "newrelic_aws_bucket_arn" {
  description = "ARN do bucket S3"
  value       = module.s3_buckets.newrelic_aws_bucket_arn
}
